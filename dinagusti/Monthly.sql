	
--------------------- PROYEKSI NIELSEN UMUM ---------------------
WITH S AS (
			SELECT wil_nielsen, thn, cust, bln, 'Tango Wafer Flat' AS KP, SUM(qty_krt) AS KRT
			FROM DtCMOBI.OmsUmum AS A
			INNER JOIN DtCMOBI.Wafer_MapWilArtaNielsen AS B
					ON A.wil = B.wil_arta
			WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO')
			GROUP BY 1, 2, 3, 4, 5
			--
			UNION
			--
			SELECT wil_nielsen, thn, cust, bln,
					CASE WHEN grupgab = 'GGAP-WAFER TANGO' THEN 'Tango Wafer'
						 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'Tango Waffle'
						 WHEN grupgab = 'GGFM-TWL' THEN 'Tango Walut'
						 WHEN grupgab = 'GGBI-IMPERIAL' THEN 'Imperial'
						 END AS KP,
					SUM(qty_krt) AS KRT
			FROM DtCMOBI.OmsUmum AS A
			INNER JOIN DtCMOBI.Wafer_MapWilArtaNielsen AS B
					ON A.wil = B.wil_arta
			WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
			GROUP BY 1, 2, 3, 4, 5
			--
			UNION
			--
			SELECT wil_nielsen, thn, cust, bln,
					CASE WHEN chKatLevel1 = 'W3-Wafer 500' THEN 'Tango Wafer 500'
						 WHEN chKatLevel1 = 'W4-Wafer 1000' THEN 'Tango Wafer 1000'
						 WHEN chKatLevel1 = 'W2-Wafer 2000' OR grup = 'GN-WAFFLE TANGO 2000' THEN 'Tango Wafer 2000'
						 WHEN chKatLevel1 = 'W1-Wafer 2000UP' OR grup = 'GP-WAFFLE TANGO 7000' THEN 'Tango Wafer 2000Up'
						 END AS KP,
					SUM(qty_krt) AS KRT
			FROM DtCMOBI.OmsUmum AS A
			INNER JOIN DtCMOBI.Wafer_MapWilArtaNielsen AS B
					ON A.wil = B.wil_arta
			WHERE (grupgab = 'GGAP-WAFER TANGO' OR grup IN ('GN-WAFFLE TANGO 2000', 'GP-WAFFLE TANGO 7000'))
			GROUP BY 1, 2, 3, 4, 5
			--
			UNION
			--
			SELECT wil_nielsen, thn, cust, bln, 'Tango Wafer 7000' AS KP,
					SUM(qty_krt) AS KRT
			FROM DtCMOBI.OmsUmum AS A
			INNER JOIN DtCMOBI.Wafer_MapWilArtaNielsen AS B
					ON A.wil = B.wil_arta
			INNER JOIN (SELECT DISTINCT itemgb, chketsubkp FROM DtDWHBI.VW_BICMOProduct) AS C
					ON A.ItemGB = C.itemgb
			WHERE chketsubkp IN ('WAFER TANGO 7000', 'WAFFLE TANGO 7000')
			GROUP BY 1, 2, 3, 4, 5
			)
SELECT wil_nielsen, thn, bln, KP,
		COUNT(DISTINCT CASE WHEN KRT > 0 THEN cust ELSE NULL END) AS LT,
		SUM(KRT) AS Oms
FROM S
GROUP BY 1, 2, 3, 4





---------------------------------------------------- OMS UNTUK KPI ----------------------------------------------------
SELECT grupgab, thn, bln, 'UMUM' AS market,
		CASE WHEN wil IN ('81-SULSEL', '82-PAPUA & MALUKU', '83-SULUT & SULTENG') THEN 'SUL'
			 WHEN wil IN ('43-NUSRA', '71-KALTIM & KALSEL', '73-KALBAR & KALTENG') THEN 'KAL'
			 WHEN wil = '41-BALI' THEN 'BLI'
			 ELSE wil END AS wilayah,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
		AND wil IN ('81-SULSEL', '82-PAPUA & MALUKU', '83-SULUT & SULTENG', '43-NUSRA', '71-KALTIM & KALSEL', '73-KALBAR & KALTENG', '41-BALI')
GROUP BY 1, 2, 3, 4, 5
UNION  --------------------------------------------------------------------------------------------------------------------------------------
SELECT grupgab, thn, bln, 'UMUM' AS market, 'OTHER ISLANDS' AS wilayah,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
		AND wil IN ('81-SULSEL', '82-PAPUA & MALUKU', '83-SULUT & SULTENG',
					'43-NUSRA', '71-KALTIM & KALSEL', '73-KALBAR & KALTENG',
					'41-BALI')
