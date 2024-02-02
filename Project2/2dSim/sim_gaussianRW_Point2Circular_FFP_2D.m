function [ cumulative_signal, time ] = sim_gaussianRW_Point2Circular_FFP_2D( sim_params )

rx_center                   = sim_params.rx_center;
rx_r_inMicroMeters          = sim_params.rx_r_inMicroMeters;

tx_emission_pt              = sim_params.tx_emission_pt;
D                           = sim_params.D_inMicroMeterSqrPerSecond;

a                = sim_params.reflecting_line_eqn_A;
b                = sim_params.reflecting_line_eqn_B;
c                = sim_params.reflecting_line_eqn_C;

strategy         = sim_params.reflection_strategy;

tend                = sim_params.tend;
delta_t             = sim_params.delta_t;
num_molecules       = sim_params.num_molecules;

% Standard deviation of step size of movement N(0,sigma)
sigma = (2*D*delta_t)^0.5;

% Square of the Rx Radius is useful for checking the hit action, it doesn't change so evaluating once is enough
rx_membrane_sq = rx_r_inMicroMeters^2;


sim_step_count = round(tend/delta_t);
cumulative_signal = zeros (1, sim_step_count); % we are using only one-type of molecule

% Create molecules with INITIAL Coords: replicate num_molecules times
mol_coords_BEFORE_movement = repmat(tx_emission_pt, num_molecules, 1);

for ii = 1:sim_step_count

    %%% You need to implement a function named eval_line_sign() that evaluates the sign
    sign_of_mol_cords_BEFORE_movement = eval_line_sign(mol_coords_BEFORE_movement, a, b, c);

    mol_displacement = normrnd(0, sigma, size(mol_coords_BEFORE_movement));
    mol_cords_AFTER_movement = mol_coords_BEFORE_movement + mol_displacement;

    %%% Check for Sign Difference to Detect Hitting to the Line
    sign_of_mol_cords_AFTER_movement = eval_line_sign(mol_cords_AFTER_movement, a, b, c);
    
    %calculates the square of the distances between molecules to the Rx Center 
    dist_sq_2_rcv_center = sum(bsxfun(@minus, mol_cords_AFTER_movement, rx_center).^2, 2);
    
    %checks if the molecules are outside of the receiver (NOT HIT)
    outside_rx_membrane_mask = dist_sq_2_rcv_center > rx_membrane_sq;
    
    %calculate the hit of molecules to the receiver (FOR THIS SIM STEP, NOT TOTAL)
    cumulative_signal(ii) = cumulative_signal(ii) + sum(~outside_rx_membrane_mask);
    
    
    
    hitting_to_line_signs_mult = (sign_of_mol_cords_BEFORE_movement .* sign_of_mol_cords_AFTER_movement);
    hitting_to_line_mask = hitting_to_line_signs_mult < 0; % means signs differ BEFORE and AFTER
    

    if isequal(strategy, 'roll-back')
        % Roll-back means setting the current coordinate to PREV coordinate
        mol_cords_AFTER_movement(hitting_to_line_mask, :) = mol_coords_BEFORE_movement(hitting_to_line_mask, :);
    else
        mol_cords_AFTER_movement(hitting_to_line_mask, :) = reflect(a,b,c, mol_cords_AFTER_movement(hitting_to_line_mask, :));
    end
    % Just keep the ones that did NOT hit, and do same things again
    mol_coords_BEFORE_movement = mol_cords_AFTER_movement(outside_rx_membrane_mask, :);

time = delta_t:delta_t:tend;

end




