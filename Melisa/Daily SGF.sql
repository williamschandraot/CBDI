--Part 1

SELECT WIL,
	WILGAB,	
    CASE
        WHEN GRUP = 'OP-SG FORMULA ON1' THEN 'EKONOMI'
        WHEN GRUP = 'OQ-SG FORMULA PREMIUM' THEN 'PREMIUM'
        WHEN GRUP = 'OO-SG FORMULA  SUPER PREMIUM' THEN 'SUPER PREMIUM'
        WHEN GRUP = 'OA-SG FORMULA JUNIOR' THEN 'JUNIOR'
        ELSE GRUP
       END AS KP,
       SUM(CASE WHEN thn = 2024 THEN qty_krt ELSE 0 END)/12 AS RT_24,       
       SUM(CASE WHEN bln IN (1,2,3) AND thn = 2025 THEN qty_krt ELSE 0 END)/3 AS TW125,
       SUM(CASE WHEN bln IN (4,5,6) AND thn = 2025 THEN qty_krt ELSE 0 END)/3 AS TW225,   
       SUM(CASE WHEN bln IN (7,8,9) AND thn = 2025 THEN qty_krt ELSE 0 END)/3 AS TW325,
       SUM(CASE WHEN bln IN (10,11,12) AND thn = 2025 THEN qty_krt ELSE 0 END)/3 AS TW425,
       SUM(CASE WHEN bln = 9 AND thn = 2026 THEN qty_krt ELSE 0 END) AS Sept_26,
       SUM(CASE WHEN bln = 10 AND thn = 2026 THEN qty_krt ELSE 0 END) AS Okt_26,       
       SUM(CASE WHEN bln = 10 AND thn = 2026 AND KetPekan = 'P39' THEN qty_krt ELSE 0 END) AS Okt_26_P1,
       SUM(CASE WHEN bln = 10 AND thn = 2026 AND KetPekan = 'P40' THEN qty_krt ELSE 0 END) AS Okt_26_P2,
       SUM(CASE WHEN bln = 10 AND thn = 2026 AND KetPekan = 'P41' THEN qty_krt ELSE 0 END) AS Okt_26_P3,
       SUM(CASE WHEN bln = 10 AND thn = 2026 AND KetPekan = 'P42' THEN qty_krt ELSE 0 END) AS Okt_26_P4,
       SUM(CASE WHEN bln = 10 AND thn = 2026 AND KetPekan = 'P43' THEN qty_krt ELSE 0 END) AS Okt_26_P5,
       SUM(CASE WHEN bln = 10 AND thn = 2026 AND KetPekan = 'P44' THEN qty_krt ELSE 0 END) AS Okt_26_P6
FROM DtCMOBI.OmsUmum
WHERE GRUPGAB IN ('GGCD-SGF')
GROUP BY 1, 2, 3

--Part2

SELECT Wil,
    CASE
        WHEN GRUP = 'OP-SG FORMULA ON1' THEN 'EKONOMI'
        WHEN GRUP = 'OQ-SG FORMULA PREMIUM' THEN 'PREMIUM'
        WHEN GRUP = 'OO-SG FORMULA  SUPER PREMIUM' THEN 'SUPER PREMIUM'
        WHEN GRUP = 'OA-SG FORMULA JUNIOR' THEN 'JUNIOR'
        ELSE GRUP
       END AS KP,
	bln ,
	tgl ,
sum(qty_krt) AS Krt
FROM DtCMOBI.OmsUmum
WHERE grupgab = 'GGCD-SGF'AND thn = 2026 AND bln = 10
GROUP by 1,2,3,4;


select distinct KetPekan bln, thn
from DtCMOBI.OmsUmum
WHERE THN = '2026' AND BLN = '10'


