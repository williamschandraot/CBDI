---------------------------------------------- DICT ITEM ----------------------------------------------
SELECT DISTINCT chkditemgb, chketproduk, chketproduk2, chkdkelpitem, chketkelpitem, CONCAT(CONCAT(chkdkelpitem, '-'), chketkelpitem) AS KP, chketsubkp
FROM DtCMOBI.EAOMonthly AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chkdkelpitem, chketkelpitem, chketsubkp FROM DtDWHBI.VW_BICMOProduct) AS B
		ON B.chkditemgb = A.chkdproduk
--WHERE chkditemgb = '43'
ORDER BY 4, 1 ASC
		

---------------------------------------------- DICT KP ----------------------------------------------
SELECT DISTINCT chketproduk, chketproduk2, chproduk
FROM DtCMOBI.EAOMonthly
WHERE chproduk != 'I'
--WHERE chproduk NOT IN ('I', 'Q', 'T', 'V', 'D') 
ORDER BY 1



SELECT DISTINCT itemgb, kelompok, grup, grupgab, chketsubkp, chketkelpitem, ketgrupkhusus
FROM DtDWHBI.VW_BICMOProduct
--WHERE supplier = 'UPA' AND DIVISI = '11-AB2'
WHERE itemgb LIKE '%EMOJI%'
--WHERE grup LIKE '%QB-%'
--ORDER BY 1



