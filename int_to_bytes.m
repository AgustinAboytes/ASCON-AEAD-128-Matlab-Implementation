function byteArray = int_to_bytes(integer, nbytes, direction, lastlen)
    if nargin < 3
        direction = 'right';
    end
    if nargin < 4
        lastlen = nbytes;
    end
    byteArray = zeros(1, nbytes, 'uint8');
    for i = 1:lastlen
        if strcmp(direction, 'left')
            byteArray(i) = bitand(bitshift(integer, -(i-1)*8), 255);
        else
            byteArray(nbytes - i + 1) = bitand(bitshift(integer, -(i-1)*8), 255);
        end
    end
end