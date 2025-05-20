function [S, ciphertext] = ascon_process_plaintext(S, plaintext)
    rate = 8;  % Tamaño del bloque en bytes
    ciphertext = uint8([]);

    % Procesar cada bloque de texto plano
    for block = 1:rate:length(plaintext) - rate + 1
        Pi = bytes_to_int(plaintext(block:min(block+rate-1, length(plaintext))));
        Ci = bitxor(S(1), Pi);
        ciphertext = [ciphertext, int_to_bytes(Ci, rate)];
        S(1) = Ci;
        S = ascon_permutation(S, 12);
    end

    % Procesar el último bloque
    p_lastlen = mod(length(plaintext), rate);
    if p_lastlen > 0
        Pi = bytes_to_int([plaintext(end-p_lastlen+1:end), zeros(1, rate - p_lastlen, 'uint8')]);
        Ci = bitxor(S(1), Pi);
        ciphertext = [ciphertext, int_to_bytes(Ci, 8, 'left', p_lastlen)];
        S(1) = bitxor(Ci, uint64(128) * 2^(64 - p_lastlen*8));
    end
end

% function intVal = bytes_to_int(byteArray)
%     % Convertir una matriz de bytes en un entero de 64 bits
%     intVal = uint64(0);
%     for i = 1:length(byteArray)
%         intVal = intVal + bitshift(uint64(byteArray(i)), 8 * (length(byteArray) - i));
%     end
% end

% function byteArray = int_to_bytes(integer, nbytes, direction, lastlen)
%     if nargin < 3
%         direction = 'right';
%     end
%     if nargin < 4
%         lastlen = nbytes;
%     end
%     byteArray = zeros(1, nbytes, 'uint8');
%     for i = 1:lastlen
%         if strcmp(direction, 'left')
%             byteArray(i) = bitand(bitshift(integer, -(i-1)*8), 255);
%         else
%             byteArray(nbytes - i + 1) = bitand(bitshift(integer, -(i-1)*8), 255);
%         end
%     end
% end

% function S = ascon_permutation(S, rounds)
%     for r = 12-rounds:11
%         S(3) = bitxor(S(3), uint64(240 - r * 16 + r));
% 
%         % Capa de sustitución
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
%         % Capa de difusión lineal
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