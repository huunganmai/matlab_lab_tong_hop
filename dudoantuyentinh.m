function [kq, r2] = dudoantuyentinh(xi, yi, x)
    [a1, a0, r2] = HoiQuyTuyenTinh(xi, yi);
    kq = a0 + a1 .* x;
end