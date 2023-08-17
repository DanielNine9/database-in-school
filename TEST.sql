CREATE DATABASE QLTHUVIEN_PC07859;
GO

USE QLTHUVIEN_PC07859
GO

-- Y4. Tạo các bảng trong CSDL, tạo các ràng buộc: khoá chính, khoá ngoại, ràng buộc duy
-- nhất, ràng buộc kiểm tra ...

CREATE TABLE CHUYENNGANH (
    MaChuyenNganh VARCHAR(10) NOT NULL,
    TenChuyenNganh NVARCHAR(50) NOT NULL	
);
GO

CREATE TABLE THONGTINLIENHE (																					 
    MaThongTin VARCHAR(10) NOT NULL,																						 
    Email VARCHAR(50) NOT NULL UNIQUE,
    SoDienThoai INT NOT NULL UNIQUE
);
GO

CREATE TABLE VITRIDATSACH (
    MaViTri VARCHAR(10) NOT NULL,
    TenViTri NVARCHAR(30) NOT NULL
);
GO

CREATE TABLE NHAXUATBAN (
    MaNhaXuatBan VARCHAR(10) NOT NULL,
    TenNhaXuatBan NVARCHAR(30) NOT NULL
);
GO

CREATE TABLE LOAISACH(
	MaLoai VARCHAR(10) NOT NULL,
	TenLoai NVARCHAR(30) NOT NULL UNIQUE,
)
GO

CREATE TABLE SACH (
    MaSach VARCHAR(10) NOT NULL,
    TieuDe NVARCHAR(50) NOT NULL,
	TenSach NVARCHAR(50) NOT NULL,
    SoTrang INT NOT NULL,
    SLBS INT NOT NULL,
    GiaTien MONEY NOT NULL,
    NgayNhapKho DATE NOT NULL,
    MaViTri VARCHAR(10),
    MaLoai VARCHAR(10),
    MaNhaXuatBan VARCHAR(10)
);
GO

CREATE TABLE TACGIA (
    MaTacGia VARCHAR(10) NOT NULL,
    TenTacGia NVARCHAR(50) NOT NULL 
);
GO

CREATE TABLE VIET (
    MaTacGia VARCHAR(10) NOT NULL,
    MaSach VARCHAR(10) NOT NULL,
);
GO

CREATE TABLE THESINHVIEN (
    MaSinhVien VARCHAR(10) NOT NULL,
    TenSinhVien NVARCHAR(20) NOT NULL,
    NgayHetHan DATE NOT NULL,
    MaThongTin VARCHAR(10),
    MaChuyenNganh VARCHAR(10),
);
GO

CREATE TABLE PHIEUMUON (
    MaPhieuMuon INT IDENTITY(1, 1) NOT NULL ,
    NgayMuon DATE NOT NULL,
    NgayTra DATE NOT NULL,
    TrangThai NVARCHAR(50) NOT NULL,
    MaSinhVien VARCHAR(10),
);
GO

CREATE TABLE PHIEUMUONCHITIET (
    MaPhieuMuonChiTiet VARCHAR(10) NOT NULL,
    SoThuTu INT NOT NULL,
    GhiChu NVARCHAR(50),
    MaPhieuMuon INT,
    MaNhaXuatBan VARCHAR(10),
    MaSach VARCHAR(10),
);
GO

-- CREATE PRIMARY KEY
ALTER TABLE PHIEUMUONCHITIET ADD CONSTRAINT PK_PHIEUMUONCHITIET PRIMARY KEY(MaPhieuMuonChiTiet)

ALTER TABLE SACH ADD CONSTRAINT PK_SACH PRIMARY KEY(MaSach)

ALTER TABLE TACGIA ADD CONSTRAINT PK_TACGIA PRIMARY KEY(MaTacGia)

ALTER TABLE VIET ADD CONSTRAINT PK_VIET PRIMARY KEY(MaTacGia, MaSach)

ALTER TABLE VITRIDATSACH ADD CONSTRAINT PK_VITRIDATSACH PRIMARY KEY(MaViTri)

