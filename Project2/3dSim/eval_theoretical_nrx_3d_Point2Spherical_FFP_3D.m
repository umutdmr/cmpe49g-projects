function [ nrx_cumulative ] = eval_theoretical_nrx_3d_Point2Spherical_FFP_3D( sim_params, time )

dist            = sim_params.rx_tx_distance;
rx_r            = sim_params.rx_r_inMicroMeters;
D               = sim_params.D_inMicroMeterSqrPerSecond;

part1 = rx_r / (dist + rx_r);
nrx_cumulative = part1 * erfc(dist./sqrt(4*D*time));

end

