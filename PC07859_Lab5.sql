USE QuanLyBanHang
GO

-- Bài 1
-- Hiển thị tất cả thông tin có trong bảng khách hàng bao gồm tất cả các cột
SELECT * 
FROM KHACHHANG

-- Hiển thị 10 khách hàng đầu tiên trong bảng khách hàng bao gồm các cột: mã
-- khách hàng, họ và tên, email, số điện thoại
SELECT TOP 10 maKhachHang, hoVaTenLot + ' ' + Ten as 'Họ và tên', Email, dienThoai
FROM KHACHHANG

-- Hiển thị thông tin từ bảng Sản phẩm gồm các cột: mã sản phẩm, tên sản phẩm,
-- tổng tiền tồn kho. Với tổng tiền tồn kho = đơn giá* số lượng
SELECT MaSanPham, TenSP, DonGia * SoLuong AS 'Tổng tiền tồn kho'
FROM SANPHAM

-- Hiển thị danh sách khách hàng có tên bắt đầu bởi kí tự ‘H’ gồm các cột:
-- maKhachHang, hoVaTen, diaChi. Trong đó cột hoVaTen ghép từ 2 cột
-- hoVaTenLot và Ten
SELECT maKhachHang, hoVaTenLot + ' ' + Ten as 'Họ và tên', diaChi 
FROM KHACHHANG
WHERE Ten LIKE 'H%'

-- Hiển thị tất cả thông tin các cột của khách hàng có địa chỉ chứa chuỗi ‘Đà Nẵng’
SELECT *
FROM KHACHHANG
WHERE diaChi LIKE N'%ĐÀ NẴNG%'

-- Hiển thị các sản phẩm có số lượng nằm trong khoảng từ 100 đến 500.
SELECT *
FROM SANPHAM
WHERE SoLuong BETWEEN 100 AND 500

-- Hiển thị danh sách các hoá hơn có trạng thái là chưa thanh toán và ngày mua hàng
-- trong năm 2016
SELECT * 
FROM HOADON
WHERE TrangThai = N'Chưa thanh toán' AND YEAR(NgayMuaHang) = 2016

-- Hiển thị các hoá đơn có mã Khách hàng thuộc 1 trong 3 mã sau: KH001, KH003,
-- KH006
SELECT *
FROM HOADON
WHERE MaKhachHang IN ('KH001', 'KH003', 'KH006')

-- BÀI 2

-- Hiển thị số lượng khách hàng có trong bảng khách hàng
SELECT COUNT(*) AS 'Số lượng khách hàng'
FROM KHACHHANG

-- Hiển thị đơn giá lớn nhất trong bảng SanPham
SELECT MAX(DonGia) AS 'Đơn giá lớn nhất'
FROM SANPHAM

-- Hiển thị số lượng sản phẩm thấp nhất trong bảng sản phẩm
SELECT MIN(SOLUONG)
FROM SANPHAM

-- Hiển thị tổng tất cả số lượng sản phẩm có trong bảng sản phẩm
SELECT SUM(SoLuong) AS 'Tổng số lượng sản phẩm'
FROM SANPHAM

-- Hiển thị số hoá đơn đã xuất trong tháng 12/2016 mà có trạng thái chưa thanh toán
SELECT COUNT(*) AS SOHOADON
FROM HOADON
WHERE MONTH(NgayMuaHang) = 12
AND YEAR(NgayMuaHang) = 2016
AND TrangThai LIKE N'%Chưa thanh toán%'

-- Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn.
SELECT maHoaDon, COUNT(maSanPham) AS SOLOAI
FROM HOADONCHITIET
GROUP BY maHoaDon

-- Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn. Yêu cầu
-- chỉ hiển thị hàng nào có số loại sản phẩm được mua >=5.
SELECT maHoaDon, COUNT(maSanPham) AS SOLOAI
FROM HOADONCHITIET
GROUP BY maHoaDon
HAVING COUNT(maHoaDon) >= 5


