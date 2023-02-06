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
