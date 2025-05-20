function tag = ascon_finalize(S, key)
    % Mezcla de la clave
    S(4) = bitxor(S(4), bytes_to_int(key(1:8)));
    S(5) = bitxor(S(5), bytes_to_int(key(9:16)));
    
    % Aplicar la permutación final
    S = ascon_permutation(S, 12);
    
    % Generación de la etiqueta (tag)
    tag = [int_to_bytes(S(4), 8), int_to_bytes(S(5), 8)];
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