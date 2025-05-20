function intVal = bytes_to_int(byteArray)
    % Convertir una matriz de bytes en un entero de 64 bits
    intVal = uint64(0);
    for i = 1:length(byteArray)
        intVal = intVal + bitshift(uint64(byteArray(i)), 8 * (length(byteArray) - i));
    end
end