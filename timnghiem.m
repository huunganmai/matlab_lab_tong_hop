function [nghiem, solanlap] = timnghiem(f, a, b, saiso, method)
    solanlap = 0; % Khởi tạo số lần lặp ban đầu.
    switch (method)
        case 'chiadoi'
            % Kiểm tra dấu của f(a), f(b), nếu lớn hơn 0 => khoảng phân ly sai
            if (f(a) * f(b) > 0)
                disp('Khong co khoang phan ly');
                nghiem = NaN;
                solanlap = 0;
                return;
            end
        
            % Khởi tạo giá trị sai số lớn hơn biến saiso để bắt đầu vòng lặp
            ea = saiso + 1;
        
            % Lặp cho đến khi sai số nhỏ hơn biến saiso thì dừng lại
            while ea > saiso
                x = (a+b) /2;   % Chia đôi
                ea = b-a;       % Tính sai số
                
                % Xác định khoảng phân ly nghiệm mới
                temp = f(a) * f(x);
                if (temp > 0)
                    a = x;
                else
                    b = x;
                end
        
                nghiem = x;     % Gán nghiệm = x sau mỗi lần lặp
                solanlap = solanlap + 1; % Tăng số lần lặp lên 1 sau mỗi vòng lặp
            end
        case 'lap'
            x_old = a;      % Khởi tạo giá trị x ban đầu
            imax = 10000;                                                
            while solanlap < imax
                % Tính giá trị x_new
                x_new = f(x_old);
                solanlap = solanlap + 1;    % Tăng số lần lặp sau mỗi lần chạy
                % Kiểm tra điều kiện dừng khi sai số giữa x_new và x_old bé hơn sai
                % số
                if (abs(x_new - x_old) < saiso)
                    % Gán giá trị x_new cho nghiệm khi vòng lặp kết thúc.
                    % x_new là nghiệm gần đúng của phương trình
                    nghiem = x_new;
                    return;     % Thoát khỏi hàm
                end
        
                % Cập nhật giá trị x_old để dùng tính sai số cho vòng lặp tiếp theo
                x_old = x_new;
            end
            if solanlap == 10000
                nghiem = NaN;
            end
        case 'tieptuyen'
%             syms x;
            fd1 = str2func(['@(x)' char(diff(f))]);      % Đạo hàm cấp 1 của f
            fd2 = str2func(['@(x)' char(diff(fd1))]);    % Đạo hàm cấp 2 của f
            
            x0 = a;     % Khởi tạo giá trị đầu cho x0
            % Chọn x0 sao cho f(x0) cùng dấu với f''(x0)
            while(f(x0) * fd2(x0)) <= 0
                x0 = (x0 + b) / 2;
            end
        
            imax = 10000;
            for i = 1:imax
                nghiem = x0 - (f(x0)/fd1(x0));
                solanlap = solanlap + 1;
                % Kiểm tra nếu x(n) - x(n-1) nhỏ hơn sai số thì dừng
                if(abs(nghiem - x0)) < saiso
                    break;
                end
                % Gán x0 bằng x hiện tại để sử dụng cho vòng lặp tiếp theo
                x0 = nghiem;
            end
        otherwise
            error('Chon phuong phap phu hop')
    end
end