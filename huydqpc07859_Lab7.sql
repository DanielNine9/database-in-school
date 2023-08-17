--01082023
USE QLNHANVIEN
GO

--1. THÊM DỮ LIỆU TỪ KẾT QUẢ TRUY VẤN VÀO BẢNG MỚI
-------------------------------------------
--VD1: Viết câu truy vấn hiển thị danh sách nhân viên ở Cần Thơ. 
--Lưu kết quả vào bảng NV_CT.
--Viết câu truy vấn hiển thị dữ liệu bảng NV_CT
SELECT *
INTO NV_CT
FROM NHAN_VIEN
WHERE DIA_CHI LIKE '%CAN THO'
GO 

SELECT * 
FROM NV_CT


--VD2: Viết câu truy vấn hiển thị danh sách các dự án năm 2016. 
--Lưu kết quả vào bảng DUAN2016. Viết câu truy vấn hiển thị dữ liệu bảng DUAN2016

SELECT * 
INTO DUAN2016
FROM DU_AN
WHERE YEAR(NGAY_BATDAU) = 2016

SELECT * 
FROM DUAN2016

--VD3: Viết câu truy vấn tính tổng số giờ tham gia dự án theo từng năm tham gia.
--Lưu kết quả vào bảng DUAN_SOGIO. Viết câu truy vấn hiển thị dữ liệu bảng DUAN_SOGIO
SELECT YEAR(NGAY_THAM_GIA) AS NAM, SUM(SO_GIO) AS TONGSOGIO
INTO DUAN_SOGIO
FROM QUANLY_DUAN
GROUP BY YEAR(NGAY_THAM_GIA)


--2. THÊM DỮ LIỆU NGƯỜI DÙNG NHẬP VÀO BẢNG ĐÃ TỒN TẠI
-------------------------------------------
--VD4: Thêm dữ liệu cho bảng dự án (MÃ DỰ ÁN LÀ DA004, TÊN DỰ ÁN LÀ: CÀI ĐẶT PHẦN MỀM, 
--NGÀY BẮT ĐẦU LÀ 01-01-2016 VÀ NGÀY KẾT THÚC LÀ 31-12-2016)
INSERT INTO DU_AN(MA_DUAN, TEN_DUAN, NGAY_BATDAU, NGAY_KETTHUC)
VALUES ('DA006', 'CAI DAT PHAM MEM', '01-01-2016', '12-31-2016')

INSERT INTO DU_AN 
VALUES ('DA004', 'CAI DAT PHAM MEM', '01-01-2016', '12-31-2016')

SELECT * 
FROM DU_AN

--VD5: Thêm dữ liệu cho bảng dự án (MÃ DỰ ÁN LÀ DA005, TÊN DỰ ÁN LÀ: TẬP HUẤN NHÂN VIÊN)
INSERT INTO DU_AN(MA_DUAN, TEN_DUAN)
VALUES ('DA005', 'TẬP HUẤN NHÂN VIÊN')

--3. THÊM DỮ LIỆU TỪ KẾT QUẢ TRUY VẤN VÀO BẢNG ĐÃ TỒN TẠI
-------------------------------------------
--VD6: Viết câu truy vấn hiển thị danh sách dự án bắt đầu năm 2016, ngoại trừ dự án DA001.
--Thêm dữ liệu vào bảng DUAN2016. Viết câu truy vấn hiển thị dữ liệu bảng DUAN2016
INSERT INTO DUAN2016
SELECT *
FROM DU_AN
WHERE YEAR(NGAY_BATDAU) = 2016
AND MA_DUAN != 'DA001' 

SELECT * 
FROM DUAN2016


--VD7: Tạo bảng THONGKE1, gồm 2 cột TENPB, SONV. 
--Viết câu truy vấn thống kê số nhân viên từng phòng ban. Lưu kết quả vào bảng THONGKE1
CREATE TABLE  THONGKE1(
	TENPB VARCHAR(50),
	SONV INT
)
INSERT INTO THONGKE1
SELECT TEN_PB, COUNT(ID_NHANVIEN)
FROM NHAN_VIEN A
INNER JOIN PHONG_BAN B ON A.PHG = B.MA_PB
GROUP BY TEN_PB
--VD8: Tạo bảng THONGKE2, gồm 2 cột TENDUAN, SONGAY. 
--Viết câu truy vấn thống kê số ngày triển khai của từng dự án. Lưu kết quả vào bảng THONGKE2
CREATE TABLE THONGKE2(
	TENDUAN VARCHAR(50),
	SONGAY INT
)
INSERT INTO THONGKE2
SELECT TEN_DUAN, DATEDIFF(DAY, NGAY_BATDAU, NGAY_KETTHUC)
FROM DU_AN

