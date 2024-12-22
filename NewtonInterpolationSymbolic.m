function [result_tien, result_lui] = NewtonInterpolationSymbolic(xa, ya)
    syms x;
    n = length(xa);
    
    % Nội suy Newton tiến
    % Tính tỉ hiệu Newton tiến
    d_tien = ya;
    for i = 1:n
        for j = 1:i-1
            d_tien(i) = (d_tien(j) - d_tien(i)) / (xa(j) - xa(i));
        end
    end
    % Tính kết quả đa thức nội suy Newton tiến
    result_tien = d_tien(n);
    for i = n-1:-1:1
        result_tien = result_tien * (x - xa(i)) + d_tien(i);
    end
    result_tien = simplify(result_tien); % Đơn giản hóa đa thức

    % Nội suy Newton lùi
    %Tính tỉ hiệu Newton lùi
    d_lui = ya;
    for i = n:-1:1
        for j = n:-1:i+1  % Chỉ số chạy từ n về i+1
            d_lui(i) = (d_lui(j) - d_lui(i)) / (xa(j) - xa(i));
        end
    end
    % Tính kết quả đa thức nội suy Newton lùi
    result_lui = d_lui(1);
    for i = 2:n
        result_lui = result_lui * (x -xa(i)) + d_lui(i);
    end
    result_lui = simplify(result_lui); % Đơn giản hóa đa thức
end