ALTER TABLE THONGTINLIENHE ADD CONSTRAINT PK_TTLH PRIMARY KEY(MaThongTin)

ALTER TABLE CHUYENNGANH ADD CONSTRAINT PK_CHUYENNGANH PRIMARY KEY(MaChuyenNganh)

ALTER TABLE PHIEUMUON ADD CONSTRAINT PK_PHIEUMUON PRIMARY KEY(MaPhieuMuon)

ALTER TABLE THESINHVIEN ADD CONSTRAINT PK_THESINHVIEN PRIMARY KEY(MaSinhVien)

ALTER TABLE NHAXUATBAN ADD CONSTRAINT PK_NHAXUATBAN PRIMARY KEY(MaNhaXuatBan)

ALTER TABLE LOAISACH ADD CONSTRAINT PK_LOAISACH PRIMARY KEY(MaLoai)

-- CREATE FOREIGN KEY
ALTER TABLE SACH ADD CONSTRAINT FK_SACH_VITRI FOREIGN KEY(MaViTri) REFERENCES VITRIDATSACH(MaViTri)
ALTER TABLE SACH ADD CONSTRAINT FK_SACH_LOAI FOREIGN KEY(MaLoai) REFERENCES LOAISACH(MaLoai)
ALTER TABLE SACH ADD CONSTRAINT FK_SACH_NHAXUATBAN FOREIGN KEY(MaNhaXuatBan) REFERENCES NHAXUATBAN(MaNhaXuatBan)

ALTER TABLE PHIEUMUONCHITIET ADD CONSTRAINT FK_PMCT_PM FOREIGN KEY(MaPhieuMuon) REFERENCES PHIEUMUON(MaPhieuMuon)
ALTER TABLE PHIEUMUONCHITIET ADD CONSTRAINT FK_PMCT_NXB FOREIGN KEY(MaNhaXuatBan) REFERENCES NHAXUATBAN(MaNhaXuatBan)						
ALTER TABLE PHIEUMUONCHITIET ADD CONSTRAINT FK_PMCT_Sach FOREIGN KEY(MaSach) REFERENCES SACH(MaSach)

ALTER TABLE VIET ADD CONSTRAINT FK_VIET_TACGIA FOREIGN KEY(MaTacGia) REFERENCES TACGIA(MaTacGia)
ALTER TABLE VIET ADD CONSTRAINT FK_VIET_SACH FOREIGN KEY(MaSach) REFERENCES SACH(MaSach)

ALTER TABLE PHIEUMUON ADD CONSTRAINT FK_PM_SV FOREIGN KEY(MaSinhVien) REFERENCES THESINHVIEN(MaSinhVien)

ALTER TABLE THESINHVIEN ADD CONSTRAINT FK_TSV_TT FOREIGN KEY(MaThongTin) REFERENCES THONGTINLIENHE(MaThongTin)
ALTER TABLE THESINHVIEN ADD CONSTRAINT FK_TSV_CN FOREIGN KEY(MaChuyenNganh) REFERENCES CHUYENNGANH(MaChuyenNganh)

-- CREATE CONSTRAINT
ALTER TABLE SACH ADD CONSTRAINT SACH_CONSTRAINT_SOTRANG CHECK(SoTrang > 5)
ALTER TABLE SACH ADD CONSTRAINT SACH_CONSTRAINT_SLBS CHECK(SLBS > 1)
ALTER TABLE SACH ADD CONSTRAINT SACH_CONSTRAINT_GIATIEN CHECK(GiaTien > 0)
ALTER TABLE PHIEUMUON ADD CONSTRAINT CK_PHIEUMUON_NGAYTRA CHECK (NgayTra >= NgayMuon);
ALTER TABLE PHIEUMUONCHITIET ADD CONSTRAINT CK_PHIEUMUONCHITIET_MAX_QUYEN CHECK (
    (MaSach IS NOT NULL AND SoThuTu BETWEEN 1 AND 3)
    OR (MaSach IS NULL AND SoThuTu = 0)
);

-- Y5. Nhập dữ liệu vào cho các bảng (ít nhất 5 bản ghỉ trên mỗi bảng)