GROUP BY 1, 2, 3, 4, 5
UNION  -------------------------------------------------------------------------------------------------------------------------------------- P90
SELECT grupgab, tahun, bulan, 'PASAR90' AS market,
		CASE WHEN wil IN ('85-SULTRA & SULBAR PSR''90', '86-SULSEL PSR''90', '87-PAPUA & MALUKU PSR''90', '88-SULUT & SULTENG PSR''90') THEN 'SUL'
			 WHEN wil IN ('47-NUSRA PSR''90', '76-KALTIM & KALSEL PSR''90', '77-KALBAR & KALTENG PSR''90') THEN 'KAL'
			 WHEN wil = '46-BALI PSR''90' THEN 'BLI'
			 ELSE wil END AS wilayah,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtDWHBI.VW_BICMOP90Daily
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
		AND wil IN ('85-SULTRA & SULBAR PSR''90', '86-SULSEL PSR''90', '87-PAPUA & MALUKU PSR''90', '88-SULUT & SULTENG PSR''90',
					'47-NUSRA PSR''90', '76-KALTIM & KALSEL PSR''90', '77-KALBAR & KALTENG PSR''90',
					'46-BALI PSR''90')
GROUP BY 1, 2, 3, 4, 5
UNION  --------------------------------------------------------------------------------------------------------------------------------------
SELECT grupgab, tahun, bulan, 'PASAR90' AS market, 'OTHER ISLANDS' AS wilayah,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtDWHBI.VW_BICMOP90Daily
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
		AND wil IN ('85-SULTRA & SULBAR PSR''90', '86-SULSEL PSR''90', '87-PAPUA & MALUKU PSR''90', '88-SULUT & SULTENG PSR''90',
					'47-NUSRA PSR''90', '76-KALTIM & KALSEL PSR''90', '77-KALBAR & KALTENG PSR''90',
					'46-BALI PSR''90')
GROUP BY 1, 2, 3, 4, 5





