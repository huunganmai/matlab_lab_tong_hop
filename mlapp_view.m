% Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function ButtonPushed(app, event)
            disp('Nut tab2');
        end

        % Callback function: not associated with a component
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
            f = app.HamSoEditField.Value;
            if ~isempty(f)
                f = str2func(['@(x)' f]);
            end
            h = app.BuocHEditField.Value;
            x = convertStringToNumArray(app.DuLieuXEditField.Value);
            y =convertStringToNumArray(app.DuLieuYEditField.Value);
            saiso = str2double(app.SaiSoDropDown.Value);
            phuongphap = app.PhuongPhapDropDown.Value;
            x0 = app.GiaTriXEditField.Value;
            result = tinhdaoham(f, x,y,x0,h,phuongphap,saiso);
            app.KetQuaEditField.Value = result;
        end

        % Button pushed function: TinhTichPhanButton
        function TinhTichPhanButtonPushed(app, event)
            f = app.Tp_HamSoEditField.Value;
            if ~isempty(f)
                f = str2func(['@(x)' f]);
            end
            xa = convertStringToNumArray(app.Tp_DuLieuXEditField.Value);
            ya =convertStringToNumArray(app.Tp_DuLieuYEditField.Value);
            can_array = convertStringToNumArray(app.Tp_CanEditField.Value);
            disp(xa);
            disp(ya);
            a = can_array(1);
            b = can_array(2);
            N = app.Tp_NhapNEditField.Value;
            method = app.Tp_PhuongPhapDropDown.Value;
            result = tinhtichphan(f, a, b, xa, ya, N, method);
            disp(result)
            app.Tp_KetQuaEditField.Value = result;
        end

        % Button pushed function: TinhNoiSuyButton
        function TinhNoiSuyButtonPushed(app, event)
            % Lấy dữ liệu từ giao diện người dùng
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
            app.Ns_KetQuaEditField.Value = f_x0;

            % Vẽ đồ thị
            x_plt = linspace(min(xa), max(xa), 1000);
            y_plt = f_hd(x_plt);
            cla((app.Ns_UIAxes));
            plot(app.Ns_UIAxes, x_plt, y_plt);
        end

        % Button pushed function: TimNghiemButton
        function TimNghiemButtonPushed(app, event)
            f = app.Tn_NhapPhuongTrinhEditField.Value;
            f = str2func(['@(x)' f]);
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
        end
    end