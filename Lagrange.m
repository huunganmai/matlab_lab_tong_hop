function result = Lagrange(xa, ya, x)
    % Hàm Lagrange tính giá trị nội suy của đa thức Lagrange tại điểm x
    % Mảng xa - các điểm x đã cho
    % Mảng ya - giá trị hàm số tại các điểm xa tương ứng
    % x Điểm cần tính giá trị của đa thức nội suy

    n = length(xa); % Số lượng các điểm x
    sum = 0; % Khởi tạo tổng
    for i = 1: n 
        % Vòng lặp duyệt qua từng điểm ya để khởi tạo product
        product = ya(i); 
        for j = 1:n
            % Vòng lặp duyệt qua từng xa để tính tích
            if i ~= j
                % Kiểm tra để không nhân chính nó
                product = product*(x - xa(j))/(xa(i) - xa(j));
            end 
        end
        % Cộng tích vào tổng để tạo thành đa thức nội suy
        sum = sum + product;
    end
    result = sum;
end


