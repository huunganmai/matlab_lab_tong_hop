methods (Access = private)

        % Callback function
        function ButtonPushed(app, event)
            disp('Nut tab2');
        end

        % Callback function
        function Button2Pushed(app, event)
            f = @(x) x.^3.*sin(x) + x.*cos(x);
            N = 50;
            a = 0;
            b = 1;
            result = tichphanSimpson(f, a, b, N);
            disp(result);
        end

        % Button pushed function: TinhDaoHamButton
        function TinhDaoHamButtonPushed(app, event)
            % Lấy các tham số từ giao diện người dùng
            f = app.HamSoEditField.Value;
            if ~isempty(f)
                f = str2func(['@(x)' f]);
            end
            h = app.BuocHEditField.Value;
            % Dùng hàm convertStringToNumArray tự viết để chuyển dữ liệu 
            % từ dạng text thành các mảng sổ
            x = convertStringToNumArray(app.DuLieuXEditField.Value);
            y =convertStringToNumArray(app.DuLieuYEditField.Value);
            saiso = str2double(app.SaiSoDropDown.Value);
            phuongphap = app.PhuongPhapDropDown.Value;
            x0 = app.GiaTriXEditField.Value;
            % Tính giá trị đạo hàm
            result = tinhdaoham(f, x,y,x0,h,phuongphap,saiso);
            % Hiển thị kết quả
            app.KetQuaEditField.Value = result;
        end

        % Button pushed function: TinhTichPhanButton
        function TinhTichPhanButtonPushed(app, event)
            % Lấy các tham số từ giao diện người dùng
            f = app.Tp_HamSoEditField.Value;
            if ~isempty(f)
                f = str2func(['@(x)' f]);
            end
            % Dùng hàm convertStringToNumArray tự viết để chuyển dữ liệu 
            % từ dạng text thành các mảng sổ
            xa = convertStringToNumArray(app.Tp_DuLieuXEditField.Value);
            ya =convertStringToNumArray(app.Tp_DuLieuYEditField.Value);
            can_array = convertStringToNumArray(app.Tp_CanEditField.Value);
            a = can_array(1);
            b = can_array(2);
            N = app.Tp_NhapNEditField.Value;
            method = app.Tp_PhuongPhapDropDown.Value;
            % Tính đạo hàm
            result = tinhtichphan(f, a, b, xa, ya, N, method);
            % Hiển thị kết quả ra giao diện người dùng
            app.Tp_KetQuaEditField.Value = result;
        end

        % Button pushed function: TinhNoiSuyButton
        function TinhNoiSuyButtonPushed(app, event)
            % Lấy dữ liệu từ giao diện người dùng
            % Dùng hàm convertStringToNumArray tự viết để chuyển dữ liệu 
            % từ dạng text thành các mảng sổ
            xa = convertStringToNumArray(app.Ns_DuLieuXEditField.Value);
            ya = convertStringToNumArray(app.Ns_DuLieuYEditField.Value);
            x0 = app.Ns_GiaTriXEditField.Value;
            method = app.Ns_PhuongPhapDropDown.Value;

            % Tính đa thức nội suy
            f = tinhnoisuy(xa, ya, method);
            app.Ns_DaThucNoiSuyTextArea.Value = char(f);
            % Tính giá trị nội suy tại giá trị x0
            f_hd = matlabFunction(f);
            f_x0 = f_hd(x0);
            % Hiển thị kết quả ra màn hình
            app.Ns_KetQuaEditField.Value = f_x0;

            % Vẽ đồ thị
            x_plt = linspace(min(xa), max(xa), 1000);
            y_plt = f_hd(x_plt);
            cla((app.Ns_UIAxes));
            % Vẽ đồ thị đa thức nội suy
            plot(app.Ns_UIAxes, x_plt, y_plt, 'LineWidth',2);
            hold(app.Ns_UIAxes, 'on');
            % Vẽ dữ liệu thực tế
            plot(app.Ns_UIAxes, xa, ya, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
            hold(app.Ns_UIAxes, 'off')
            % Chú thích cho đồ thị
            title(app.Ns_UIAxes, 'Nội suy và Dữ Liệu Thực'); 
            xlabel(app.Ns_UIAxes, 'x'); 
            ylabel(app.Ns_UIAxes, 'y'); 
            legend(app.Ns_UIAxes, 'Đường nội suy', 'Dữ liệu thực');
        end

        % Button pushed function: TimNghiemButton
        function TimNghiemButtonPushed(app, event)
            f = app.Tn_NhapPhuongTrinhEditField.Value;
            f = str2func(['@(x)' vectorize(f)]);
            saiso = app.Tn_NhapSaiSoEditField.Value;
            khoangphanly = convertStringToNumArray(app.Tn_KhoangPhanLyEditField.Value);
            a = khoangphanly(1);
            b = khoangphanly(2);
            method = app.Tn_ChonPhuongPhapDropDown.Value;
            if (strcmp(method, 'lap'))
                fp = app.Tn_NhapHamLapEditField;
                fp = str2func(['@(x)' fp]);
                [nghiem, solanlap] = timnghiem(fp, a, b, saiso, method);
            else
                [nghiem, solanlap] = timnghiem(f, a, b, saiso, method);
            end
%             app.Tn_KetQuaNghiemEditField.Value = nghiem;
            app.Tn_KetQuaEditField.Value = num2str(nghiem);
            app.Tn_SoLanLapEditField.Value = solanlap;

            % Vẽ đồ thị
            x_plt = linspace(a, b, 1000);
            y_plt = f(x_plt);
            cla((app.Tn_UIAxes));
            plot(app.Tn_UIAxes, x_plt, y_plt, 'LineWidth',2);
            % Chú thích cho đồ thị
            title(app.Tn_UIAxes, 'Hàm số f'); 
            xlabel(app.Tn_UIAxes, 'x'); 
            ylabel(app.Tn_UIAxes, 'y'); 
        end

        % Button pushed function: TinhHoiQuyButton
        function TinhHoiQuyButtonPushed(app, event)
            % Lấy dữ liệu từ giao diện người dùng
            % Dùng hàm convertStringToNumArray tự viết để chuyển dữ liệu 
            % từ dạng text thành các mảng sổ
            xa = convertStringToNumArray(app.Hq_DuLieuXEditField.Value);
            ya = convertStringToNumArray(app.Hq_DuLieuYEditField.Value);
            x0 = app.Hq_GiaTriDuDoanEditField.Value;
            method = app.Hq_PhuongPhapDropDown.Value;
            % Dựa trên method để chọn hàm tính toán phù hợp
            if (strcmp(method, 'tuyentinh'))
                [a1, a0, r2] = HoiQuyTuyenTinh(xa, ya);
                f_hq = @(x) a1.*x + a0;
                % Tạo hàm dạng text để hiển thị ra giao diện người dùng
                f_hq_text = sprintf('y = %.4f * x + %.4f', a1, a0);
            elseif (strcmp(method, 'mu'))
                [a, b, r2] = HoiQuyHamMu(xa,ya);
                f_hq = @(x) a .* x.^b;
                % Tạo hàm dạng text để hiển thị ra giao diện người dùng
                f_hq_text = sprintf('y = %.4f * x ^ %.4f', a, b);
            end
            % Hiển thị kết quả ra giao diện người dùng
            app.Hq_HamHoiQuyTextArea.Value = f_hq_text;
            app.Hq_KetQuaDuDoanEditField.Value = num2str(f_hq(x0));
            % Vẽ đồ thị
            x_plt = linspace(min(xa), max(xa), 1000);
            y_plt = f_hq(x_plt);
            
            cla(app.Hq_UIAxes);
            % Vẽ đồ thị hàm hồi quy
            plot(app.Hq_UIAxes, x_plt, y_plt, '-', 'LineWidth', 2);
            hold(app.Hq_UIAxes, 'on');
            % Vẽ dữ liệu thực tế
            plot(app.Hq_UIAxes, xa, ya, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
            hold(app.Hq_UIAxes, 'off')
            % Chú thích cho đồ thị
            title(app.Hq_UIAxes, 'Hồi Quy và Dữ Liệu Thực'); 
            xlabel(app.Hq_UIAxes, 'x'); ylabel(app.Hq_UIAxes, 'y'); 
            legend(app.Hq_UIAxes, 'Đường hồi quy', 'Dữ liệu thực');
        end
    end