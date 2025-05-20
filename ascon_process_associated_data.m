function S = ascon_process_associated_data(S, associateddata)
    rate = 8;  % Tamaño del bloque en bytes

    if ~isempty(associateddata)
        % Padding de Datos Asociados
        a_padding = [associateddata, uint8(128), zero_bytes(rate - mod(length(associateddata) + 1, rate))];
        % Procesamiento de cada bloque de datos asociados
        for block = 1:rate:length(a_padding) - rate
            S(1) = bitxor(S(1), bytes_to_int(a_padding(block:block+7)));
            S = ascon_permutation(S, 12);
        end
    end
    % Marcar el final del procesamiento de datos asociados
    S(5) = bitxor(S(5), uint64(1));
end

% function zeroBytes = zero_bytes(n)
%     zeroBytes = uint8(zeros(1, n));
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