INSERT INTO CHUYENNGANH (MaChuyenNganh, TenChuyenNganh)
VALUES
    ('CN001', N'Kinh tế'),
    ('CN002', N'Công nghệ thông tin'),
    ('CN003', N'Du lịch'),
    ('CN004', N'Văn học'),
	 ('CN021', N'Tiếng Anh'),
    ('CN022', N'Hóa học ứng dụng'),
    ('CN023', N'Kỹ thuật phần mềm'),
    ('CN024', N'Sinh học đại cương'),
    ('CN025', N'Tiếng Nhật'),
    ('CN041', N'Quản trị kinh doanh'),
    ('CN042', N'Kỹ thuật điện'),
    ('CN043', N'Tâm lý học học tập'),
    ('CN044', N'Lịch sử triết học'),
    ('CN045', N'Điện tử viễn thông'),
    ('CN005', N'Ngoại ngữ');
GO

INSERT INTO THONGTINLIENHE (MaThongTin, Email, SoDienThoai)
VALUES 
    ('TT001', 'nguyenvana@example.com', '0123456789'),
    ('TT002', 'tranthib@example.com', '0987654321'),
    ('TT003', 'levanc@example.com', '0369852147'),
    ('TT004', 'phamthid@example.com', '0777123456'),
    ('TT005', 'ngoding@example.com', '0909123456'),
	 ('TT021', 'tranvany@example.com', '0987000001'),
    ('TT022', 'phandinhz@example.com', '0123000002'),
    ('TT023', 'nguyenminhz@example.com', '0369000003'),
    ('TT024', 'lethienk@example.com', '0777000004'),
    ('TT025', 'dinhngocl@example.com', '0909000005'),
    ('TT041', 'nguyenv@example.com', '0123456784'),
    ('TT042', 'leth@example.com', '0987654322'),
    ('TT043', 'phaml@example.com', '0932123456'),
    ('TT044', 'tranth@example.com', '0869876543'),
    ('TT045', 'voq@example.com', '0909123455');
GO

INSERT INTO VITRIDATSACH (MaViTri, TenViTri)
VALUES 
    ('VT001', N'Kệ A1'),
    ('VT002', N'Kệ B2'),
    ('VT003', N'Kệ C3'),
    ('VT004', N'Kệ D4'),
    ('VT005', N'Kệ E5'),
	 ('VT021', N'Kệ K11'),
    ('VT022', N'Kệ L12'),
    ('VT023', N'Kệ M13'),
    ('VT024', N'Kệ N14'),
    ('VT025', N'Kệ O15'),
    ('VT041', N'Kệ P16'),
    ('VT042', N'Kệ Q17'),
    ('VT043', N'Kệ R18'),
    ('VT044', N'Kệ S19'),
    ('VT045', N'Kệ T20');
GO

INSERT INTO NHAXUATBAN (MaNhaXuatBan, TenNhaXuatBan)
VALUES 
    ('NXB001', N'Nhà Xuất Bản Trẻ'),
    ('NXB002', N'Nhà Xuất Bản Kim Đồng'),
    ('NXB003', N'Nhà Xuất Bản Bloomsbury'),
    ('NXB004', N'Nhà Xuất Bản Nhi Đồng'),
    ('NXB005', N'Nhà Xuất Bản Văn Học'),
	('NXB006', N'Nhà Xuất Bản SQL'),
	 ('NXB021', N'Nhà Xuất Bản Trẻ'),
    ('NXB022', N'Nhà Xuất Bản Giáo Dục'),
    ('NXB023', N'Nhà Xuất Bản Thế Giới'),
    ('NXB024', N'Nhà Xuất Bản Hội Nhà Văn'),
    ('NXB025', N'Nhà Xuất Bản Kim Đồng'),
    ('NXB041', N'Nhà Xuất Bản Hà Nội'),
    ('NXB042', N'Nhà Xuất Bản Văn Học'),
    ('NXB043', N'Nhà Xuất Bản Chính Trị'),
    ('NXB044', N'Nhà Xuất Bản Văn Nghệ'),
    ('NXB045', N'Nhà Xuất Bản Thanh Niên');
