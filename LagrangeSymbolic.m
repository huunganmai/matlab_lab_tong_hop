function P = LagrangeSymbolic(xa, ya)
    % Hàm LagrangeSymbolic tính đa thức nội suy Lagrange dùng kiểu dữ liệu
    % syms
    % Mảng xa - các điểm x đã cho
    % Mảng ya - giá trị hàm số tại các điểm xa tương ứng
    syms x;
    n = length(xa);
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
    P = simplify(P); % Đơn giản hóa đa thức nội suy
end
