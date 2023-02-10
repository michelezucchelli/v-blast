# V-BLAST Algorithm Matlab Implementation
## Code Overview
This MATLAB code is used to simulate the BER of a communication system using two different decoding algorithms: V-BLAST and Zero-Forcing. The code starts by defining the number of transmit (Tx) and receive (Rx) antennas and the modulation order. The number of symbols transmitted is also defined (in order to guarantee a good plot, the number of symbols is defined as 6144 * 128 = 786432). Next, the code generates an array of signal-to-noise ratio (SNR) values from snr_min to snr_max. Random symbols to be transmitted are then generated.
The code then performs a series of simulations for different Tx-Rx configurations (2x2, 4x4, 8x8, 16x16, 32x32, 64x64 and 128x128), each time calling the function com_sys with the corresponding number of Tx and Rx antennas, the transmitted symbols, modulation order, and SNR array. The function com_sys computes the BER for both V-BLAST and ZF decoding and returns the results.
Finally, the code plots the results of the BER for each Tx-Rx configuration, using a semilogarithmic scale, and compares the results between V-BLAST and ZF.

The com_sys function starts by modulating the input symbols using 16-QAM. Then, models a Rayleigh channel between the transmit and receive antennas. Adds noise to the received signal. Finally, for every SNR value considered, the function demodulates the received signal using VBLAST and ZF (vblast_decoding and zero_forcing_decoding functions are used), and calculates the BER for both systems.


