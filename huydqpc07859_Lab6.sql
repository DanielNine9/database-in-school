USE QLNHANVIEN

GO
--Viết câu truy vấn hiển thị họ tên nhân viên, mã phòng ban mà nhân viên đó thuộc về.
SELECT HO_NV + TEN_NV AS 'HỌ VÀ TÊN', PHG
FROM NHAN_VIEN
--Viết câu truy vấn hiển thị họ tên nhân viên, mã phòng ban, tên phòng ban mà nhân viên đó thuộc về.

--C1: SỬ DỤNG PHÉP TÍCH
SELECT HO_NV + TEN_NV AS 'HỌ VÀ TÊN', PHG, TEN_PB
FROM NHAN_VIEN A, PHONG_BAN B
WHERE A.PHG = B.MA_PB


--C2: SỬ DỤNG INNER JOIN
SELECT HO_NV + TEN_NV AS 'HỌ VÀ TÊN', PHG, TEN_PB
FROM NHAN_VIEN A
INNER JOIN PHONG_BAN B ON A.PHG = B.MA_PB

--Viết câu truy vấn hiển thị mã dự án, tên dự án mà nhân viên NV001 đã tham gia
--C1 SỬ DỤNG PHÉP TÍCH
SELECT QLDA.MA_DUAN, DA.TEN_DUAN
FROM QUANLY_DUAN QLDA, DU_AN DA
WHERE QLDA.MA_DUAN = DA.MA_DUAN
AND QLDA.MA_NHANVIEN = 'NV001'


--C2
SELECT QLDA.MA_DUAN, DA.TEN_DUAN
FROM QUANLY_DUAN QLDA 
INNER JOIN DU_AN DA ON QLDA.MA_DUAN = DA.MA_DUAN
WHERE QLDA.MA_NHANVIEN = 'NV001'

--Viết câu truy vấn hiển thị mã dự án, tên dự án mà nhân viên Dinh Ba Tien đã tham gia

--C1
SELECT C.MA_DUAN, C.TEN_DUAN 
FROM QUANLY_DUAN A, NHAN_VIEN B, DU_AN C
WHERE A.MA_NHANVIEN = B.ID_NHANVIEN AND B.HO_NV + ' ' + B.TEN_NV = 'DINH BA TIEN'
AND C.MA_DUAN = A.MA_DUAN

--C2:
SELECT DA.MA_DUAN, DA.TEN_DUAN
FROM NHAN_VIEN NV
INNER JOIN QUANLY_DUAN QLDA ON NV.ID_NHANVIEN = QLDA.MA_NHANVIEN AND NV.HO_NV + ' ' + NV.TEN_NV LIKE 'Dinh Ba Tien'
INNER JOIN DU_AN DA ON DA.MA_DUAN = QLDA.MA_DUAN

--C3
SELECT DA.MA_DUAN, QLDA.MA_DUAN
FROM DU_AN DA, QUANLY_DUAN QLDA
WHERE QLDA.MA_DUAN = DA.MA_DUAN
AND QLDA.MA_NHANVIEN = (
	SELECT ID_NHANVIEN
	FROM NHAN_VIEN
	WHERE HO_NV + ' ' + TEN_NV LIKE 'DINH BA TIEN'
)

--Viết câu truy vấn hiển thị: họ và tên nhân viên, lương, tên phòng ban mà nhân viên thuộc về
-- , tên dự án, và số giờ đã làm (Sử dụng JOIN hoặc phép tích )

--C1
SELECT HO_NV + ' ' + TEN_NV AS 'HỌ VÀ TÊN', LUONG, TEN_PB, TEN_DUAN, SO_GIO
FROM NHAN_VIEN NV, QUANLY_DUAN QLDA, PHONG_BAN PB, DU_AN DA
WHERE NV.ID_NHANVIEN = QLDA.MA_NHANVIEN
AND NV.PHG = PB.MA_PB 
AND QLDA.MA_DUAN = DA.MA_DUAN

--C2
SELECT HO_NV + ' ' + TEN_NV AS 'HỌ VÀ TÊN', LUONG, TEN_PB, TEN_DUAN, SO_GIO
FROM NHAN_VIEN NV
INNER JOIN QUANLY_DUAN QLDA ON NV.ID_NHANVIEN = QLDA.MA_NHANVIEN
INNER JOIN PHONG_BAN PB ON NV.PHG = PB.MA_PB
INNER JOIN DU_AN DA ON QLDA.MA_DUAN = DA.MA_DUAN


