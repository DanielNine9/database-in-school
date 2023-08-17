USE QLKHAMBENH
GO
-- 1)	Hiển thị thông tin của các bệnh nhân ở O Mon. (1 đ) 
SELECT * 
FROM BENHNHAN
WHERE DIACHI LIKE '%O MON%'

-- 2)	Hiển thị thông tin bác sĩ, sắp xếp danh sách theo tên bác sĩ giảm dần. (1 đ) 
SELECT *
FROM BACSI
ORDER BY TENBS DESC

-- 3)	Viết câu truy vấn hiển thị: TENBN, TENBENH, NGAYVAO, NGAYRA do bác sĩ Le Hoang Thang phụ trách. Lưu kết quả truy vấn vào bảng BACSI_THANG (1 đ)  
SELECT TENBN, TENBENH, NGAYVAO, NGAYRA
INTO BACSI_THANG
FROM BENHNHAN A 
INNER JOIN CHITIET B ON A.MABN = B.MABN
INNER JOIN BENH C ON C.MABENH = B.MABENH
WHERE MABS = (
	SELECT MABS 
	FROM BACSI
	WHERE TENBS LIKE '%LE HOANG THANG%'
) 

-- 4)	Cập nhật ngày vào viện là 15-02-2009 cho bệnh nhân Dinh Thi Diep,
-- bệnh Than da nang do bác sĩ Le Thi Thuy Huynh phụ trách. (1 đ) 
UPDATE CHITIET
SET NGAYVAO = '2009-02-15'
WHERE MABN = (
	SELECT MABN
	FROM BENHNHAN
	WHERE TENBN LIKE '%DINH THI DIEP%'
) AND MABENH = (
	SELECT MABENH
	FROM BENH
	WHERE TENBENH LIKE '%THAN DA NANG%'
)AND MABS = (
	SELECT MABS 
	FROM BACSI 
	WHERE TENBS LIKE '%LE THI THUY HUYNH%'
)

-- 5)	Thống kê đếm số lượt bệnh nhân vào viện mỗi tháng. Thông tin hiển thị: 
-- THANGVAOVIEN, SOLUOTBN. (1 đ) 
SELECT MONTH(NGAYVAO) AS THANGVAOVIEN, COUNT(*) AS SOLUOTBN
FROM CHITIET
GROUP BY MONTH(NGAYVAO)

-- 6)	Cho biết những tháng có số lượt bệnh nhân vào viện nhiều nhất. Thông tin hiển thị: 
-- THANGVAOVIEN, SOLUOTBN. (1 đ) 
SELECT TOP 1 WITH TIES MONTH(NGAYVAO) AS THANGVAOVIEN, COUNT(*) AS SOLUOTBN
FROM CHITIET
GROUP BY MONTH(NGAYVAO)
ORDER BY COUNT(*) DESC

