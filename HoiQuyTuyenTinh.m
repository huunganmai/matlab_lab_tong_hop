function [a1, a0, r2] = HoiQuyTuyenTinh(x, y)
    % Hàm HoiQuyTuyenTinh thực hiện hồi quy tuyến tính trên dữ liệu x và y 
    % Đầu vào: 
    % - x: vector chứa các giá trị đầu vào 
    % - y: vector chứa các giá trị đầu ra tương ứng % Đầu ra: 
    % - a1: hệ số góc của đường hồi quy % - a0: hệ số tự do của đường hồi quy 
    % - r2: hệ số xác định (R^2), chỉ số đo độ phù hợp của mô hình
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
    % Tính toán hệ số góc (a1) của đường hồi quy
    a1 = (n * sumxy - sumx * sumy) / (n * sumx2 - sumx^2);
    % Tính toán hệ số tự do (a0) của đường hồi quy
    a0 = ym - a1 * xm;
    st = sum((y - ym).^2);
    sr = sum((y - (a0 + a1 .* x)).^2);
    r2 = 1 - (sr / st);
end