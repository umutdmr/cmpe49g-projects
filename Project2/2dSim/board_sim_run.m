clear
%% Set Parameters

sim_params.rx_center                = [0, 0];
sim_params.rx_r_inMicroMeters       = 5;
sim_params.rx_tx_distance           = 5;
sim_params.tx_emission_pt           = [sim_params.rx_center(:, 1) + sim_params.rx_r_inMicroMeters + sim_params.rx_tx_distance, 0];
sim_params.D_inMicroMeterSqrPerSecond = 75;
sim_params.reflecting_line_eqn_A = 1;
sim_params.reflecting_line_eqn_B = 0;
sim_params.reflecting_line_eqn_C = -15;
sim_params.reflection_strategy = 'reflection_wrt_line';

sim_params.tend                     = 0.6;
sim_params.delta_t                  = 0.0001;
sim_params.num_molecules            = 50000;

%% SIMULATE

fprintf('\nSimulation <sim_gaussianRW_Point2Circular_FFP_2D> \t\t[START]')
tstart = tic;
[nrx_sim_timeline, time] = sim_gaussianRW_Point2Circular_FFP_2D(sim_params);
fprintf('\nSimulation <sim_gaussianRW_Point2Circular_FFP_2D> \t\t[End] \tDuration = %f\n', toc(tstart))

%% PLOT

hFig = figure;
set(gcf,'PaperPositionMode','auto')
set(hFig, 'Position', [0 101 600 400])

cumulative_sim_signal = cumsum(nrx_sim_timeline)/sim_params.num_molecules;

plot(time, cumulative_sim_signal, '-', 'LineWidth', 2)
hold on
grid on
xlabel('Time - (s)')
ylabel('Cumulative Fraction of Received Molecules')
legend('Simulation');
title(['r_{rx}=', num2str(sim_params.rx_r_inMicroMeters), '; dist=', num2str(sim_params.rx_tx_distance), '; D=', num2str(sim_params.D_inMicroMeterSqrPerSecond)])


