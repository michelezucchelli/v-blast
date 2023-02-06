function y_final = vblast_demodulation(y_noisy, H, num_symbols, numRx)
    % initialize final demodulated signal
    y_final = [];
    
    % loop through each symbol
    for l = 1:num_symbols/numRx
        % initialize r_counter to keep track of selected receive antennas
        r_counter = zeros(numRx,1);
        
        % get the received signal for this symbol
        r = y_noisy(:,:,l);
        
        % get the channel matrix for this symbol
        Heq = transpose(H(:,:,l));
        % initialize the demodulated symbol for this symbol
        ydemod = zeros(numRx, 1);
        
        % loop through each receive antenna
        for p = 1:numRx
            B = pinv(Heq); % calculate the pseudo-inverse of Heq
            b = abs(B .* B); % calculate the magnitude square of B
            
            % sum the values of half of the columns
            temp_sum = zeros(numRx, 1); 
            for q = 1:numRx/2
                temp_sum = temp_sum + b(:,q);
            end
            b = temp_sum;
            % add the values in r_counter to the values in b
            b = b + r_counter;
            % find the minimum value of b and its index
            [~, dd] = min(b,[],1);
            
            % set the corresponding value in r_counter to 100
            % indicating that this receive antenna has already been selected
            r_counter(dd) = 100;
            
            temp = qamdemod(B(dd,:) * r,16); % demodulate the received signal
            ydemod(dd) = temp; % store the demodulated symbol
            r = r - qammod(temp,16) .* Heq(:,dd); % update the received signal
            
            % set the corresponding column in Heq to 0 to indicate that 
            % this receive antenna has been processed and should not be selected again
            Heq(:,dd) = 0; 
        end
        % add the demodulated symbols to the final demodulated signal
        y_final = [y_final, ydemod];
    end
end
