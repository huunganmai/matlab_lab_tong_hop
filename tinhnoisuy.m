function P = tinhnoisuy(xa, ya, method)
    % Hàm tính nội suy


    syms x;
    n = length(xa);
    switch lower(method)
        case 'lagrange'
            P = 0; % Khởi tạo đa thức nội suy P ban đầu là 0
        
            for i = 1:n
                product = ya(i); 
                for j = 1:n
                    if i ~= j
                        product = product * (x - xa(j)) / (xa(i) - xa(j));
                    end
                end
                P = P + product; % Thêm tích product vào đa thức nội suy
            end
            P = simplify(P);
        case 'newton_tien'
            % Nội suy Newton tiến
            % Tính tỉ hiệu Newton tiến
            d_tien = ya;
            for i = 1:n
                for j = 1:i-1
                    d_tien(i) = (d_tien(j) - d_tien(i)) / (xa(j) - xa(i));
                end
            end
            % Tính kết quả đa thức nội suy Newton tiến
            P = d_tien(n);
            for i = n-1:-1:1
                P = P * (x - xa(i)) + d_tien(i);
            end
            P = simplify(P); % Đơn giản hóa đa thứ
        case 'newton_lui'
            d_lui = ya;
            for i = n:-1:1
                for j = n:-1:i+1  % Chỉ số chạy từ n về i+1
                    d_lui(i) = (d_lui(j) - d_lui(i)) / (xa(j) - xa(i));
                end
            end
            % Tính kết quả đa thức nội suy Newton lùi
            P = d_lui(1);
            for i = 2:n
                P = P * (x -xa(i)) + d_lui(i);
            end
            P = simplify(P); % Đơn giản hóa đa thức
        otherwise
            error('Phuong phap noi suy khong hop le')
    end
end