GO

INSERT INTO LOAISACH (MaLoai, TenLoai)
VALUES 
    ('L001', N'Kinh tế'),
    ('IT', N'Công nghệ thông tin'),
    ('L003', N'Sách ngoại ngữ'),
    ('L004', N'Sách thiếu nhi'),
    ('L005', N'Khoa học tự nhiên'),
	('L021', N'Thể dục'),
    ('L022', N'Thể thao'),
    ('L023', N'Văn học Việt Nam'),
    ('L024', N'Tiểu thuyết cổ điển'),
    ('L025', N'Văn hóa lịch sử Việt Nam'),
    ('L041', N'Văn học nước ngoài'),
    ('L042', N'Thiếu nhi'),
    ('L043', N'Khoa học viễn tưởng'),
    ('L044', N'Chính trị học'),
    ('L045', N'Văn hóa thế giới');
GO

INSERT INTO SACH (MaSach, TieuDe, TenSach, SoTrang, SLBS, GiaTien, NgayNhapKho, MaViTri, MaLoai, MaNhaXuatBan)
VALUES
    ('MS001', N'Chuyện Kinh Tế 1', 'Chuyen Kinh Te 1', 200, 3, 40000, '2013-08-06', 'VT001', 'L001', 'NXB001'),
    ('MS002', N'Học SQL cơ bản', 'Chuyen SQL', 250, 5, 55000, '2023-08-06', 'VT002', 'IT', 'NXB002'),
    ('MS003', N'Tin Học Căn Bản', 'Tin Hoc Can Ban', 180, 4, 50000, '2023-08-06', 'VT003', 'IT', 'NXB003'),
    ('MS004', N'Lập Trình Python', 'Lap Trinh Python', 300, 6, 75000, '2023-08-06', 'VT004', 'IT', 'NXB004'),
    ('MS005', N'Du Lịch Vui Vẻ', 'Du Lich Vui Ve', 180, 4, 60000, '2023-08-06', 'VT005', 'L004', 'NXB005'),
	('MS006', N'Du Lịch Vui Vẻ', 'Du Lich Vui Ve', 180, 4, 60000, '2023-08-06', 'VT005', 'L004', 'NXB005'),
	 ('MS021', N'Tiếng Anh cơ bản', N'Tiếng Anh cơ bản', 150, 3, 120000, '2023-08-09', 'VT021', 'L021', 'NXB021'),
    ('MS022', N'Kỹ thuật hóa học ứng dụng', N'Kỹ thuật hóa học ứng dụng', 320, 8, 230000, '2023-08-10', 'VT022', 'L022', 'NXB022'),
    ('MS023', N'Học kỹ năng SQL', N'Học kỹ năng SQL', 180, 6, 150000, '2023-08-11', 'VT023', 'L023', 'NXB023'),
    ('MS024', N'Đại cương về sinh học', N'Đại cương về sinh học', 220, 5, 180000, '2023-08-12', 'VT024', 'L024', 'NXB024'),
    ('MS025', N'Tiếng Nhật cơ bản', N'Tiếng Nhật cơ bản', 160, 4, 110000, '2023-08-13', 'VT025', 'L025', 'NXB025'),
	('MS041', N'Những tiểu thuyết nổi tiếng', N'Những tiểu thuyết nổi tiếng', 400, 12, 300000, '2023-08-27', 'VT041', 'L041', 'NXB041'),
    ('MS042', N'Sách cho thiếu nhi', N'Sách cho thiếu nhi', 240, 7, 160000, '2023-08-28', 'VT042', 'L042', 'NXB042'),
    ('MS043', N'Khoa học viễn tưởng đỉnh cao', N'Khoa học viễn tưởng đỉnh cao', 480, 10, 340000, '2023-08-29', 'VT043', 'L043', 'NXB043'),
    ('MS044', N'Chính trị học hiện đại', N'Chính trị học hiện đại', 300, 9, 250000, '2023-08-30', 'VT044', 'L044', 'NXB044'),
    ('MS045', N'Văn hóa thế giới trong lịch sử', N'Văn hóa thế giới trong lịch sử', 360, 11, 270000, '2023-08-31', 'VT045', 'L045', 'NXB045');
