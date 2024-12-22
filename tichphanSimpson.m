function y = tichphanSimpson(f, a, b, N)
    h = (b - a) / N;
    y = f(a) + f(b);
    for i = 1:N-1
        if mod(i, 2) == 0
            y = y + 2*f(a + i*h);
        else
            y = y + 4*f(a + i*h);
        end
    end

    y = y * h / 3;
end