--Viết câu truy vấn hiển thị các thông tin bao gồm: họ, tên, lương của nhân viên, tên dự án với điều kiện nhân viên thuộc phòng ban có tên 'Điều hành' có tham gia vào các dự án
-- C1
SELECT HO_NV, TEN_NV, LUONG, TEN_DUAN
FROM NHAN_VIEN A, DU_AN B, PHONG_BAN C, QUANLY_DUAN D
WHERE D.MA_NHANVIEN = A.ID_NHANVIEN
AND D.MA_DUAN = B.MA_DUAN
AND A.PHG = C.MA_PB
AND C.TEN_PB LIKE 'DIEU HANH'

--C2 
SELECT HO_NV + ' ' + TEN_NV AS 'HỌ VÀ TÊN', LUONG, TEN_PB, TEN_DUAN, SO_GIO
FROM NHAN_VIEN NV
INNER JOIN QUANLY_DUAN QLDA ON NV.ID_NHANVIEN = QLDA.MA_NHANVIEN
INNER JOIN PHONG_BAN PB ON NV.PHG = PB.MA_PB AND PB.TEN_PB LIKE 'DIEU HANH'
INNER JOIN DU_AN DA ON QLDA.MA_DUAN = DA.MA_DUAN

-- LAB 6

USE QuanLyBanHang
GO

--BÀI 1
-- a. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột
-- sau: MaHoaDon, maKhachHang, trangThai, MaSanPham, SoLuong, NgayMua
SELECT B.MaHoaDon, MaKhachHang, TrangThai, MaSanPham, SoLuong, NgayMuaHang
FROM HOADON A, HOADONCHITIET B
WHERE A.MaHoaDon = B.MaHoaDon

-- b. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột
-- sau: MaHoaDon, maKhachHang, trangThai, MaSanPham, SoLuong, NgayMua với
-- điều kiện maKhachHang = ‘KH001’
SELECT A.MaHoaDon, MaKhachHang, TrangThai, MaSanPham, SoLuong, NgayMuaHang
FROM HOADON A, HOADONCHITIET B
WHERE MaKhachHang = 'KH001' 
AND A.MaHoaDon = B.MaHoaDon


-- c. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột
-- sau: MaHoaDon, NgayMua, tenSP, donGia, SoLuong mua trong hoá đơn, thành
-- tiền. Với thành tiền= donGia* SoLuong
SELECT A.MaHoaDon, NgayMuaHang, TenSP, DonGia, C.SoLuong, DonGia * C.SoLuong AS THANHTIEN
FROM HOADON A, SANPHAM B, HOADONCHITIET C
WHERE A.MaHoaDon = C.MaHoaDon 
AND C.maSanPham = B.MaSanPham


-- d. Hiển thị thông tin từ bảng khách hàng, bảng hoá đơn, hoá đơn chi tiết gồm các
-- cột: họ và tên khách hàng, email, điện thoại, mã hoá đơn, trạng thái hoá đơn và
-- tổng tiền đã mua trong hoá đơn. Chỉ hiển thị thông tin các hoá đơn chưa thanh
-- toán.


SELECT A.hoVaTenLot + ' ' + A.Ten AS HOVATEN, A.Email, A.dienThoai, B.MaHoaDon, B.TrangThai, SUM(C.SoLuong * D.DonGia) AS TongTienMua
FROM KHACHHANG A
INNER JOIN HOADON B ON A.MaKhachHang = B.MaKhachHang
INNER JOIN HOADONCHITIET C ON B.MaHoaDon = C.MaHoaDon
INNER JOIN SanPham D ON C.MaSanPham = D.MaSanPham
WHERE B.TrangThai LIKE N'Chưa thanh toán'
GROUP BY A.hoVaTenLot, A.Ten, A.Email, A.dienThoai, B.MaHoaDon, B.TrangThai;

-- e. Hiển thị MaHoaDon, ngàyMuahang, tổng số tiền đã mua trong từng hoá đơn. Chỉ
-- hiển thị những hóa đơn có tổng số tiền >=500.000 và sắp xếp theo thứ tự giảm dần
-- của cột tổng tiền.
SELECT A.MaHoaDon, NgayMuaHang, SUM(B.SoLuong * C.DonGia) AS TongTien
FROM HOADON A
INNER JOIN HOADONCHITIET B ON A.MaHoaDon = B.MaHoaDon
INNER JOIN SANPHAM C ON B.MaSanPham = C.MaSanPham
GROUP BY A.MaHoaDon, A.NgayMuaHang
HAVING SUM(B.SoLuong * C.DonGia) >= 500000
ORDER BY TongTien DESC

-- Bài 2 (4 điểm) Viết các câu truy vấn sau:
-- a. Hiển thị danh sách các khách hàng chưa mua hàng lần nào kể từ tháng 1/1/2016
SELECT * FROM KHACHHANG 
WHERE maKhachHang NOT IN 
	(	
	SELECT MaKhachHang 
	FROM HOADON 
	WHERE NgayMuaHang >= '2016-01-01'
	)

