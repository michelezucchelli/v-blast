function y_final = vblast_decoding(num_symbols, numRx, H, ynoisy)
    % initialize final demodulated signal
    y_final = zeros(numRx, num_symbols/numRx);

    % loop through each symbol
    for l = 1:num_symbols/numRx
        % initialize r_counter to keep track of selected receive antennas
        r_counter = zeros(numRx,1);
        
        % get the received signal for this symbol
        r = ynoisy(:,:,l);
        
        % get the channel matrix for this symbol
        Heq = transpose(H(:,:,l));
        % initialize the demodulated symbol for this symbol
        ydemod = zeros(numRx, 1);
        
        % loop through each receive antenna
        for p = 1:numRx
            % calculate the pseudo-inverse of Heq
            B = pinv(Heq); 
            % calculate the magnitude square of B
            b = sum(abs(B) .^ 2, 2);
            % add the values in r_counter to the values in b
            b = b + reshape(r_counter, numRx, 1);
           
            % find the minimum value of b and its index
            [~, dd] = min(b,[],1);
            
            % set the corresponding value in r_counter to 100 indicating
            % that this receive antenna has already been selected
            r_counter(dd) = 100;
            
            % demodulate the received signal
            temp = qamdemod(B(dd,:) * r,16); 
            % store the demodulated symbol
            ydemod(dd) = temp; 
            % update the received signal
            r = r - qammod(temp,16) .* Heq(:,dd); 
            
            % set the corresponding column in Heq to 0 to indicate that 
            % this receive antenna has been processed and should not be 
            % selected again
            Heq(:,dd) = 0; 
        end
        % add the demodulated symbols to the final demodulated signal
        y_final(:,l) = ydemod;
    end
end

%% Function Description
% Function that implements the V-BLAST demodulation algorithm for a received 
% signal corrupted by noise. The function takes four inputs:
% 
% - ynoisy: a noisy received signal with dimensions (numRx, 1, 
% num_symbols/numRx) where numRx is the number of receiving antennas and 
% - num_symbols is the total number of symbols transmitted.
% - H: the channel matrix with dimensions (numTx, numRx, num_symbols/numRx) 
% where numTx is the number of transmitting antennas.
% - num_symbols: a scalar indicating the total number of symbols transmitted.
% - numRx: a scalar indicating the number of receiving antennas.
% The function returns the final demodulated signal, y_final, which is a 
% vector of demodulated symbols. The algorithm works as follows:
% 
% 1 - Initialize the final demodulated signal to a 2D vector of zeros.
% 2 - Loop through each symbol in the received signal (ynoisy).
% 3 - Initialize a counter r_counter to keep track of the selected receive 
% antennas.
% 4 - Get the received signal for this symbol and the channel matrix for this 
% symbol.
% 5 - Initialize the demodulated symbol for this symbol to an array of zeros.
% 6 - Loop through each receive antenna.
% 7 - Calculate the pseudo-inverse of the channel matrix.
% 8 - Calculate the magnitude square of the pseudo-inverse.
% 9 - Sum half of the columns of the magnitude square of the pseudo-inverse.
% 10 - Add the values in r_counter to the values in b.
% 11 - Find the minimum value of b and its index.
% 12 - Set the corresponding value in r_counter to 100 to indicate that this 
% receive antenna has already been selected.
% 13 - Demodulate the received signal using the selected receive antenna.
% 14 - Update the received signal by subtracting the modulated symbol from the 
% received signal.
% 15 - Set the corresponding column in the channel matrix to 0 to indicate that 
% this receive antenna has been processed and should not be selected again.
% 16 - Add the demodulated symbols to the final demodulated signal.
% 17 - Repeat the process for all symbols.
