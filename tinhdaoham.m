function result = tinhdaoham(fx, x, y, x0, h, method, error_order)
    % Hàm tinhdaoham: Tính đạo hàm của hàm số fx tại điểm x0 bằng các 
    % phương thức tiến, lùi, trung tâm
    % x , y: Mảng các giá trị x và y tương ứng, dùng khi không nhập fx
    % h: Khoảng cách bước nhảy
    % method: Phương pháp tính đạo hàm (value: 'tien', 'lui', 'trungtam')
    % error_order: sai số O(h) hoặc O(h^2) (value: 1, 2)

    % Kiểm tra tính hợp lệ của error_order và method
    if ~ismember(error_order, [1, 2])
        error('Sai số không hợp lệ. Chọn 1 hoặc 2.');
    end

    if ~ismember(method, {'tien', 'lui', 'trungtam'})
        error('Phương pháp không hợp lệ. Chọn "tien", "lui" hoặc "trungtam".');
    end

    if ~isempty(fx)
        % Nếu hàm fx được cung cấp, sử dụng fx để tính giá trị tại các điểm
        f_x0 = fx(x0);
        f_x1 = fx(x0 + h);
        f_x_1 = fx(x0 - h);
        if error_order == 2
            f_x2 = fx(x0 + 2*h);
            f_x_2 = fx(x0 - 2*h);
        end
    else
        % Nếu không có fx, sử dụng nội suy từ mảng x và y
        f_x0 = Lagrange(x, y, x0);
        f_x1 = Lagrange(x, y, x0 + h);
        f_x_1 = Lagrange(x, y, x0 - h);
        if error_order == 2
            f_x2 = Lagrange(x, y, x0 + 2*h);
            f_x_2 = Lagrange(x, y, x0 - 2*h);
        end
    end

    % Tính toán đạo hàm dựa trên phương pháp và sai số
    switch method
        case 'tien'
            if error_order == 1
                % Phương pháp tiến với sai số O(h)
                result = (f_x1 - f_x0) / h;
            elseif error_order == 2
                % Phương pháp tiến với sai sô O(h2)
                result = (-f_x2 + 4*f_x1 - 3*f_x0) / (2*h);
            end
        case 'lui'
            if error_order == 1
                % Phương pháp lùi với sai số O(h)
                result = (f_x0 - f_x_1) / h;
            elseif error_order == 2
                % Phương pháp lùi với sai sô O(h2)
                result = (3*f_x0 - 4*f_x_1 + f_x_2) / (2*h);
            end
        case 'trungtam'
            % Phương pháp trung tâm với sai số O(h)
            if error_order == 1
                result = (f_x1 - f_x_1) / (2*h);
            elseif error_order == 2
                % Phương pháp trung tâm với sai số O(h2)
                result = (-f_x2 + 8*f_x1 - 8*f_x_1 + f_x_2) / (12*h);
            end
    end
end
