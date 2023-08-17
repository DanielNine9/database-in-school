USE QUANLYBANHANG;

-- BAI 1. Tạo chỉ mục UNIQUE trên cột điện thoại và email của bảng khách hàng
-- a. Tạo chỉ mục UNIQUE trên cột điện thoại của bảng khách hàng
CREATE UNIQUE INDEX UI_DIENTHOAI ON KHACHHANG(DienThoai);

-- b. Tạo chỉ mục UNIQUE trên cột email của bảng khách hàng
CREATE UNIQUE INDEX UI_EMAIL ON KHACHHANG(Email);