function [a, b, r2] = HoiQuyHamMu(x, y)
    % Hồi quy hàm mũ. Dữ liệu trả về có dạng 
    % Kiểm tra độ dài của x và y
    if length(x) ~= length(y)
        error('x và y phải có cùng số phần tử!');
    end
    % Kiểm tra x và y phải lớn hơn 0
    if any(x <= 0) || any(y <= 0)
        error('x và y phải lớn hơn 0 để áp dụng hàm logarit!');
    end
    
    % Biến đổi dữ liệu sử dụng logarit
    X_log = log(x);
    Y_log = log(y);
    [b, A_log, r2] = HoiQuyTuyenTinh(X_log, Y_log);
    a = exp(A_log);
end