SELECT *
FROM THONGKE2

SELECT *
FROM QUANLY_DUAN

﻿--03082023
--VD1: Cập nhật phòng ban PB001 mã trưởng phòng là NV001
USE QLNHANVIEN
GO

SELECT *
FROM PHONG_BAN

UPDATE PHONG_BAN
SET MA_TRUONGPHONG = 'NV001'
WHERE MA_PB = 'PB001'


--VD2: Cập nhật tăng lương thêm 100 cho các nhân viên ở phòng Quan ly
UPDATE NHAN_VIEN 
SET LUONG = LUONG + 100
WHERE PHG = (
	SELECT MA_PB
	FROM PHONG_BAN
	WHERE MA_PB = PHG
	AND TEN_PB LIKE 'QUAN LY'
)



-- LAB 7
-- A. THEM DU LIEU
USE QuanLyBanHang
GO
-- Insert Customer KhachHang
--Bài 1 (4 điểm) Viết các câu DML để thực hiện các công việc sau:
--a. Sử dụng câu lệnh INSERT để thêm dữ liệu các các bảng như sau:
--KhachHang
-- Insert KhachHang KH006
INSERT INTO KhachHang (maKhachHang, hoVaTenLot, Ten, DiaChi, Email, DienThoai)
VALUES ('KH006', 'Nguyễn Thị','Nga', '15 Quang Trung TP Đà Nẵng', 'ngant@gamil.com', '0912345670');

-- Insert KhachHang KH007
INSERT INTO KhachHang (maKhachHang, hoVaTenLot, Ten, DiaChi, Email, DienThoai)
VALUES ('KH007', 'Trần Công', 'Thành', '234 Lê Lợi Quảng Nam', 'thanhtc@gmail.com', '16109423443');

-- Insert KhachHang KH008
INSERT INTO KhachHang (maKhachHang, hoVaTenLot, Ten, DiaChi, Email, DienThoai)
VALUES ('KH008', 'Lê Hoàng', 'Nam', '23 Trần Phú TP Huế', 'namlt@yahoo.com', '0989354556');

-- Insert KhachHang KH009
INSERT INTO KhachHang (maKhachHang, hoVaTenLot, Ten, DiaChi, Email, DienThoai)
VALUES ('KH009', 'Vũ Ngọc', 'Hiền' ,'37 Nguyễn Thị Thập TP Đà Nẵng', 'hienvn@gmail.com', '0894545435');


-- SanPham
-- Insert SanPham 1
INSERT INTO SanPham (maSanPham, moTa, soLuong, donGia, tenSP)
VALUES (1, 'Samsung Galaxy J7 Pro là một chiếc smartphone phù hợp với những người yêu thích một sản phẩm pin tốt, thích hệ điều hành mới cùng những tính năng đi kèm độc quyền', 800, 6600000, 'Samsung Galaxy J7 Pro');

-- Insert SanPham 2
INSERT INTO SanPham (maSanPham, moTa, soLuong, donGia, tenSP)
VALUES (2, 'iPhone 6 là một trong những smartphone được yêu thích nhất. Lắng nghe nhu cầu về thiết kế, khả năng lưu trữ và giá cả, iPhone 6 32GB được chính thức phân phối chính hãng tại Việt Nam hứa hẹn sẽ là một sản phẩm rất "Hot"', 500, 8990000, 'iPhone 6 32GB');

-- Insert SanPham 3
INSERT INTO SanPham (maSanPham, moTa, soLuong, donGia, tenSP)
VALUES (3, 'Dell Inspiron 3467 i3 7100U/4GB/1TB/Win10/(M20NR21) Laptop Dell Inspiron 3467', 507, 11290000, '');

