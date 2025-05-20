function S = ascon_permutation(S, rounds)
    for r = 12-rounds:11
        S(3) = bitxor(S(3), uint64(240 - r * 16 + r));

        % Substitution layer
        S(1) = bitxor(S(1), S(5));
        S(5) = bitxor(S(5), S(4));
        S(3) = bitxor(S(3), S(2));
        T = bitand(bitxor(S, uint64(18446744073709551615)), circshift(S, -1));
        S = bitxor(S, circshift(T, 1));
        S(2) = bitxor(S(2), S(1));
        S(1) = bitxor(S(1), S(5));
        S(4) = bitxor(S(4), S(3));
        S(3) = bitxor(S(3), uint64(18446744073709551615));

        % Linear diffusion layer
        S(1) = bitxor(S(1), bitxor(rotr(S(1), 19), rotr(S(1), 28)));
        S(2) = bitxor(S(2), bitxor(rotr(S(2), 61), rotr(S(2), 39)));
        S(3) = bitxor(S(3), bitxor(rotr(S(3), 1), rotr(S(3), 6)));
        S(4) = bitxor(S(4), bitxor(rotr(S(4), 10), rotr(S(4), 17)));
        S(5) = bitxor(S(5), bitxor(rotr(S(5), 7), rotr(S(5), 41)));
    end
end