function S = ascon_initialize(key, nonce)
    % Preparar el vector de inicialización
    IV = prepare_iv(key, nonce);

    % Convertir el vector de inicialización al estado inicial
    S = bytes_to_state(IV);

    % Aplicar la permutación inicial
    S = ascon_permutation(S, 12);

    % Mezcla de la clave
    zero_key = bytes_to_state([zero_bytes(40 - length(key)), key]);
    S(1) = bitxor(S(1), zero_key(1));
    S(2) = bitxor(S(2), zero_key(2));
    S(3) = bitxor(S(3), zero_key(3));
    S(4) = bitxor(S(4), zero_key(4));
    S(5) = bitxor(S(5), zero_key(5));
end

% function IV = prepare_iv(key, nonce)
%     % Parámetros específicos del algoritmo
%     key_size_bits = length(key) * 8;
%     nonce_size_bits = length(nonce) * 8;
%     rounds_A = 12;
%     rounds_B = 12;
%     zero_padding = zeros(1, 20 - length(key), 'uint8');
%     
%     % Preparar el vector de inicialización (IV)
%     IV = [key_size_bits, nonce_size_bits, rounds_A, rounds_B];
%     IV = [IV, zero_padding, key, nonce];
%     IV = uint8(IV);  % Asegurarse de que el vector IV esté en formato uint8
% end

% function S = bytes_to_state(bytes)
%     % Convertir una matriz de bytes a un estado de 5 palabras de 64 bits
%     S = zeros(1, 5, 'uint64');
%     for i = 1:5
%         S(i) = bytes_to_int(bytes((8*(i-1)+1):(8*i)));
%     end
% end

% function intVal = bytes_to_int(byteArray)
%     % Convertir una matriz de bytes en un entero de 64 bits
%     intVal = uint64(0);
%     for i = 1:length(byteArray)
%         intVal = intVal + bitshift(uint64(byteArray(i)), 8 * (length(byteArray) - i));
%     end
% end

% function S = ascon_permutation(S, rounds)
%     for r = 12-rounds:11
%         S(3) = bitxor(S(3), uint64(240 - r * 16 + r));
% 
%         % Substitution layer
%         S(1) = bitxor(S(1), S(5));
%         S(5) = bitxor(S(5), S(4));
%         S(3) = bitxor(S(3), S(2));
%         T = bitand(bitxor(S, uint64(18446744073709551615)), circshift(S, -1));
%         S = bitxor(S, circshift(T, 1));
%         S(2) = bitxor(S(2), S(1));
%         S(1) = bitxor(S(1), S(5));
%         S(4) = bitxor(S(4), S(3));
%         S(3) = bitxor(S(3), uint64(18446744073709551615));
% 
%         % Linear diffusion layer
%         S(1) = bitxor(S(1), bitxor(rotr(S(1), 19), rotr(S(1), 28)));
%         S(2) = bitxor(S(2), bitxor(rotr(S(2), 61), rotr(S(2), 39)));
%         S(3) = bitxor(S(3), bitxor(rotr(S(3), 1), rotr(S(3), 6)));
%         S(4) = bitxor(S(4), bitxor(rotr(S(4), 10), rotr(S(4), 17)));
%         S(5) = bitxor(S(5), bitxor(rotr(S(5), 7), rotr(S(5), 41)));
%     end
% end

% function out = rotr(val, r)
%     out = bitor(bitshift(val, -r), bitshift(bitand(val, uint64(2^r - 1)), 64 - r));
% end

% function zeroBytes = zero_bytes(n)
%     zeroBytes = uint8(zeros(1, n));
% end