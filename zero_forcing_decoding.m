function rcvd = zero_forcing_decoding(num_symbols, numRx, H, ynoisy)
    rcvd = zeros(numRx, num_symbols/numRx);

    for k = 1:num_symbols/numRx
        % Calculate the pseudo inverse of the transpose of the k-th channel matrix
        B = pinv(H(:,:,k).');
        % Perform zero-forcing equalization
        rcvd(:,k) = B * ynoisy(:,k);
    end
end


%% Function Description
% The code starts by initializing a 2-dimensional matrix rcvd to store the
% decoded symbols.
% 
% In the for loop, the code performs zero-forcing equalization for each 
% symbol. The pseudo-inverse of the transpose of the k-th channel matrix is 
% calculated using the pinv function. The zero-forcing equalization is 
% performed by multiplying the pseudo-inverse of the transpose of the k-th 
% channel matrix and the k-th column of the received signal. The result of 
% this calculation is stored in the k-th column of the rcvd matrix.
% 
% The final result of the code is the rcvd matrix, which contains the 
% decoded symbols.