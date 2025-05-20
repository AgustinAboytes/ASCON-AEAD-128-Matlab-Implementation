function S = bytes_to_state(bytes)
    % Convertir una matriz de bytes a un estado de 5 palabras de 64 bits
    S = zeros(1, 5, 'uint64');
    for i = 1:5
        S(i) = bytes_to_int(bytes((8*(i-1)+1):(8*i)));
    end
end