SELECT DISTINCT chtipemarket, datglcutoff FROM DtCMOBI.EAOMonthly

SELECT DISTINCT chtipemarket, datglcutoff FROM DtDWHBI.RPT_EAO_Monthly


---------------------------------- EAO MEETING KEUANGAN ----------------------------------
SELECT *
FROM DtCMOBI.EAOMonthly
WHERE chtipemarket = 2 AND chteam = 'Total' AND chketlokasi = 'TOTAL'
		AND chketproduk IN ('W3-Wafer 500', 'W4-Wafer 1000', 'W2-Wafer 2000',
							'W03-WFT 5000', 'W04-WFT 7000', 'W06-WFT 10000', 'W05-WFT POUCH', 'GGAP-WAFER TANGO',
							'GGBI-IMPERIAL', 'LEE1-KIMPCRM2000', 'LEE4-KIMPCRM8000', 'F8-IMPERIAL BLUEBERRY', 'RKK2-TANGO EMOJI 2000', 'RK-GTGEFST',
							'RG-GTGBC', 'RGG1-KTBC2000', 'RGG3-KTBCPCH', '7172-ICB27G', '7173-ICS27G', '7174-ICP27G', '6977-ICCSTW', '6976-ICCORG,', '6667-ICB162', '6729-IRB162', '6730-IPC162', 
							'GNN8-KWFLWHC2000', 'GN-GWFLCR2000', 'GGAW-WAFFLE TANGO',
							'GGFM-TWL', '1-WAFER FLAT')	
ORDER BY chketproduk ASC






---------------------------------- EAO MEETING KEU PER WILAYAH----------------------------------
SELECT *
FROM DtCMOBI.EAOMonthly
WHERE chtipemarket = 2 AND chteam = 'Total' AND chtipelokasi = 'Wilayah'
		AND chkdproduk IN ('W04', 'W2', 'W4', 'LEE1', 'W03', 'W05', 'RK', 'RGG1')	
ORDER BY chketproduk ASC
		




---------------------------------- OMSET PER KP NASIONAL ----------------------------------
------------------------------------------ BULAN ------------------------------------------
WITH S AS (
SELECT CASE WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			WHEN itemgb LIKE '%BROWNIES%' THEN kelompok
			WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			WHEN grupgab = 'GGFM-TWL' THEN grupgab
			ELSE chketsubkp
			END AS KP,
	   cust, wil, thn,
	   CAST(bln AS VARCHAR) AS Periode,
	   SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGFZ-TANGO EMOJI FESTIVE')
		AND FlagFestive = 'Non Festive'
GROUP BY 1, 2, 3, 4, 5
--------------------------------------------------------------------------------------------------------------------
UNION ------------------------------------------ TAHUN ------------------------------------------
--------------------------------------------------------------------------------------------------------------------
SELECT CASE WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			WHEN itemgb LIKE '%BROWNIES%' THEN kelompok
			WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			WHEN grupgab = 'GGFM-TWL' THEN grupgab
			ELSE chketsubkp
			END AS KP,
	   cust, wil, thn,
	   CAST(thn AS VARCHAR) AS Periode, 
	   SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGFZ-TANGO EMOJI FESTIVE')
		AND FlagFestive = 'Non Festive'
GROUP BY 1, 2, 3, 4, 5
--------------------------------------------------------------------------------------------------------------------
UNION ------------------------------------------ BULAN ------------------------------------------
--------------------------------------------------------------------------------------------------------------------
SELECT CASE WHEN grupgab = 'GGBI-IMPERIAL' THEN chketkelpitem
			WHEN itemgb LIKE '%BROWNIES%' THEN 'BROWNIES'
			ELSE grupgab
			END AS KP,
	   cust, wil, thn, 
	   CAST(bln AS VARCHAR) AS Periode,
	   SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
		AND FlagFestive = 'Non Festive'
GROUP BY 1, 2, 3, 4, 5
--------------------------------------------------------------------------------------------------------------------
UNION ------------------------------------------ TAHUN ------------------------------------------
--------------------------------------------------------------------------------------------------------------------
SELECT CASE WHEN grupgab = 'GGBI-IMPERIAL' THEN chketkelpitem
			WHEN itemgb LIKE '%BROWNIES%' THEN 'BROWNIES'
			ELSE grupgab
			END AS KP,
	   cust, wil, thn, CAST(thn AS VARCHAR) AS Periode, 
	   SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL')
		AND FlagFestive = 'Non Festive'
GROUP BY 1, 2, 3, 4, 5
)
SELECT thn, Periode, KP, COUNT(DISTINCT CASE WHEN KRT > 0 THEN cust ELSE NULL END) AS LT,
		SUM(KRT) AS OMS