------------------------- OMSET ANALISA NIELSEN BROWNIES CRISPY 
SELECT CASE WHEN wil_nielsen LIKE '%SUM%' THEN 'SUM U' ELSE wil_nielsen END AS wil,
		SUM(CASE WHEN thn = 2025 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul_25,
		SUM(CASE WHEN thn = 2025 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep_25,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS Okt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS Nov_25,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS Des_25,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS Jan_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS Feb_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS Mar26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS Apr26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS Mei26,
		SUM(CASE WHEN thn = 2026 AND bln = 6 THEN qty_krt ELSE 0 END) AS Jun26,
		SUM(CASE WHEN thn = 2026 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul26,
		SUM(CASE WHEN thn = 2026 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt26,
		SUM(CASE WHEN thn = 2026 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep26
FROM DtCMOBI.OmsUmum AS A
INNER JOIN DtCMOBI.Wafer_MapWilArtaNielsen AS B
		ON A.wil = B.wil_arta
WHERE grup = 'RG-TANGO BROWNIES CRISPY'
GROUP BY 1
UNION
SELECT CASE WHEN wil_nielsen LIKE '%SUM%' THEN 'SUM P' ELSE wil_nielsen END AS wil,
		SUM(CASE WHEN thn = 2025 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul_25,
		SUM(CASE WHEN thn = 2025 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep_25,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS Okt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS Nov_25,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS Des_25,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS Jan_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS Feb_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS Mar26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS Apr26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS Mei26,
		SUM(CASE WHEN thn = 2026 AND bln = 6 THEN qty_krt ELSE 0 END) AS Jun26,
		SUM(CASE WHEN thn = 2026 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul26,
		SUM(CASE WHEN thn = 2026 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt26,
		SUM(CASE WHEN thn = 2026 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep26
FROM DtDWHBI.VW_BICMOP90Daily AS A
INNER JOIN DtCMOBI.Wafer_MapWilArtaNielsen AS B
		ON A.wil = B.wil_arta
WHERE grup = 'RG-TANGO BROWNIES CRISPY'
GROUP BY 1
UNION
SELECT CASE WHEN grupka = 'KAC-KEY ACCOUNT' THEN 'NAS MTKA'
			WHEN grupka = 'IPT-INDEPENDENT' THEN 'NAS MTI'
			END AS KAi11,
		SUM(CASE WHEN thn = 2025 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul_25,
		SUM(CASE WHEN thn = 2025 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep_25,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS Okt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS Nov_25,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS Des_25,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS Jan_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS Feb_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS Mar26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS Apr26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS Mei26,
		SUM(CASE WHEN thn = 2026 AND bln = 6 THEN qty_krt ELSE 0 END) AS Jun26,
		SUM(CASE WHEN thn = 2026 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul26,
		SUM(CASE WHEN thn = 2026 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt26,
		SUM(CASE WHEN thn = 2026 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep26
FROM DtDWHBI.VW_BICMOP90Daily AS A
LEFT JOIN (SELECT DISTINCT cust AS Toko, grupKA FROM DtDWHBI.VW_BIP90Cust) AS B
		ON A.cust = B.toko
WHERE grup = 'RG-TANGO BROWNIES CRISPY'
GROUP BY 1
UNION
SELECT CASE WHEN Kelpteam IN ('12-TEAM HPM', '4-TEAM SPM') THEN 'NAS HPM'
			WHEN Kelpteam = '11-TEAM MM' THEN 'NAS MM'
			END AS tim,
		SUM(CASE WHEN thn = 2025 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul_25,
		SUM(CASE WHEN thn = 2025 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep_25,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS Okt_25,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS Nov_25,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS Des_25,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS Jan_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS Feb_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS Mar26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS Apr26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS Mei26,
		SUM(CASE WHEN thn = 2026 AND bln = 6 THEN qty_krt ELSE 0 END) AS Jun26,
		SUM(CASE WHEN thn = 2026 AND bln = 7 THEN qty_krt ELSE 0 END) AS Jul26,
		SUM(CASE WHEN thn = 2026 AND bln = 8 THEN qty_krt ELSE 0 END) AS Agt26,
		SUM(CASE WHEN thn = 2026 AND bln = 9 THEN qty_krt ELSE 0 END) AS Sep26
FROM DtDWHBI.VW_BICMOP90Daily AS A
LEFT JOIN (SELECT DISTINCT cust AS Toko, grupKA FROM DtDWHBI.VW_BIP90Cust) AS B
		ON A.cust = B.toko
WHERE grup = 'RG-TANGO BROWNIES CRISPY'
GROUP BY 1





SELECT *
FROM DtCMOBI.EAOMonthly
WHERE chkdproduk = 'W2' AND chketlokasi = 'TOTAL' AND chteam = 'Total' AND chtipemarket = 2




------------------------- BOD BOC
SELECT 'UM' AS market, thn, bln, SUM(rp)/1000000 AS rp
FROM DtCMOBI.OmsUmum
WHERE (chKatLevel1 = 'W2-Wafer 2000' OR Grup = 'GN-WAFFLE TANGO 2000')
--		AND thn = 2025 AND bln = 1
GROUP BY 1, 2, 3
UNION
SELECT 'P90' AS market, thn, bln, SUM(rp)/1000000 AS rp
FROM DtDWHBI.VW_BICMOP90Daily
WHERE (chKatLevel1 = 'W2-Wafer 2000' OR Grup = 'GN-WAFFLE TANGO 2000')
--		AND thn = 2025 AND bln = 1
GROUP BY 1, 2, 3





SELECT 'Segmen 2000' AS KP,
		SUM(CASE WHEN thn = 2025 AND bln IN (1, 2, 3) THEN qty_krt ELSE 0 END)/3 AS Q1_25,
	SUM(CASE WHEN thn = 2025 AND bln IN (4, 5, 6) THEN qty_krt ELSE 0 END)/3 AS Q2_25,
	SUM(CASE WHEN thn = 2025 AND bln IN (7, 8, 9) THEN qty_krt ELSE 0 END)/3 AS Q3_25,
	SUM(CASE WHEN thn = 2025 AND bln IN (10, 11, 12) THEN qty_krt ELSE 0 END)/3 AS Q4_25,
	SUM(CASE WHEN thn = 2026 AND bln IN (1, 2, 3) THEN qty_krt ELSE 0 END)/3 AS Q1_26,
	SUM(CASE WHEN thn = 2026 AND bln IN (4, 5, 6) THEN qty_krt ELSE 0 END)/3 AS Q2_26,
	SUM(CASE WHEN thn = 2026 AND bln IN (7, 8, 9) THEN qty_krt ELSE 0 END)/3 AS Q3_26,
	SUM(CASE WHEN thn = 2026 AND bln IN (10, 11, 12) THEN qty_krt ELSE 0 END)/3 AS Q4_26
FROM DtCMOBI.OmsUmum
WHERE (chkatlevel1 = 'W2-Wafer 2000' OR grup = 'GN-WAFFLE TANGO 2000') AND kelompok != 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000'
GROUP BY 1






SELECT kelompok,
		SUM(CASE WHEN BLN = 1 then qty_krt ELSE 0 END) AS Jan,
		SUM(CASE WHEN BLN = 2 then qty_krt ELSE 0 END) AS Feb,
		SUM(CASE WHEN BLN = 3 then qty_krt ELSE 0 END) AS Mar,
		SUM(CASE WHEN BLN = 4 then qty_krt ELSE 0 END) AS Apr,
		SUM(CASE WHEN BLN = 5 then qty_krt ELSE 0 END) AS Mei,
		SUM(CASE WHEN BLN = 6 then qty_krt ELSE 0 END) AS Jun,
		SUM(CASE WHEN BLN = 7 then qty_krt ELSE 0 END) AS Jul,
		SUM(CASE WHEN BLN = 8 then qty_krt ELSE 0 END) AS Agt,
		SUM(CASE WHEN BLN = 9 then qty_krt ELSE 0 END) AS Sep,
		SUM(CASE WHEN BLN = 10 then qty_krt ELSE 0 END) AS Okt,
		SUM(CASE WHEN BLN = 11 then qty_krt ELSE 0 END) AS Nov,
		SUM(CASE WHEN BLN = 12 then qty_krt ELSE 0 END) AS Des
FROM DTCMOBI.OMSUMUM
WHERE chkatlevel1 = 'W2-Wafer 2000' AND thn = 2026
GROUP BY 1



