function randomNumber(min = 0, max = 1, integer = false) {
    if (min > max) [min, max] = [max, min];

    if (integer) {
        const imin = Math.ceil(min);
        const imax = Math.floor(max);
        if (imin > imax) return NaN;
        return Math.floor(Math.random() * (imax - imin + 1)) + imin;
    }

    return Math.random() * (max - min) + min;
}
