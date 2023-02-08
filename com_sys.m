function [ber_zf, ber_vblast] = com_sys(numTx, numRx, symbols, modOrder, snr)

% array of ones with length equal to number of tx antennas
deltas = ones(1,numTx);
% number of symbols transmitte
numSymbol = length(symbols);
%length of snr vector
lenSnr = length(snr);

%% Modulation
% modulate input signal x using QAM with specified modulation order M
xmod = qammod(symbols, modOrder);

% reshape xmod into a matrix with number of rows equal to number of tx antennas and 
% number of columns equal to number of symbols/number of tx antennas
xmod=reshape(xmod,numTx,numSymbol/numTx);

% Kronecker tensor product of xmod and deltas
xmod=kron(xmod,deltas);

% % Rayleigh channel
% initialize the matrix h to represent Rayleigh channel fading
% each row of h represents a fading channel between a tx antenna and a rx antenna
% generate a random channel for each fading channel using normal distribution
h = (1/sqrt(2)) * (randn(numTx * numRx, numSymbol/numRx) + 1i * randn(numTx * numRx, numSymbol/numRx));

% reshape h into a matrix with number of rows equal to number of tx antennas and number of columns equal to number of symbols
H = reshape(h, numTx, numSymbol);

% calculate the dot product of H and xmod and sum on the columns
tmp = sum(H .* xmod,1);

% reshape the result into a matrix with number of rows equal to number of rx antennas and number of columns equal to number of symbols/number of rx antennas
y = reshape(tmp, numRx, numSymbol/numRx);

% reshape h into a 3D matrix with dimensions equal to number of tx antennas, number of rx antennas, and number of symbols/number of rx antennas
H=reshape(h,numTx,numRx,numSymbol/numRx);

%% Receiver
    for k=1:lenSnr % loop through each snr value
        % generate noise signal
        N1 = 1 / sqrt(2) * (randn(1,numSymbol)+1i * randn(1,numSymbol)); 
        % reshape the noise signal
        N1 = reshape(N1, numRx, numSymbol/numRx); 
         
        % add noise to received signal
        ynoisy=y+10^(-(snr(k)-10 * log10(modOrder))/20) *N1; 
        % reshape the received signal with noise
        ynoisy=reshape(ynoisy,numRx,1,numSymbol/numRx); 
    
        % --------------------- VBLAST --------------------- %     
        y_final_vblast = vblast_demodulation(ynoisy, H, numSymbol, numRx);
        y_final_vblast = reshape(y_final_vblast, 1, []); 
        
        % Calculate the symbol error rate
        [~, tmp_ser_vb]=symerr(symbols,y_final_vblast); 
        ber_vblast(k)=tmp_ser_vb/log2(modOrder);     
        % -------------------------------------------------- %
        
        
        % ----------------------- ZF ----------------------- %
        % Compute received signal matrix using zero_forcing_equalization function
        rcvd_zf = zero_forcing_equalization(numSymbol, numRx, H, ynoisy);
        
        % Demodulate the received signal
        y_final_zf = qamdemod(reshape(rcvd_zf, 1, numSymbol), modOrder);
        % Calculate the symbol error rate
        [~, tmp_ser_zf] = symerr(symbols, y_final_zf);
        ber_zf(k) = tmp_ser_zf / log2(modOrder);
        % -------------------------------------------------- %
        
    end
end