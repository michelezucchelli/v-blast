clc;
clear all;
close all;
%% 
% Init

% % number of tx and rx antennas
numTx = [2,4,8,16,32,64,128];
numRx = [2,4,8,16,32,64,128];
% number of scenarios
scenario_num = length(numTx);

% modulation order (16-QAM)
M = 16;

% number of transmitted symbols (the larger the more precise the results will be)
num_symbols = 98304*numTx;

% points to plot
points = 10;
% Min and Max Eb/N0
eb_n0_min = 8;
eb_n0_max = 18;
% generates an array of Eb/N0 values in the range [eb_n0_min, eb_n0_max] with a length equal to points
eb_n0 = linspace(eb_n0_min,eb_n0_max,points);

% Initialize Bit Error Rate vector for ZF and V-BLAST
ber_zf = zeros(scenario_num, points);
ber_vblast = zeros(scenario_num, points);
%% 
fprintf("Scenario 1 : 2x2 Tx-Rx\n");

% simulation index
index_sim = 1;

% Compute the ber
[ber_zf(index_sim,:), ber_vblast(index_sim,:)] = com_sys(numTx(index_sim), numRx(index_sim), num_symbols(index_sim), M, eb_n0);

% plot the results
fig22 = figure;
semilogy(eb_n0,ber_vblast(index_sim,:),'g-o');
hold on;
semilogy(eb_n0,ber_zf(index_sim,:),'r-o');
hold off
xlim([eb_n0_min-3, eb_n0_max+3])
ylim([10^-6, 10^-1])
title({ strcat('BER for: ', num2str(numTx(index_sim)), 'x' , num2str(numRx(index_sim)), ' Antennas')})
legend('V-Blast','Zero-Forcing');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
grid on
saveas(fig22,'2x2.jpg');
fprintf("Printed 2x2\n");
%% 
fprintf("Scenario 2: 4x4 Tx-Rx\n");

% simulation index
index_sim = 2;

% Compute the ber
[ber_zf(index_sim,:), ber_vblast(index_sim,:)] = com_sys(numTx(index_sim), numRx(index_sim), num_symbols(index_sim), M, eb_n0);


% plot the results
fig44 = figure;
semilogy(eb_n0,ber_vblast(index_sim,:),'g-o');
hold on;
semilogy(eb_n0,ber_zf(index_sim,:),'r-o');
hold off
xlim([eb_n0_min-3, eb_n0_max+3])
ylim([10^-6, 10^-1])
title({ strcat('BER for: ', num2str(numTx(index_sim)), 'x' , num2str(numRx(index_sim)), ' Antennas')})
legend('V-Blast','Zero-Forcing');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
grid on
saveas(fig44,'4x4.jpg');
fprintf("Printed 4x4\n");
%% 
fprintf("Scenario 3: 8x8 Tx-Rx\n");
% simulation index
index_sim = 3;

% Compute the ber

[ber_zf(index_sim,:), ber_vblast(index_sim,:)] = com_sys(numTx(index_sim), numRx(index_sim), num_symbols(index_sim), M, eb_n0);

% plot the results
fig88 = figure;
semilogy(eb_n0,ber_vblast(index_sim,:),'g-o');
hold on;
semilogy(eb_n0,ber_zf(index_sim,:),'r-o');
hold off
xlim([eb_n0_min-3, eb_n0_max+3])
ylim([10^-6, 10^-1])
title({ strcat('BER for: ', num2str(numTx(index_sim)), 'x' , num2str(numRx(index_sim)), ' Antennas')})
legend('V-Blast','Zero-Forcing');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
grid on
saveas(fig88,'8x8.jpg');
fprintf("Printed 8x8\n");
%% 
fprintf("Scenario 4: 16x16 Tx-Rx\n");

% simulation index
index_sim = 4;

% Compute the ber
[ber_zf(index_sim,:), ber_vblast(index_sim,:)] = com_sys(numTx(index_sim), numRx(index_sim), num_symbols(index_sim), M, eb_n0);

% plot the results
fig1616 = figure;
semilogy(eb_n0,ber_vblast(index_sim,:),'g-o');
hold on;
semilogy(eb_n0,ber_zf(index_sim,:),'r-o');
hold off
xlim([eb_n0_min-3, eb_n0_max+3])
ylim([10^-6, 10^-1])
title({ strcat('BER for: ', num2str(numTx(index_sim)), 'x' , num2str(numRx(index_sim)), ' Antennas')})
legend('V-Blast','Zero-Forcing');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
grid on
saveas(fig1616,'16x16.jpg');
fprintf("Printed 16x16\n");
%% 
fprintf("Scenario 5: 32x32 Tx-Rx\n");

% simulation index
index_sim = 5;

% Compute the ber
[ber_zf(index_sim,:), ber_vblast(index_sim,:)] = com_sys(numTx(index_sim), numRx(index_sim), num_symbols(index_sim), M, eb_n0);

% plot the results
fig3232 = figure;
semilogy(eb_n0,ber_vblast(index_sim,:),'g-o');
hold on;
semilogy(eb_n0,ber_zf(index_sim,:),'r-o');
hold off
xlim([eb_n0_min-3, eb_n0_max+3])
ylim([10^-6, 10^-1])
title({ strcat('BER for: ', num2str(numTx(index_sim)), 'x' , num2str(numRx(index_sim)), ' Antennas')})
legend('V-Blast','Zero-Forcing');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
grid on
saveas(fig3232,'32x32.jpg');
fprintf("Printed 32x32\n");
%% 
fprintf("Scenario 6: 64x64 Tx-Rx\n");

% simulation index
index_sim = 6;

% Compute the ber
[ber_zf(index_sim,:), ber_vblast(index_sim,:)] = com_sys(numTx(index_sim), numRx(index_sim), num_symbols(index_sim), M, eb_n0);

% plot the results
fig6464 = figure;
semilogy(eb_n0,ber_vblast(index_sim,:),'g-o');
hold on;
semilogy(eb_n0,ber_zf(index_sim,:),'r-o');
hold off
xlim([eb_n0_min-3, eb_n0_max+3])
ylim([10^-6, 10^-1])
title({ strcat('BER for: ', num2str(numTx(index_sim)), 'x' , num2str(numRx(index_sim)), ' Antennas')})
legend('V-Blast','Zero-Forcing');
xlabel('Eb/N0 (dB)');
ylabel('Bit Error Rate');
grid on
saveas(fig6464,'64x64.jpg');
fprintf("Printed 64x64\n");