-- Insert SanPham 4
INSERT INTO SanPham (maSanPham, moTa, soLuong, donGia, tenSP)
VALUES (4, 'Pin sạc dự phòng Polymer 5.000 mAh eSaver JP85 Pin sạc dự phòng', 600, 200000, '');

-- Insert SanPham 5
INSERT INTO SanPham (maSanPham, moTa, soLuong, donGia, tenSP)
VALUES (5, 'Nokia 3100 phù hợp với SINH VIÊN', 100, 700000, 'Nokia 3100');

--HoaDon
-- Insert HoaDon 1
INSERT INTO HoaDon (maKhachHang, maHoaDon, ngayMuaHang, trangThai)
VALUES ('KH001', 120954, '2016-03-23', 'Đã thanh toán');

-- Insert HoaDon 2
INSERT INTO HoaDon (maKhachHang, maHoaDon, ngayMuaHang, trangThai)
VALUES ('KH002', 120955, '2016-04-02', 'Đã thanh toán');

-- Insert HoaDon 3
INSERT INTO HoaDon (maKhachHang, maHoaDon, ngayMuaHang, trangThai)
VALUES ('KH001', 120956, '2016-07-12', 'chưa thanh toán');

-- Insert HoaDon 4
INSERT INTO HoaDon (maKhachHang, maHoaDon, ngayMuaHang, trangThai)
VALUES ('KH004', 125957, '2016-12-04', 'chưa thanh toán');


-- HoDonChiTiet
-- Insert HoaDonChiTiet 1
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (1, 120954, 3, 40);

-- Insert HoaDonChiTiet 2
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (2, 120954, 1, 20);

-- Insert HoaDonChiTiet 3
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (3, 120955, 2, 100);

-- Insert HoaDonChiTiet 4
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (4, 120956, 4, 6);

-- Insert HoaDonChiTiet 5
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (5, 120956, 2, 60);

-- Insert HoaDonChiTiet 6
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (6, 120956, 1, 10);

-- Insert HoaDonChiTiet 7
INSERT INTO HoaDonChiTiet (maHoaDonChiTiet, maHoaDon, maSanPham, soLuong)
VALUES (7, 125957, 2, 50);
 --Cau b
SELECT *
INTO KhachHang_daNang
FROM KhachHang
WHERE KhachHang.DiaChi LIKE '%DA NANG%';

-- Bài 2 (4 điểm) Viết các câu lệnh để cập nhật lại dữ liệu cho các bảng
-- a. Cập nhật lại thông tin số điện thoại của khách hàng có mã ‘KH002’ có giá trị mới
-- là ‘16267788989’
USE QUANLYBANHANG
GO

UPDATE KHACHHANG
SET DIENTHOAI = '16267788989'
WHERE maKhachHang = 'KH002'

-- b. Tăng số lượng mặt hàng có mã ‘3’ lên thêm ‘200’ đơn vị
UPDATE SanPham
SET SOLUONG += 200
WHERE MaSanPham = 3

-- c. Giảm giá cho tất cả sản phẩm giảm 5%
UPDATE SANPHAM
SET DONGIA *= 0.95

-- d. Tăng số lượng của mặt hàng bán chạy nhất trong tháng 12/2016 lên 100 đơn vị
UPDATE SANPHAM
SET SOLUONG += 100
WHERE MaSanPham IN (
	SELECT B.MaSanPham
	FROM HoaDon A
	INNER JOIN HoaDonChiTiet B ON A.MaHoaDon = B.maHoaDon
	WHERE A.NgayMuaHang >= '12/01/2016' AND A.NgayMuaHang <= '12/31/2016'
	GROUP BY B.MaSanPham
	HAVING SUM(B.SOLUONG) = (
		SELECT MAX(TONG)
		FROM (
			SELECT MaSanPham, SUM(SoLuong) AS TONG
			FROM HoaDonChiTiet
			WHERE MaHoaDon IN (
				SELECT MaHoaDon
				FROM HoaDon
				WHERE NgayMuaHang >= '12/01/2016' AND NgayMuaHang <= '12/31/2016'
			)
			GROUP BY MaSanPham
		) AS SUBQUERY
	)
)

