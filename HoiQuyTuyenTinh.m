function [a1, a0, r2] = HoiQuyTuyenTinh(x, y)
    if length(x) ~= length(y)
        error('x và y phải có cùng số phần tử!');
    end
    n = length(x);
    sumx = sum(x);
    sumy = sum(y);
    sumxy = sum(x .* y);
    sumx2 = sum(x .^ 2); 
    xm = mean(x);
    ym = mean(y);
    a1 = (n * sumxy - sumx * sumy) / (n * sumx2 - sumx^2);
    a0 = ym - a1 * xm;
    st = sum((y - ym).^2); 
    sr = sum((y - (a0 + a1 .* x)).^2);  
    r2 = 1 - (sr / st);
end