-- 1) Hiển thị thông tin các công trình ở Soc Trang, kinh phí từ 60000 đến 100000.  
USE CONGTRINH1
SELECT *
FROM CONGTRINH
WHERE TINHTHANH LIKE '%SOC TRANG%'
AND KINHPHI BETWEEN 60000 AND 100000


-- 2)	Hiển thị kinh phí trung bình của các công trình ở Can Tho 
SELECT AVG(KINHPHI)
FROM CONGTRINH
WHERE TINHTHANH LIKE '%CAN THO%'

-- 3)	Hiển thị thông tin các công trình có kinh phí cao hơn kinh phí trung bình của các công trình. 
SELECT *
FROM CONGTRINH
WHERE KINHPHI > (
	SELECT AVG(KINHPHI)
	FROM CONGTRINH
)

-- 4)	Hiển thị những chủ nhân quản lý từ 2 công trình trở lên. Thông tin hiển thị: TENCHU,PHAI,DIACHI, SLCONGTRINH. Sắp xếp giảm dần theo số công trình. 
SELECT TENCHU, PHAI, DiaChiChu, COUNT(*)
FROM CHUNHAN A
INNER JOIN CONGTRINH B ON A.MSCH = B.MSCH
GROUP BY TENCHU, PHAI, DIACHICHU
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC


-- 5)	Hiển thị chủ thầu tham gia nhiều công trình nhất. Thông tin hiển thị: TENTHAU, 
-- SLCONGTRINH 
use congtrinh1

SELECT TOP 1 WITH TIES TENTHAU, COUNT(*) AS SLCT
FROM chuthau A
INNER JOIN CONGTRINH B ON A.MSCT = B.MSCT
GROUP BY A.TENTHAU, A.MSCT
ORDER BY COUNT(*) DESC

-- 6)	Viết câu truy vấn hiển thị danh sách các kiến trúc sư thiết kế công trình Cau tinh yeu. Thông tin hiển thị: MSKTS, THULAO. Lưu kết quả truy vấn vào bảng DSKTS_CAUTINHYEU   
SELECT MSKTS, THULAO
INTO DSKTS_CAUTINHYEUA
FROM THIETKE A
INNER JOIN CONGTRINH B ON A.STTCT = B.STTCT
WHERE TenCT LIKE 'CAU TINH YEU'

-- 7)	Cập nhật kinh phí giảm 10% các công trình chưa có kiến trúc sư tham gia thiết kế
UPDATE CONGTRINH
SET KinhPhi *= 0.9
WHERE STTCT NOT IN (
	SELECT STTCT 
	FROM thietke
)

-- 8) Cho biết mã kiến trúc sư có thù lao trung bình nhỏ nhất. 
SELECT TOP 1 WITH TIES MSKTS
FROM thietke
GROUP BY MSKTS
ORDER BY AVG(THULAO) 


-- 9)	Cho biết tỉnh thành nào nhận nhiều kinh phí nhất. Thông tin hiển thị: 
-- TINHTHANH, TONGKINHPHI 
SELECT TOP 1 WITH TIES TINHTHANH, SUM(KINHPHI)
FROM CONGTRINH 
GROUP BY TINHTHANH 
ORDER BY SUM(KINHPHI) desc


--10)	Hiển thị TENCT có kinh phí nhiều hơn kinh phí trung bình ở Soc Trang. 
SELECT TENCT, KINHPHI
FROM CONGTRINH 
GROUP BY TENCT, KINHPHI
HAVING SUM(KINHPHI) > (
	SELECT AVG(KINHPHI)
	FROM CONGTRINH
)