-- b. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016
SELECT TOP 1 SP.maSanPham, TenSP
FROM SANPHAM SP
INNER JOIN HOADONCHITIET HDCT ON SP.maSanPham = HDCT.maSanPham
INNER JOIN HOADON HD ON HDCT.maHoaDon = HD.maHoaDon
WHERE HD.NgayMuaHang >= '2016-12-01' AND HD.NgayMuaHang <= '2016-12-31'
GROUP BY SP.maSanPham, SP.TenSP
ORDER BY COUNT(*) DESC

-- c. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016
SELECT TOP 5 KH.* , SUM(HDCT.soLuong * SP.DonGia) AS TongTienMuaHang
FROM KHACHHANG KH
INNER JOIN HOADON HD ON KH.maKhachHang = HD.MaKhachHang
INNER JOIN HOADONCHITIET HDCT ON HD.maHoaDon = HDCT.maHoaDon
INNER JOIN SANPHAM SP ON SP.MaSanPham = HDCT.maSanPham
WHERE HD.NgayMuaHang >= '2016-01-01' AND HD.NgayMuaHang <= '2016-12-31'
GROUP BY KH.maKhachHang, KH.hoVaTenLot, KH.Ten, KH.diaChi, KH.dienThoai, KH.Email
ORDER BY TongTienMuaHang DESC

-- d. Hiển thị thông tin các khách hàng sống ở ‘Đà Nẵng’ có mua sản phẩm có tên
-- “Iphone 7 32GB” trong tháng 12/2016
SELECT KH.*
FROM KHACHHANG KH
INNER JOIN HOADON HD ON KH.maKhachHang = HD.MaKhachHang
INNER JOIN HOADONCHITIET HDCT ON HD.maHoaDon = HDCT.maHoaDon
INNER JOIN SANPHAM SP ON HDCT.maSanPham = SP.maSanPham
WHERE KH.diaChi = 'Đà Nẵng' AND SP.TenSP = 'Iphone 7 32GB' AND HD.NgayMuaHang >= '2016-12-01' AND HD.NgayMuaHang <= '2016-12-31';

-- e. Hiển thị tên sản phẩm có lượt đặt mua nhỏ hơn lượt mua trung bình các các sản
-- phẩm.
SELECT TenSP 
FROM SANPHAM JOIN HOADONCHITIET HDCT ON SANPHAM.MaSanPham = HDCT.MaSanPham 
GROUP BY SANPHAM.MaSanPham, TenSP 
HAVING COUNT(HDCT.maHoaDon) < (SELECT AVG(Soluong) FROM HoaDonChiTiet);


USE QLNHANVIEN
GO
﻿--VD1: Viết câu truy vấn hiển thị tất cả phòng ban và tất cả nhân viên
SELECT * 
FROM NHAN_VIEN A
FULL JOIN PHONG_BAN B ON A.PHG = B.MA_PB

--VD2: Viết câu truy vấn hiển thị tên các phòng ban và id, họ, tên nhân viên thuộc phòng ban đó.
--C1 DÙNG LEFT JOIN
SELECT TEN_PB, ID_NHANVIEN, HO_NV, TEN_NV
FROM PHONG_BAN A
LEFT JOIN NHAN_VIEN B ON B.PHG = A.MA_PB 

--C2 DÙNG RIGHT JOIN
SELECT TEN_PB, ID_NHANVIEN, HO_NV, TEN_NV 
FROM NHAN_VIEN A 
RIGHT JOIN PHONG_BAN B ON A.PHG = B.MA_PB

--VD3: Viết câu truy vấn hiển thị tất cả các nhân viên và tên phòng ban của nhân viên
--C1 DÙNG LEFT JOIN
SELECT A.*, TEN_PB
FROM NHAN_VIEN A
LEFT JOIN PHONG_BAN B ON A.PHG = B.MA_PB


--C2 DÙNG RIGHT JOIN
SELECT B.* , TEN_PB
FROM PHONG_BAN A
RIGHT JOIN NHAN_VIEN B ON A.MA_PB = B.PHG
-- Thêm cột NQL kiểu CHAR(10) vào bảng NHANVIEN. Thiết lập ràng buộc khóa ngoại cho cột NQL tham
--chiếu đến ID_NHANVIEN
ALTER TABLE NHAN_VIEN ADD NQL CHAR(10)
GO
ALTER TABLE NHAN_VIEN ADD CONSTRAINT FK_NV_NV FOREIGN KEY (NQL) REFERENCES NHAN_VIEN(ID_NHANVIEN)