GO

INSERT INTO TACGIA (MaTacGia, TenTacGia)
VALUES 
    ('TG001', N'Nguyễn Nhật Ánh'),
    ('TG002', N'Margaret Mitchell'),
    ('TG003', N'J.K. Rowling'),
    ('TG004', N'To Hoài'),
    ('TG005', N'Nguyễn Nhat Anh'),
	 ('TG021', N'Trần Văn X1'),
    ('TG022', N'Phan Đình Y1'),
    ('TG023', N'Nguyễn Minh Z1'),
    ('TG024', N'Lê Thiên K1'),
    ('TG025', N'Đinh Ngọc L1'),
    ('TG041', N'Trần Văn X2'),
    ('TG042', N'Phan Đình Y2'),
    ('TG043', N'Nguyễn Minh Z2'),
    ('TG044', N'Lê Thiên K2'),
    ('TG045', N'Đinh Ngọc L2');
GO



INSERT INTO VIET (MaTacGia, MaSach)
VALUES 
    ('TG001', 'MS001'),
    ('TG002', 'MS002'),
    ('TG003', 'MS003'),
    ('TG004', 'MS004'),
    ('TG005', 'MS005'),
	('TG021', 'MS021'),
    ('TG022', 'MS022'),
    ('TG023', 'MS023'),
    ('TG024', 'MS024'),
    ('TG025', 'MS025'),
    ('TG041', 'MS041'),
    ('TG042', 'MS042'),
    ('TG043', 'MS043'),
    ('TG044', 'MS044'),
    ('TG045', 'MS045');
GO


INSERT INTO THESINHVIEN (MaSinhVien, TenSinhVien, NgayHetHan, MaThongTin, MaChuyenNganh)
VALUES 
    ('SV001', N'Nguyễn Văn A', '2023-12-31', 'TT001', 'CN001'),
    ('SV002', N'Trần Thị B', '2023-11-30', 'TT002', 'CN002'),
    ('PD12301', N'Lê Văn C', '2024-01-15', 'TT003', 'CN003'),
    ('SV004', N'Phạm Thị D', '2023-12-31', 'TT004', 'CN004'),
    ('SV005', N'Ngô Đình E', '2023-10-31', 'TT005', 'CN005'),
	('SV006', N'Ngô Đình Thái', '2023-10-31', 'TT005', 'CN005'),
	('SV021', N'Phạm Văn M1', '2024-05-31', 'TT021', 'CN021'),
    ('SV022', N'Ngô Thị N1', '2024-04-30', 'TT022', 'CN022'),
    ('SV023', N'Trịnh Văn O1', '2024-06-15', 'TT023', 'CN023'),
    ('SV024', N'Lý Thị P1', '2024-05-31', 'TT024', 'CN024'),
    ('SV025', N'Võ Văn Q1', '2024-03-31', 'TT025', 'CN025'),
    ('SV041', N'Trịnh Văn O2', '2024-06-15', 'TT021', 'CN041'),
    ('SV042', N'Lý Thị P2', '2024-05-31', 'TT022', 'CN042'),
    ('SV043', N'Võ Văn Q2', '2024-03-31', 'TT023', 'CN043'),
    ('SV044', N'Trịnh Văn O3', '2024-06-15', 'TT024', 'CN044'),
    ('SV045', N'Lý Thị P3', '2024-05-31', 'TT025', 'CN045');
GO

