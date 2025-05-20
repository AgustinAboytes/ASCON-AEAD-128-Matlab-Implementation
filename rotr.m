function out = rotr(val, r)
    out = bitor(bitshift(val, -r), bitshift(bitand(val, uint64(2^r - 1)), 64 - r));
end