-- Hiển thị thông tin bảng HoaDon gồm các cột maHoaDon, ngayMuaHang,
-- maKhachHang. Sắp xếp theo thứ tự giảm dần của ngayMuaHang
SELECT MaHoaDon, NgayMuaHang, MaKhachHang
FROM HOADON
ORDER BY NgayMuaHang DESC



-- Bài 3
USE QLNHANVIEN

-- HIỂN THỊ MỨC LƯƠNG CAO NHẤT TRONG BẢNG NHÂN VIÊN
SELECT MAX(LUONG) AS 'LƯƠNG CAO NHẤT'
FROM NHAN_VIEN

-- HIỂN THỊ MỨC LƯƠNG TRUNG BÌNH TRONG BẢNG NHÂN VIÊN
SELECT AVG(LUONG) AS 'LƯƠNG TRUNG BÌNH'
FROM NHAN_VIEN
WHERE PHG = 'PB001'

-- HIỂN THỊ SỐ LƯỢNG NHÂN VIÊN CÓ NGÀY SINH TRƯỚC NGÁY 01/01/1957 TRONG BẢNG NHÂN VIÊN
SELECT COUNT(*) AS SONV
FROM NHAN_VIEN
WHERE NGAY_SINH < '01/01/1957'

-- VIẾT CÂU TRUY VẤN HIỂN THỊ NHÂN VIÊN TRONG TỪNG PHÒNG BAN
SELECT PHG, COUNT(PHG) AS SONV
FROM NHAN_VIEN
GROUP BY PHG 

-- HIỂN THỊ LƯƠNG LỚN NHẤT TỪNG PHÒNG BAN, CHỈ HIỂN THỊ PHÒNG BAN CÓ LƯƠNG LỚN NHẤT > 30000
SELECT PHG, MAX(LUONG) AS LUONGLONNHAT
FROM NHAN_VIEN
GROUP BY PHG
HAVING MAX(LUONG) >= 1000

-- HIỂN THỊ LƯƠNG LỚN NHẤT TỪNG PHÒNG BAN, CHỈ HIỂN THỊ NHAN VIÊN CÓ LƯƠNG > 500
SELECT PHG, MAX(LUONG) AS LUONGLONNHAT
FROM NHAN_VIEN
WHERE LUONG > 500
GROUP BY PHG

-- Tính lương trung bình của từng Phòng Ban
SELECT PHG, AVG(LUONG) AS LUONGTRUNGBINH
FROM NHAN_VIEN
GROUP BY PHG

-- Đếm số lượng nhân viên của từng Phòng
SELECT PHG, COUNT(*) AS SOLUONGNHANVIEN
FROM NHAN_VIEN
GROUP BY PHG

-- Tính tổng lương công ty phải trả cho mỗi phòng ban, chỉ hiển thị nhóm nào có tổng > 1500
SELECT PHG, SUM(LUONG) AS LUONGPHAITRA
FROM NHAN_VIEN
GROUP BY PHG
HAVING SUM(LUONG) > 1500

-- Tính tổng lương công ty phải trả cho mỗi phòng ban, chỉ nhóm hàng nào có cột lương >500, chỉ hiển thị nhóm nào có tổng >1500
SELECT PHG, SUM(LUONG) AS LUONGPHAITRA
FROM NHAN_VIEN
WHERE LUONG > 500
GROUP BY PHG
HAVING SUM(LUONG) > 1500


-- Hiển thị danh sách các nhân viên có trong bảng NHAN_VIEN theo thứ tự tăng dần của trường TENNV
SELECT TEN_NV
FROM NHAN_VIEN
ORDER BY TEN_NV

-- Hiển thị tên nhân viên theo thứ giảm dần của trường ngày sinh
SELECT *
FROM NHAN_VIEN
ORDER BY NGAY_SINH DESC