INSERT INTO PHIEUMUON (NgayMuon, NgayTra, TrangThai, MaSinhVien)
VALUES
    ('2009-01-01', '2009-01-05', N'Chưa trả sách', 'SV001'),
	('2023-08-09', '2023-09-22', N'Đã trả sách', 'SV002'),
    ('2017-01-01', '2017-01-14', N'Chưa trả sách', 'PD12301'),
    ('2023-08-09', '2023-09-22', N'Đã trả sách', 'SV004'),
    ('2023-08-10', '2023-08-16', N'Chưa trả sách', 'SV005'),
	 ('2023-08-09', '2023-08-16', N'Đã trả', 'SV021'),
    ('2023-08-10', '2023-08-17', N'Đã trả', 'SV022'),
    ('2023-08-11', '2023-08-18', N'Đã trả', 'SV023'),
    ('2023-08-12', '2023-08-19', N'Đã trả', 'SV024'),
    ('2023-08-13', '2023-08-22', N'Chưa trả sách', 'SV025'),
    ('2023-08-27', '2023-09-03', N'Đã trả', 'SV041'),
    ('2023-08-28', '2023-09-04', N'Đã trả', 'SV042'),
    ('2023-08-29', '2023-09-05', N'Đã trả', 'SV043'),
    ('2023-08-30', '2023-09-06', N'Đã trả', 'SV044'),
    ('2023-08-31', '2023-09-22', N'Chưa trả sách', 'SV045'),
	  ('2023-09-01', '2023-09-08', N'Đã trả', 'SV006'),
    ('2023-09-02', '2023-09-09', N'Đã trả', 'SV006'),
    ('2023-09-03', '2023-09-10', N'Đã trả', 'SV006'),
    ('2023-09-04', '2023-09-11', N'Đã trả', 'SV006'),
    ('2023-09-05', '2023-09-12', N'Đã trả', 'SV006'),
    ('2023-09-06', '2023-09-13', N'Đã trả', 'SV006'),
    ('2023-09-07', '2023-09-14', N'Đã trả', 'SV006'),
    ('2023-09-08', '2023-09-15', N'Đã trả', 'SV006'),
    ('2023-09-09', '2023-09-16', N'Đã trả', 'SV006'),
    ('2023-09-10', '2023-09-17', N'Chưa trả sách', 'SV006'),
    ('2023-09-11', '2023-09-18', N'Đã trả', 'SV006'),
    ('2023-09-12', '2023-09-19', N'Đã trả', 'SV006'),
    ('2023-09-13', '2023-09-20', N'Đã trả', 'SV006'),
    ('2023-09-14', '2023-09-21', N'Đã trả', 'SV006'),
    ('2023-09-15', '2023-09-22', N'Đã trả', 'SV006'),
    ('2023-09-16', '2023-09-23', N'Đã trả', 'SV006'),
    ('2023-09-17', '2023-09-24', N'Đã trả', 'SV006'),
    ('2023-09-18', '2023-09-25', N'Đã trả', 'SV006'),
    ('2023-09-19', '2023-09-26', N'Đã trả', 'SV006'),
    ('2023-09-20', '2023-09-27', N'Đã trả', 'SV006');
GO


INSERT INTO PHIEUMUONCHITIET (MaPhieuMuonChiTiet, SoThuTu, GhiChu, MaPhieuMuon, MaNhaXuatBan, MaSach)
VALUES
    ('PMCT001', 1, N'Phiếu mượn số 1', 1, 'NXB001', 'MS001'),
    ('PMCT002', 1, N'Phiếu mượn số 2', 2, 'NXB002', 'MS002'),
    ('PMCT003', 1, N'Phiếu mượn số 3', 3, 'NXB003', 'MS003'),
    ('PMCT004', 1, N'Phiếu mượn số 4', 4, 'NXB004', 'MS004'),
    ('PMCT005', 1, N'Phiếu mượn số 5', 5, 'NXB005', 'MS005'),
	 ('PMCT021', 1, N'Phiếu mượn số 6',  6 , 'NXB021', 'MS021'),
    ('PMCT022', 1, N'Phiếu mượn số 7', 7 , 'NXB022', 'MS022'),
    ('PMCT023', 1, N'Phiếu mượn số 8',  8 , 'NXB023', 'MS023'),
    ('PMCT024', 1, N'Phiếu mượn số 9', 9 , 'NXB024', 'MS024'),
    ('PMCT025', 1, N'Phiếu mượn số 10',  10 , 'NXB025', 'MS025'),
    ('PMCT041', 1, N'Phiếu mượn số 11',  11 , 'NXB041', 'MS041'),
    ('PMCT042', 1, N'Phiếu mượn số 12', 12 , 'NXB042', 'MS042'),
    ('PMCT043', 1, N'Phiếu mượn số 13',  13 , 'NXB043', 'MS043'),
    ('PMCT044', 1, N'Phiếu mượn số 14', 14 , 'NXB044', 'MS044'),
    ('PMCT045', 1, N'Phiếu mượn số 15',  15 , 'NXB045', 'MS045'),
	('PMCT006_15', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_16', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_17', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_18', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_19', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_20', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_21', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_22', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_23', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_24', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_25', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_26', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_27', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_28', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_29', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_30', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_31', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_32', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_33', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_34', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006'),
    ('PMCT006_35', 1, N'Phiếu mượn x',  1 ,'NXB006', 'MS006');
