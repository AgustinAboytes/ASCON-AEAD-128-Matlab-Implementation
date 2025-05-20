function IV = prepare_iv(key, nonce)
    % Par�metros espec�ficos del algoritmo
    key_size_bits = length(key) * 8;
    nonce_size_bits = length(nonce) * 8;
    rounds_A = 12;
    rounds_B = 12;
    zero_padding = zeros(1, 20 - length(key), 'uint8');
    
    % Preparar el vector de inicializaci�n (IV)
    IV = [key_size_bits, nonce_size_bits, rounds_A, rounds_B];
    IV = [IV, zero_padding, key, nonce];
    IV = uint8(IV);  % Asegurarse de que el vector IV est� en formato uint8
end