FROM S
WHERE thn > 2024
GROUP BY 1, 2, 3






---------------- OMSET PER KP WILAYAH ----------------
WITH S AS (
SELECT CASE WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%SLW%' THEN 'SEALWARE'
			WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%BAN%' THEN 'REFILL'
			WHEN chkatlevel1 = 'W3-Wafer 500' THEN 'BOX'
			WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			WHEN grupgab = 'GGFM-TWL' THEN grupgab
			WHEN grup = 'RG-TANGO BROWNIES CRISPY' THEN kelompok
			WHEN grupgab = 'GGFZ-TANGO EMOJI FESTIVE' THEN kelompok
			ELSE chketsubkp
			END AS KP,
	   cust, wil, thn,  CAST(bln AS VARCHAR) AS Periode, 
	   SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGFZ-TANGO EMOJI FESTIVE')
GROUP BY 1, 2, 3, 4, 5
--------------------------------------------------------------------------------------------------------------------
UNION
--------------------------------------------------------------------------------------------------------------------
SELECT CASE WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%SLW%' THEN 'SEALWARE'
			WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%BAN%' THEN 'REFILL'
			WHEN chkatlevel1 = 'W3-Wafer 500' THEN 'BOX'
			WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			WHEN grupgab = 'GGFM-TWL' THEN grupgab
			WHEN grup = 'RG-TANGO BROWNIES CRISPY' THEN kelompok
			WHEN grupgab = 'GGFZ-TANGO EMOJI FESTIVE' THEN kelompok
			ELSE chketsubkp
			END AS KP,
	   cust, wil, thn, CAST(thn AS VARCHAR) AS Periode, 
	   SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGFZ-TANGO EMOJI FESTIVE')
GROUP BY 1, 2, 3, 4, 5
--------------------------------------------------------------------------------------------------------------------
UNION
--------------------------------------------------------------------------------------------------------------------
SELECT CASE WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%SLW%' THEN 'SEALWARE'
			WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%BAN%' THEN 'REFILL'
			WHEN chkatlevel1 = 'W3-Wafer 500' THEN 'BOX'
			WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			WHEN grupgab = 'GGFM-TWL' THEN grupgab
			WHEN grup = 'RG-TANGO BROWNIES CRISPY' THEN kelompok
			WHEN grupgab = 'GGFZ-TANGO EMOJI FESTIVE' THEN kelompok
			ELSE chketsubkp
			END AS KP,
	   cust, wil, thn, qtr AS Periode, 
	   SUM(qty_krt)/3 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb, 4) = B.chkditemgb
		AND grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGFZ-TANGO EMOJI FESTIVE')
GROUP BY 1, 2, 3, 4, 5
)
SELECT wil, thn, Periode, KP,
		COUNT(DISTINCT CASE WHEN KRT > 0 THEN cust ELSE NULL END) AS LT,
		SUM(KRT) AS OMS
FROM S
WHERE thn > 2024
GROUP BY 1, 2, 3, 4