GO


-- Y6. Viết các câu truy vấn sau:
USE QLTHUVIEN_PC07859
GO

-- 6.1 Liệt kê tất cả thông tin của các đầu sách gồm tên sách, mã sách, giá tiền , tác giả
-- thuộc loại sách có mã “IT”.
SELECT TENSACH, SACH.MASACH, GIATIEN, TACGIA.MaTacGia ,TENTACGIA
FROM SACH INNER JOIN VIET ON SACH.MaSach = VIET.MaSach 
INNER JOIN TACGIA ON TACGIA.MaTacGia = VIET.MaTacGia 
WHERE MaLoai = 'IT'

-- 6.2 Liệt kê các phiếu mượn gồm các thông tin mã phiếu mượn, mã sách , ngày mượn, mã
-- sinh viên có ngày mượn trong tháng 01/2017.
SELECT A.MaPhieuMuon, MaSach, NgayMuon, A.MaSinhVien
FROM PHIEUMUON A 
INNER JOIN PHIEUMUONCHITIET C ON A.MaPhieuMuon = C.MaPhieuMuon
WHERE MONTH(NGAYMUON) = 1 AND YEAR(NGAYMUON) = 2017

-- 6.3 Liệt kê các phiếu mượn chưa trả sách cho thư viên theo thứ tự tăng dần của ngày
-- mượn sách.
SELECT *
FROM PHIEUMUON
WHERE TrangThai LIKE N'%CHƯA TRẢ SÁCH%'
ORDER BY NgayMuon

-- 6.4 Liệt kê tổng số đầu sách của mỗi loại sách ( gồm mã loại sách, tên loại sách, tổng số
--lượng sách mỗi loại).
SELECT A.MaLoai, TenLoai, SUM(SLBS) as N'TỔNG SỐ LƯỢNG SÁCH MỖI LOẠI'
FROM SACH A
INNER JOIN LOAISACH B ON A.MaLoai = B.MaLoai
GROUP BY A.MaLoai, TenLoai

-- 6.5 Đếm xem có bao nhiêu lượt sinh viên đã mượn sách.
--CÁCH HIỂU 1 ĐẾM SỐ LƯỢNG SINH VIÊN ĐÃ MƯỢN SÁCH
SELECT COUNT(MaSinhVien) AS N'SINH VIÊN ĐÃ MƯỢN SÁCH'
FROM PHIEUMUON 
--CÁCH HIỂU 2 ĐẾM SỐ LƯỢNG SÁCH ĐƯỢC MƯỢN CỦA MỖI SINH VIÊN
SELECT MaSinhVien, COUNT(*) AS N'SÁCH ĐÃ MƯỢN'
FROM PHIEUMUON
GROUP BY MaSinhVien
--CÁCH HIỂU 3 ĐẾM SỐ LƯỢNG SINH VIÊN ĐÃ MƯỢN SÁCH ( MỖI SINH VIÊN RIÊNG BIỆT )
SELECT COUNT(DISTINCT MaSinhVien)  AS N'SINH VIÊN ĐÃ MƯỢN SÁCH'
FROM PHIEUMUON

