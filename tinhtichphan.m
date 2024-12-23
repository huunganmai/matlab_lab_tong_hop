function y = tinhtichphan(f, a, b, xa, ya, N, method)
    % Hàm tinhtichphan: Tính tích phân bằng phương pháp hình thang, Simpson 1/3, hoặc Simpson 3/8
    % f: Hàm số cần tính tích phân (để trống nếu sử dụng x và y_vals)
    % a, b: Khoảng tích phân
    % x, y: Mảng giá trị x và y tương ứng (để trống nếu sử dụng hàm f)
    % N: Số đoạn chia (phải là số chẵn với Simpson 1/3)
    % method: Phương pháp ('hinhthang', 'simpson1/3', 'simpson3/8')

    if isempty(f)
        % Nếu không cung cấp hàm số f, nội suy giá trị hàm từ mảng x và y
        f = LagrangeSymbolic(xa, ya);
        f = matlabFunction(f);
    end

    % Kiểm tra đầu vào N
    if strcmp(method, 'simpson_13') && mod(N, 2) ~= 0
        error('Số đoạn N phải là số chẵn khi sử dụng phương pháp Simpson 1/3.');
    end

    h = (b - a) / N; % Độ rộng mỗi đoạn con

    switch method
        case 'hinhthang'
            % Phương pháp hình thang
            result = f(a) + f(b);
            for i = 1:N-1
                % Tính tổng các giá trị hàm tại các đoạn con
                result = result + 2 * f(a + i * h);
            end
            % Tính kết quả cuối cùng
            y = result * h / 2;

        case 'simpson_13'
            % Phương pháp Simpson 1/3
            result = f(a) + f(b);
            for i = 1:N-1
                xi = a + i * h;
                if mod(i, 2) == 0
                    % Tính tổng các giá trị hàm tại các đoạn con N chẵn
                    result = result + 2 * f(xi);
                else
                    % Tính tổng các giá trị hàm tại đoạn con N chẵn
                    result = result + 4 * f(xi);
                end
            end
            % Tính kết quả cuối cùng
            y = result * h / 3;

        case 'simpson_38'
            % Phương pháp Simpson 3/8
            if mod(N, 3) ~= 0
                error('Số đoạn N phải chia hết cho 3 khi sử dụng phương pháp Simpson 3/8.');
            end
            result = f(a) + f(b);
            for i = 1:N-1
                xi = a + i * h;
                if mod(i, 3) == 0
                    % Tính tổng các giá trị hàm tại các đoạn con có N chia 
                    % hết cho 3
                    result = result + 2 * f(xi);
                else
                    % Tính tổng các giá trị hàm tại các đoạn con có N không
                    % chia hết cho 3
                    result = result + 3 * f(xi);
                end
            end
            % Tính kết quả cuối cùng
            y = result * 3 * h / 8;

        otherwise
            error('Phương pháp không hợp lệ. Chọn "hinhthang", "simpson1/3", hoặc "simpson3/8".');
    end
end
