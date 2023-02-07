function rcvd = zero_forcing_equalization(num_symbols, numRx, H, ynoisy)
    rcvd = []; % Initialize an empty rcvd matrix

    % Loop through each symbol
    for l = 1:num_symbols/numRx
        % Transpose the l-th channel matrix
        Heq = transpose(H(:,:,l));
        % Calculate the pseudo inverse of Heq
        B = pinv(Heq);
        % Perform zero-forcing equalization
        rcvd = [rcvd, B * ynoisy(:,:,l)]; % Concatenate the result of zero-forcing equalization to rcvd matrix
    end
end


%% Function Description
% Function that performs zero-forcing equalization on a noisy received 
% signal ynoisy given as input. It returns the final equalized signal in rcvd.
% - num_symbols and numRx are scalars indicating the total number of 
% symbols transmitted and the number of receiving antennas.
% - H is the channel matrix that represents the wireless communication 
% channel.
% - ynoisy is the noisy received signal, where each ynoisy(:,:,l) represents 
% the l-th symbol in the received signal.
% 
% The function performs the following steps:
% 1 - Initialize an empty matrix rcvd to store the equalized signal.
% 2 - Loop through each symbol in the received signal.
% 3 - For each symbol, calculate the transpose of the l-th channel matrix 
% and store it in Heq.
% 4 - Calculate the pseudo inverse of Heq and store it in B.
% 5 - Perform zero-forcing equalization by multiplying B with the 
% corresponding symbol in the noisy received signal, ynoisy(:,:,l).
% 6 - Concatenate the result of zero-forcing equalization to the rcvd 
% matrix.
% 7 - Repeat the above steps for each symbol in the received signal.
% Finally, the function returns the final equalized signal in rcvd.