--e. Giảm giá 10% cho 2 sản phẩm bán ít nhất trong năm 2016
UPDATE SANPHAM
SET SOLUONG*=0.9
WHERE MaSanPham IN (
	SELECT TOP 2 MASANPHAM
	FROM HOADONCHITIET A
	INNER JOIN HOADON B ON A.maHoaDon = B.MaHoaDon AND YEAR(B.NGAYMUAHANG) = 2016
	GROUP BY MASANPHAM
	ORDER BY SUM(SOLUONG) DESC
)

-- f. Cập nhật lại trạng thái “đã thanh toán” cho hoá đơn có mã 120956
UPDATE HoaDon
SET TrangThai = N'đã thanh toán'
WHERE MaHoaDon = '120956';

-- g. Xoá mặt hàng có mã sản phẩm là ‘2’ ra khỏi hoá đơn ‘120956’ và trạng thái là chưa thanh toán.
DELETE FROM HoaDonChiTiet
WHERE HoaDonChiTiet.MaSanPham = 2
AND HoaDonChiTiet.MaHoaDon IN (
	SELECT MaHoaDon
	FROM HoaDon
	WHERE HoaDon.MaHoaDon = '120956' AND HoaDon.TrangThai = N'chưa thanh toán'
);

-- h. Xoá khách hàng chưa từng mua hàng kể từ ngày “1-1-2016”
DELETE FROM KhachHang
WHERE MaKhachHang NOT IN (
    SELECT DISTINCT A.MaKhachHang
    FROM KhachHang A
    LEFT JOIN HoaDon B ON A.MaKhachHang = B.MaKhachHang
    WHERE B.NgayMuaHang >= '2016-01-01'
);


--LAB7 CÂU 3A
--Cập nhật tăng lương thêm 10% cho các nhân viên có tham gia vào dự án có mã dự án DA001
UPDATE NHAN_VIEN
SET LUONG = LUONG + (LUONG * 0.1)
WHERE ID_NHANVIEN IN  (
	SELECT MA_NHANVIEN
	FROM QUANLY_DUAN
	WHERE MA_DUAN = 'DA001'
)


SELECT * 
FROM QUANLY_DUAN



--Cập nhật Phòng ban “Quản lý” có trưởng phòng là “Phan Anh Tuan” 
SELECT *
FROM PHONG_BAN

-- CÁCH HIỂU 1
UPDATE PHONG_BAN
SET TEN_PB = 'QUẢN LÝ'
WHERE MA_TRUONGPHONG = (
	SELECT ID_NHANVIEN
	FROM NHAN_VIEN
	WHERE HO_NV + ' ' + TEN_NV LIKE 'PHAN ANH TUAN'
)

-- CÁCH HIỂU 2
UPDATE PHONG_BAN
SET MA_TRUONGPHONG = (
	SELECT ID_NHANVIEN
	FROM NHAN_VIEN
	WHERE HO_NV + ' ' + TEN_NV LIKE 'PHAN ANH TUAN'
)
WHERE TEN_PB LIKE 'QUAN LY'

--VD3: Xoá Phòng Ban có mã ‘PB007’
DELETE FROM PHONG_BAN
WHERE MA_PB = 'PB007'


--LAB7 CÂU 3B
--Thêm dự án MÃ DA006 tên Tu thien ngày bắt đầu 31-01-2018, 
--MÃ DA007 tên Tu thien 2 ngày bắt đầu 31-07-2018
USE QLNHANVIEN

INSERT INTO DU_AN(MA_DUAN, TEN_DUAN, NGAY_BATDAU)
VALUES ('DA006', 'Tu thien', '31-01-2018'),
('DA007', 'Tu thien', '31-07-2018')

--Xoá các dự án có ngày bắt đầu năm 2018
DELETE FROM DU_AN
WHERE YEAR(NGAY_BATDAU) >= 2018


--Xoá các Phòng ban không có nhân viên nào. Gợi ý: mã phòng k có trong NHANVIEN
DELETE FROM PHONG_BAN
WHERE MA_PB NOT IN ( 
	SELECT PHG
	FROM NHAN_VIEN
)


-- Em xin chân thành cám mơn cô vì đã dành thời gian quý báo của mình để xem bài lab 7 của em ạ
