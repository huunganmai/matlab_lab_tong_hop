function numArray = convertStringToNumArray(str)
    % Hàm chuyển đổi chuỗi thành mảng số
    % Đầu vào:
    %   str - chuỗi chứa các số, ngăn cách bởi dấu phẩy hoặc khoảng trắng
    % Đầu ra:
    %   numArray - mảng số

    % Chia chuỗi thành các phần tử dựa trên dấu phẩy hoặc khoảng trắng
    strArray = regexp(str, '[ ,]', 'split'); 
    
    % Khởi tạo numArray với kích thước cố định và giá trị NaN
    numArray = NaN(1, length(strArray)); 
    index = 1;
    
    % Vòng lặp kiểm tra và thêm các phần tử không rỗng vào numArray
    for i = 1:length(strArray)
        if ~isempty(strArray{i})
            % Chuyển đổi từng phần tử có giá trị khác NaN, chuỗi rỗng thành
            % số và thêm vào numArray
            numArray(index) = str2double(strArray{i});
            index = index + 1;
        end
    end
    
    % Loại bỏ các phần tử NaN thừa ở cuối mảng
    numArray = numArray(~isnan(numArray));
end