----------------- OMSET PER KP (FILE TARGET) -----------------
SELECT chketkelpitem, 
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS KRT_10,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS KRT_11,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS KRT_12,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS KRT_1_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS KRT_2_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS KRT_3_26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS KRT_4_26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS KRT_5_26
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT itemgb AS itemgbb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON A.itemgb = B.itemgbb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGAT-FULLO')
GROUP BY 1
--
UNION
--
SELECT chketsubkp, 
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS KRT_10,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS KRT_11,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS KRT_12,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS KRT_1_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS KRT_2_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS KRT_3_26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS KRT_4_26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS KRT_5_26
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT itemgb AS itemgbb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON A.itemgb = B.itemgbb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGAT-FULLO')
GROUP BY 1
--
UNION
--
SELECT grup, 
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS KRT_10,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS KRT_11,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS KRT_12,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS KRT_1_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS KRT_2_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS KRT_3_26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS KRT_4_26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS KRT_5_26
FROM DtCMOBI.OmsUmum
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGAT-FULLO')
GROUP BY 1
--
UNION
--
SELECT grupgab, 
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS KRT_10,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS KRT_11,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS KRT_12,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS KRT_1_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS KRT_2_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS KRT_3_26,
		SUM(CASE WHEN thn = 2026 AND bln = 4 THEN qty_krt ELSE 0 END) AS KRT_4_26,
		SUM(CASE WHEN thn = 2026 AND bln = 5 THEN qty_krt ELSE 0 END) AS KRT_5_26
FROM DtCMOBI.OmsUmum
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGBI-IMPERIAL', 'GGAT-FULLO')
GROUP BY 1






WITH S AS (
SELECT cust, wil, thn, bln, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum
WHERE itemgb LIKE '%WA.HH%'
GROUP BY 1, 2, 3, 4
UNION
SELECT cust, wil, 2025 AS thn, 2025 AS bln, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum
WHERE itemgb LIKE '%WA.HH%'
GROUP BY 1, 2, 3, 4)
SELECT thn, bln, wil, COUNT(DISTINCT CASE WHEN KRT > 0 THEN cust END) AS LT, SUM(KRT) AS Oms
FROM S
GROUP BY 1, 2, 3



---------------------------- HITUNG REPEAT ORDER ----------------------------
SELECT No_Urut, Wilayah_Singkat, depo, LEFT(cust, 13) AS kode_cust, SUBSTRING(cust, 15, 999) AS Customer,
		SUM(CASE WHEN thn = 2025 AND bln = 6 THEN qty_krt ELSE 0 END) AS KRT_6,
		SUM(CASE WHEN thn = 2025 AND bln = 7 THEN qty_krt ELSE 0 END) AS KRT_7,
		SUM(CASE WHEN thn = 2025 AND thn = 2025 AND bln = 8 THEN qty_krt ELSE 0 END) AS KRT_8,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9,
		SUM(CASE WHEN thn = 2025 AND bln = 10 THEN qty_krt ELSE 0 END) AS KRT_10,
		SUM(CASE WHEN thn = 2025 AND bln = 11 THEN qty_krt ELSE 0 END) AS KRT_11,
		SUM(CASE WHEN thn = 2025 AND bln = 12 THEN qty_krt ELSE 0 END) AS KRT_12,
		SUM(CASE WHEN thn = 2026 AND bln = 1 THEN qty_krt ELSE 0 END) AS KRT_1_26,
		SUM(CASE WHEN thn = 2026 AND bln = 2 THEN qty_krt ELSE 0 END) AS KRT_2_26,
		SUM(CASE WHEN thn = 2026 AND bln = 3 THEN qty_krt ELSE 0 END) AS KRT_3_26,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 6 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_6,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 7 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_7,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 8 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_8,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 9 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_9,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 10 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_10,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 11 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_11,
		COUNT(DISTINCT CASE WHEN thn = 2025 AND bln = 12 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_12,
		COUNT(DISTINCT CASE WHEN thn = 2026 AND bln = 1 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_1_26,
		COUNT(DISTINCT CASE WHEN thn = 2026 AND bln = 2 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_2_26,
		COUNT(DISTINCT CASE WHEN thn = 2026 AND bln = 3 AND qty_krt >0 THEN tgl ELSE NULL END) AS RO_3_26
FROM DtCMOBI.OmsUmum AS A
INNER JOIN DtCMOBI.Ketentuan_UrutanWilEAO AS B
		ON SUBSTRING(A.wil, 4, 99) = B.Wilayah 
WHERE kelompok = 'G1-TANGO BROWNIES CRISPY 2000'
GROUP BY 1, 2, 3, 4, 5
--HAVING KRT_6 > 100 OR KRT_7 > 100  OR KRT_8 > 100  OR KRT_9 > 100  OR KRT_10 > 100 
ORDER BY 1, 4