SELECT *
FROM (
	SELECT 
	    chkdproduk,
	    chketproduk2,
	    chtipemarket,
	    'BLANK' AS chtipelokasi,
	    chketlokasi,
	    ---------------------------------------------------------------------------------EC
		MAX(CASE WHEN intahun = 2025 THEN deEC_M1 END) AS '2025_EC_1',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M2 END) AS '2025_EC_2',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M3 END) AS '2025_EC_3',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M4 END) AS '2025_EC_4',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M5 END) AS '2025_EC_5',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M6 END) AS '2025_EC_6',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M7 END) AS '2025_EC_7',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M8 END) AS '2025_EC_8',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M9 END) AS '2025_EC_9',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M10 END) AS '2025_EC_10',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M11 END) AS '2025_EC_11',
		MAX(CASE WHEN intahun = 2025 THEN deEC_M12 END) AS '2025_EC_12',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M1 END) AS '2026_EC_1',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M2 END) AS '2026_EC_2',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M3 END) AS '2026_EC_3',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M4 END) AS '2026_EC_4',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M5 END) AS '2026_EC_5',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M6 END) AS '2026_EC_6',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M7 END) AS '2026_EC_7',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M8 END) AS '2026_EC_8',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M9 END) AS '2026_EC_9',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M10 END) AS '2026_EC_10',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M11 END) AS '2026_EC_11',
		MAX(CASE WHEN intahun = 2026 THEN deEC_M12 END) AS '2026_EC_12',
		---------------------------------------------------------------------------------AT
		MAX(CASE WHEN intahun = 2025 THEN inAT_M1 END) AS '2025_AT_1',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M2 END) AS '2025_AT_2',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M3 END) AS '2025_AT_3',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M4 END) AS '2025_AT_4',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M5 END) AS '2025_AT_5',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M6 END) AS '2025_AT_6',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M7 END) AS '2025_AT_7',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M8 END) AS '2025_AT_8',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M9 END) AS '2025_AT_9',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M10 END) AS '2025_AT_10',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M11 END) AS '2025_AT_11',
		MAX(CASE WHEN intahun = 2025 THEN inAT_M12 END) AS '2025_AT_12',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M1 END) AS '2026_AT_1',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M2 END) AS '2026_AT_2',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M3 END) AS '2026_AT_3',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M4 END) AS '2026_AT_4',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M5 END) AS '2026_AT_5',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M6 END) AS '2026_AT_6',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M7 END) AS '2026_AT_7',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M8 END) AS '2026_AT_8',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M9 END) AS '2026_AT_9',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M10 END) AS '2026_AT_10',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M11 END) AS '2026_AT_11',
		MAX(CASE WHEN intahun = 2026 THEN inAT_M12 END) AS '2026_AT_12',
		---------------------------------------------------------------------------------QTY
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M1 END) AS '2025_QTY_1',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M2 END) AS '2025_QTY_2',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M3 END) AS '2025_QTY_3',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M4 END) AS '2025_QTY_4',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M5 END) AS '2025_QTY_5',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M6 END) AS '2025_QTY_6',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M7 END) AS '2025_QTY_7',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M8 END) AS '2025_QTY_8',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M9 END) AS '2025_QTY_9',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M10 END) AS '2025_QTY_10',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M11 END) AS '2025_QTY_11',
		SUM(CASE WHEN intahun = 2025 THEN deQTY_M12 END) AS '2025_QTY_12',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M1 END) AS '2026_QTY_1',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M2 END) AS '2026_QTY_2',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M3 END) AS '2026_QTY_3',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M4 END) AS '2026_QTY_4',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M5 END) AS '2026_QTY_5',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M6 END) AS '2026_QTY_6',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M7 END) AS '2026_QTY_7',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M8 END) AS '2026_QTY_8',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M9 END) AS '2026_QTY_9',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M10 END) AS '2026_QTY_10',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M11 END) AS '2026_QTY_11',
		SUM(CASE WHEN intahun = 2026 THEN deQTY_M12 END) AS '2026_QTY_12',
		---------------------------------------------------------------------------------Rp
		SUM(CASE WHEN intahun = 2025 THEN deRP_M1 END) AS '2025_RP_1',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M2 END) AS '2025_RP_2',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M3 END) AS '2025_RP_3',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M4 END) AS '2025_RP_4',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M5 END) AS '2025_RP_5',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M6 END) AS '2025_RP_6',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M7 END) AS '2025_RP_7',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M8 END) AS '2025_RP_8',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M9 END) AS '2025_RP_9',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M10 END) AS '2025_RP_10',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M11 END) AS '2025_RP_11',
		SUM(CASE WHEN intahun = 2025 THEN deRP_M12 END) AS '2025_RP_12',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M1 END) AS '2026_RP_1',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M2 END) AS '2026_RP_2',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M3 END) AS '2026_RP_3',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M4 END) AS '2026_RP_4',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M5 END) AS '2026_RP_5',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M6 END) AS '2026_RP_6',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M7 END) AS '2026_RP_7',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M8 END) AS '2026_RP_8',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M9 END) AS '2026_RP_9',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M10 END) AS '2026_RP_10',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M11 END) AS '2026_RP_11',
		SUM(CASE WHEN intahun = 2026 THEN deRP_M12 END) AS '2026_RP_12'
	FROM DtCMOBI.EAOMonthly AS a
	WHERE chteam = 'Total' 
	    AND chtipelokasi IN ('Nasional', 'Area', 'WilGab', 'Wilayah')
	    AND (chketproduk2 NOT LIKE '%STATION RASA%' AND chketproduk2 NOT LIKE '%KAYA KING%' 
	        AND chketproduk2 NOT LIKE '%ALLEO%' AND chketproduk2 NOT LIKE '%MIO%' 
	        AND chketproduk2 NOT LIKE '%XPRIMO%' AND chketproduk2 NOT LIKE '%OOPS WAFER%'
	        AND chketproduk2 NOT LIKE '%CAPILANO%' AND chketproduk2 NOT LIKE '%MAMA BENE%'
	        AND chketproduk2 NOT LIKE '%OOPS KUNYAH%' AND chketproduk2 NOT LIKE '%OLEZZO%'
	        AND chketproduk2 NOT LIKE '%KAYAKING%')
	    AND LENGTH(chkdproduk) > 1
	    AND chtipemarket = 2 ----------------------------------------------------------------------- 1=P90, 2=Umum
	GROUP BY 1, 2, 3, 4, 5
) AS s
ORDER BY  1, 2, 3, 4, 5






SELECT chkdproduk, chketproduk2, chtipemarket, 
FROM DtCMOBI.EAOMonthly
WHERE chteam = 'Total' AND chtipemarket = 1
		AND chtipelokasi IN ('Nasional', 'Area', 'WilGab', 'Wilayah')



		






---------------------------------------------- CEK ITEM BARU ----------------------------------------------
SELECT DISTINCT itemgb, kelompok, grup, ketgrupkhusus, chketkelpitem, chketsubkp, grupgab, divisi
FROM DtDWHBI.VW_BICMOProduct
--WHERE KELOMPOK LIKE '%LE-E6%'
--ORDER BY 1 ASC



SELECT DISTINCT chkditemgb, itemgb, kelompok, grup, ketgrupkhusus, chketkelpitem, chkdsubkp, chketsubkp, grupgab
FROM DtDWHBI.VW_BICMOProduct
WHERE itemgb LIKE '43-%'
ORDER BY 3, 1 ASC


