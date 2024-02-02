%% Set Parameters

sim_params.rx_center                = [0, 0, 0];
sim_params.rx_r_inMicroMeters       = 5;
sim_params.rx_tx_distance           = 5;
sim_params.tx_emission_pt           = [10, 0, 0];
sim_params.D_inMicroMeterSqrPerSecond = 200;

sim_params.tend                     = 0.4;
sim_params.delta_t                  = 0.0001;
sim_params.num_molecules            = 50000;

%% SIMULATE

fprintf('\nSimulation <sim_gaussianRW_Point2Spherical_FFP_3D> \t\t[START]')
tstart = tic;
[nrx_sim_timeline, time] = sim_gaussianRW_Point2Spherical_FFP_3D(sim_params);
fprintf('\nSimulation <sim_gaussianRW_Point2Spherical_FFP_3D> \t\t[End] \tDuration = %f\n', toc(tstart))


%% THEORETICAL NRX

fprintf('\nTheoretical Formula \t\t[START]')
tstart = tic;
[nrx_theory_timeline] = eval_theoretical_nrx_3d_Point2Spherical_FFP_3D(sim_params, time);
fprintf('\nTheoretical Formula  \t\t[End] \tDuration = %f\n', toc(tstart))


%% PLOT

hFig = figure;
set(gcf,'PaperPositionMode','auto')
set(hFig, 'Position', [0 101 600 400])

cumulative_sim_signal = cumsum(nrx_sim_timeline)/sim_params.num_molecules;
cumulative_theory_signal = nrx_theory_timeline;

plot(time, cumulative_sim_signal, '-', 'LineWidth', 2)
hold on
plot(time, cumulative_theory_signal, '--', 'LineWidth', 2)
grid on
xlabel('Time - (s)')
ylabel('Cumulative Fraction of Received Molecules')
legend('Simulation', 'Theory');
title(['r_{rx}=', num2str(sim_params.rx_r_inMicroMeters), '; dist=', num2str(sim_params.rx_tx_distance), '; D=', num2str(sim_params.D_inMicroMeterSqrPerSecond)])