-- 6.6 Hiển thị tất cả các quyển sách có tiêu đề chứa từ khoá “SQL”.
SELECT *
FROM SACH
WHERE TieuDe LIKE '%SQL%'

-- 6.7 Hiển thị thông tin mượn sách gồm các thông tin: mã sinh viên, tên sinh viên, mã
-- phiếu mượn, tiêu đề sách, ngày mượn, ngày trả. Sắp xếp thứ tự theo ngày mượn sách.
SELECT A.MaSinhVien, TenSinhVien, B.MaPhieuMuon, TieuDe, NgayMuon, NgayTra
FROM THESINHVIEN A
INNER JOIN PHIEUMUON B ON A.MaSinhVien = B.MaSinhVien 
INNER JOIN PHIEUMUONCHITIET C ON  C.MaPhieuMuon = B.MaPhieuMuon
INNER JOIN SACH D ON C.MaSach = D.MaSach 
ORDER BY NgayMuon

-- 6.8 Liệt kê các đầu sách có lượt mượn lớn hơn 20 lần.
--
SELECT TenSach AS N'ĐẦU SÁCH CÓ LƯỢT MƯỢN LỚN HƠN 20'
FROM SACH A 
INNER JOIN PHIEUMUONCHITIET B ON A.MaSach = B.MaSach 
INNER JOIN PHIEUMUON C ON C.MaPhieuMuon = B.MaPhieuMuon
GROUP BY TenSach
HAVING COUNT(MASINHVIEN) > 20

-- 6.9 Viết câu lệnh cập nhật lại giá tiền của các quyển sách có ngày nhập kho trước năm
-- 2014 giảm 30%.
UPDATE SACH 
SET GiaTien*= 0.7
WHERE YEAR(NgayNhapKho) < 2014

-- 6.10 Viết câu lệnh cập nhật lại trạng thái đã trả sách cho phiếu mượn của sinh viên có mã
-- sinh viên PD12301 (ví dụ).
UPDATE PHIEUMUON
SET TrangThai = N'ĐÃ TRẢ SÁCH'
WHERE MaSinhVien = 'PD12301'

-- 6.11 Lập danh sách các phiếu mượn quá hạn chưa trả gồm các thông tin: mã phiếu mượn,
-- tên sinh viên, email, danh sách các sách đã mượn, ngày mượn.
SELECT D.MaPhieuMuon, TenSinhVien, Email, E.*, NGAYMUON, TrangThai
INTO DANHSACHCACPHIEUMUONQUAHAN
FROM PHIEUMUON A 
INNER JOIN THESINHVIEN B ON A.MaSinhVien = B.MaSinhVien
INNER JOIN THONGTINLIENHE C ON B.MaThongTin = C.MaThongTin
INNER JOIN PHIEUMUONCHITIET D ON D.MaPhieuMuon = A.MaPhieuMuon
INNER JOIN SACH E ON E.MaSach = D.MaSach
WHERE DATEDIFF(DAY, NGAYMUON, NGAYTRA) > 7 AND TrangThai LIKE N'%CHƯA TRẢ SÁCH%'

-- 6.12 Viết câu lệnh cập nhật lại số lượng bản sao tăng lên 5 đơn vị đối với các đầu sách có
-- lượt mượn lớn hơn 10
UPDATE SACH
SET SLBS += 5
WHERE MaSach IN (
	SELECT MaSach
	FROM PHIEUMUONCHITIET A
	INNER JOIN PHIEUMUON B ON A.MaPhieuMuon = B.MaPhieuMuon
	GROUP BY MASACH
	HAVING COUNT(MASINHVIEN) > 10 
)

-- 6.13 Viết câu lệnh xoá các phiếu mượn có ngày mượn và ngày trả trước „1/1/2010‟
DELETE FROM PHIEUMUONCHITIET
WHERE MaPhieuMuon IN (
	SELECT MaPhieuMuon
	FROM PHIEUMUON
	WHERE NgayMuon < '01/01/2010' AND NgayTra < '01/01/2010' 
)
DELETE FROM PHIEUMUON
WHERE NgayMuon < '01/01/2010' AND NgayTra < '01/01/2010'