--Thêm dữ liệu cho cột NQL

--VD4: Viết câu truy vấn hiển thị thông tin nhân viên, tên người quản lý
--C1 SỬ DỤNG INNER JOIN
SELECT A.*, B.TEN_NV AS NGUOIQUANLY
FROM NHAN_VIEN A 
INNER JOIN NHAN_VIEN B ON A.ID_NHANVIEN = B.NQL

--C2 DÙNG PHÉP TICH
SELECT A.*, B.TEN_NV AS NGUOIQUANLY
FROM NHAN_VIEN A, NHAN_VIEN B
WHERE A.ID_NHANVIEN = B.NQL

--VD5: Sử dụng câu truy vấn con để hiển thị thông tin các nhân viên 
--có lương lớn hơn 500

SELECT *
FROM NHAN_VIEN
WHERE LUONG > 500



--VD6: Sử dụng câu truy vấn con để hiển thị thông tin các nhân viên 
--có lương lớn hơn mức lương trung bình toàn công ty
SELECT *
FROM NHAN_VIEN
WHERE LUONG > (SELECT AVG(LUONG) FROM NHAN_VIEN)


--VD7: Hiển thị thông tin nhân viên có lương lớn nhất
SELECT * 
FROM NHAN_VIEN
WHERE LUONG = (SELECT MAX(LUONG) FROM NHAN_VIEN)

--VD8: Hiển thị thông tin nhân viên phòng Quan ly hoặc San xuat linh kien
--C1 DÙNG CÂU LỆNH TRUY VẤN CON


SELECT *
FROM NHAN_VIEN 
WHERE PHG IN ( 
	SELECT MA_PB FROM PHONG_BAN 
	WHERE TEN_PB  IN( 'QUAN LY' , 'SAN XUAT LINH KIEN')
)

--C2 DÙNG INNER JOIN
SELECT A.*
FROM NHAN_VIEN A
INNER JOIN PHONG_BAN B ON A.PHG = B.MA_PB
WHERE TEN_PB IN( 'QUAN LY' , 'SAN XUAT LINH KIEN')

--C3 DÙNG PHÉP TICH
SELECT A.*
FROM NHAN_VIEN A, PHONG_BAN B
WHERE A.PHG = B.MA_PB
AND TEN_PB IN( 'QUAN LY' , 'SAN XUAT LINH KIEN')


--VD9: Hiển thị nhân viên có tham gia vào dự án
SELECT A.*, B.MA_NHANVIEN
FROM NHAN_VIEN A, QUANLY_DUAN B
WHERE B.MA_NHANVIEN = A.ID_NHANVIEN


SELECT *
FROM NHAN_VIEN
WHERE ID_NHANVIEN IN ( 
	SELECT * 
	FROM QUANLY_DUAN
)


--VD10: Hiển thị nhân viên có lương lớn hơn lương của nhân viên phòng PB001
SELECT *
FROM NHAN_VIEN 
WHERE LUONG > ANY(
	SELECT LUONG
	FROM NHAN_VIEN 
	WHERE PHG LIKE 'PB001'
)

--VD11: Viết câu truy vấn hiển thị thông tin nhân viên nếu có ít nhất một nhân viên tồn tại
SELECT *
FROM NHAN_VIEN
WHERE EXISTS (
	SELECT *
	FROM NHAN_VIEN
)

-- BÀI 3 LAB6 (2Đ)
--Viết câu truy vấn để hiển thị thông tin gồm mã nhân viên, họ tên, lương của nhân viên
--đã tham gia từ 3 dự án trở lên
SELECT NV.ID_NHANVIEN, NV.HO_NV + ' ' + NV.TEN_NV AS HOVATEN, NV.LUONG
FROM NHAN_VIEN NV
INNER JOIN QUANLY_DUAN QD ON NV.ID_NHANVIEN = QD.MA_NHANVIEN
GROUP BY NV.ID_NHANVIEN, NV.HO_NV + ' ' + NV.TEN_NV, NV.LUONG
HAVING COUNT(QD.MA_NHANVIEN) >= 3;

--Viết câu truy vấn để hiển thị tổng số giờ đã làm trong các dự án của mỗi Nhân viên
SELECT A.*, SUM(B.SO_GIO) AS TONGGIOLAM
FROM NHAN_VIEN A
INNER JOIN QUANLY_DUAN B ON A.ID_NHANVIEN = B.MA_NHANVIEN
GROUP BY A.ID_NHANVIEN, A.DIA_CHI, A.GIOI_TINH, A.HO_NV, A.LUONG, A.NGAY_SINH, A.PHG, A.TEN_NV, A.NQL




