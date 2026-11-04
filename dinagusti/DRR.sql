SELECT MAX (tgl)
FROM DtCMOBI.OmsUmum
--FROM DtDWHBI.VW_BiCMOOmsTokoUmum
	
	
SELECT MAX (tgl)
FROM DtDWHBI.VW_BICMOP90Daily


SELECT DISTINCT intahun, chtipemarket, datglcutoff
FROM DtDWHBI.RPT_EAO_Monthly --DtDWHBI.RPT_EAO_Monthly  DtCMOBI.EAOMonthly
--WHERE chtipemarket = 2 AND intahun = 2026 AND chteam = 'Total' AND chtipelokasi = 'Nasional' AND chproduk = 'D'

SELECT distinct wil, tgl
from DtCMOBI.OmsUmum
WHERE wil LIKE '%JABAR SELATAN%' AND bln = 8 AND thn = 2026
order by tgl desc


SELECT DISTINCT chtipemarket, datglcutoff, intahun
FROM DtCMOBI.EAOMonthly -- DtDWHBI.RPT_EAO_Monthly
WHERE chteam = 'Total' --AND chketlokasi = 'TOTAL' AND chketproduk = '11-AB2'
--WHERE intahun = 2025 AND chteam = 'Total' AND chkdproduk = 'GGAP' AND chketlokasi ='TOTAL'



-------------- UPDATE OMSET UMUM --------------
DROP TABLE IF EXISTS DtCMOBI.OmsUmum CASCADE;
CREATE TABLE DtCMOBI.OmsUmum AS
	SELECT * FROM DtDWHBI.VW_BiCMOOmsTokoUmum




-------------- UPDATE MONTHLY --------------
DROP TABLE IF EXISTS DtCMOBI.EAOMonthly CASCADE;
CREATE TABLE DtCMOBI.EAOMonthly AS
	SELECT * FROM DtDWHBI.RPT_EAO_Monthly
	
	
	
	
------------------------ TES TANGGAL
	
bln = 10 AND tgl < '2026-10-02'

tgl = '2026-11-02'





-------------------------------------------------------- OMS ARTA KP KE BAWAH --------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, qtr AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chkatlevel1
			 END AS KP,
		SUM(qty_krt)/3 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, 'TOTAL' AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, ketbln AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
INNER JOIN DtCMOBI.Wafer_MapKetBln AS C
		ON A.bln = C.bln
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, qtr AS PERIODE, grupgab, SUM(qty_krt)/3 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, 'TOTAL' AS PERIODE, grupgab, SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, ketbln AS PERIODE, grupgab, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
INNER JOIN DtCMOBI.Wafer_MapKetBln AS D
		ON A.bln = D.bln
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- OMS ARTA , HK SAMA BULAN LALU -----------------------------------------
-------------------------------------------------------- GANTI TGL CUTOFF ------------------------------------------------
SELECT 'NAS' as market, thn, 'HK SAMA M-1' AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
		AND bln = 10 AND tgl < '2026-10-02'
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT 'NAS' as market, thn, 'HK SAMA M-1' AS PERIODE, grupgab, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
		AND bln = 10 AND tgl < '2026-10-02'
GROUP BY 1, 2, 3, 4
UNION
SELECT wil as market, thn, qtr AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt)/3 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT wil as market, thn, 'TOTAL' AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT wil as market, thn, ketbln AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
INNER JOIN DtCMOBI.Wafer_MapKetBln AS C
		ON A.bln = C.bln
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
SELECT wil as market, thn, qtr AS PERIODE, grupgab, SUM(qty_krt)/3 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT wil as market, thn, 'TOTAL' AS PERIODE, grupgab, SUM(qty_krt)/12 AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT wil as market, thn, ketbln AS PERIODE, grupgab, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
INNER JOIN DtCMOBI.Wafer_MapKetBln AS D
		ON A.bln = D.bln
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- OMS ARTA , HK SAMA BULAN LALU -----------------------------------------
-------------------------------------------------------- GANTI TGL CUTOFF ------------------------------------------------
SELECT wil AS market, thn, 'HK SAMA M-1' AS PERIODE, 
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN itemgb = '7451-TANGO EMOJI CHOCO POUCH 44.8G TAZOS' THEN 'EMOJI POUCH TAZOS'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH 2000'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU 2000'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F05-Brocris Cokelat' THEN 'BRONIS CH POUCH'
			 WHEN kelompok = 'G3-TANGO BROWNIES CRISPY POUCH' AND chKatLevel2 = 'F06-Brocris Susu' THEN 'BRONIS SU POUCH'
			 WHEN itemgb IN ('7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026', '7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR') THEN kelompok
 			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN kelompok
 			 WHEN grupgab = 'GGAW-WAFFLE TANGO' THEN 'SISA WAFFLE'
 			 WHEN grupgab = 'GGFM-TWL' THEN KelpItem
 			 WHEN grupgab = 'GGBI-IMPERIAL' THEN kelompok
 			 WHEN grupgab = 'GGAT-FULLO' THEN chkatlevel1
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' AND kelpitem LIKE '%POUCH%' THEN 'WAFER TANGO POUCH'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND Kelompok LIKE '%7000%' THEN 'WAFER TANGO 7000'
			 WHEN chkatlevel1 = 'W1-Wafer 2000UP' AND kelompok LIKE '%1000%' THEN 'WAFER TANGO 10000'
			 WHEN grupgab = 'GGAP-WAFER TANGO' THEN chKatLevel1
			 END AS KP,
		SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
		AND bln = 10 AND tgl < '2026-10-02'
GROUP BY 1, 2, 3, 4
UNION --------------------------------------------------------------------------------------------------------------------
SELECT wil as market, thn, 'HK SAMA M-1' AS PERIODE, grupgab, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL', 'GGAX-TCRPROLL', 'GGFZ-TGEMOJI')
		AND FlagFestive = 'Non Festive'
		AND itemgb NOT LIKE '%BROWNIES%'
		AND itemgb NOT LIKE '%WA.HH%'
		AND itemgb NOT IN ('1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026',
							'7382-TANGO BROWNIES CRISPY POUCH 100G (RP)', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
							'7557-TANGO BROWNIES CRISPY POUCH 100 GR 2027 (S) ',
							'7271-IMPERIAL CREME ASSORTED POUCH 144 GR 2026',
							'7273-TANGO EMOJI CHOCO POUCH 140 GR 2026', '7358-TANGO EMOJI CHOCO POUCH 140 GR 2026 (P)')
		AND grup NOT IN ('GR-WAFFLE TANGO PACKAGE', 'KA-WAFFLE TANGO 20000')
		AND bln = 10 AND tgl < '2026-10-02'
GROUP BY 1, 2, 3, 4





---------------------------------------- OVERVIEW BISCUT KPC ----------------------------------------
------------------------------------------------------------------------------------------------------ QTR
SELECT wil, thn, qtr AS periode,
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CIROLL'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' THEN 'BROWNIES'
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' THEN 'IMPERIAL 2000'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			 WHEN chKatLevel1 = 'W2-Wafer 2000' THEN 'WF 2000'
			 END AS KP,
		SUM(qty_krt)/3 AS KRT, SUM(rp)/3000000 AS JtRp
FROM DtCMOBI.OmsUmum
WHERE (kelompok IN ('G1-TANGO BROWNIES CRISPY 2000', 'L1-TANGO CRISPY ROLL 2000', 'K2-TANGO EMOJI 2000', 'E1-IMPERIAL CREME 2000')
	    OR
	  grup = 'GN-WAFFLE TANGO 2000'
	    OR
	  chKatLevel1 = 'W2-Wafer 2000')
GROUP BY 1, 2, 3, 4
------------------------------------------------------------------------------------------------------ bln
UNION
SELECT wil, thn, CAST (bln AS varchar) AS periode,
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' AND itemgb LIKE '%BTDT%' THEN 'CIROLL BTDT'			
			 WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CIROLL'
			 --
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' AND itemgb LIKE '%PRM%' THEN 'EMOJI PRM'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI'
			 --
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND itemgb LIKE '%BTDT%' THEN 'BROWNIES BTDT'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' THEN 'BROWNIES'
			 --
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' AND itemgb LIKE '%BTDT%' THEN 'WA.HH BTDT'
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			 --
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' AND itemgb LIKE '%@10%' THEN 'IMPE PRM'
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' THEN 'IMPERIAL 2000'
			 --
			 WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '%BTDT%' THEN 'WFL BTDT'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '% - 8B PRM%' THEN 'GOSOK'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			 --
			 WHEN chKatLevel1 = 'W2-Wafer 2000' AND itemgb LIKE '%BTDT%' THEN 'BTDT WFR2'
			 WHEN chKatLevel1 = 'W2-Wafer 2000'
			 		AND itemgb IN ('7300-WAFER TANGO MILKY CHOCO BITE 35 GR @12', '7298-WAFER TANGO VNL DELIGHT BITE 35 GR @12', '7297-WAFER TANGO ROYAL CHOCO BITE 35 GR @12',
									'7294-WAFER TANGO LONG CHEESE 37 GR @12', '7293-WAFER TANGO LONG SASSY SBJ 37 GR @12', '7292-WAFER TANGO LONG VNL DELIGHT 37 GR @12',
									'7291-WAFER TANGO LONG ROYAL CHOCO 37 GR @12', '7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026',
									'7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR')
					THEN 'WF2000 @12'
			 WHEN chKatLevel1 = 'W2-Wafer 2000' THEN 'WF 2000'
			 END AS KP,
		SUM(qty_krt) AS KRT, SUM(rp)/1000000 AS JtRp
FROM DtCMOBI.OmsUmum
WHERE (kelompok IN ('G1-TANGO BROWNIES CRISPY 2000', 'L1-TANGO CRISPY ROLL 2000', 'K2-TANGO EMOJI 2000', 'E1-IMPERIAL CREME 2000')
	    OR
	  grup = 'GN-WAFFLE TANGO 2000'
	    OR
	  chKatLevel1 = 'W2-Wafer 2000')
GROUP BY 1, 2, 3, 4
------------------------------------------------------------------------------------------------------ HK M-1
UNION
SELECT wil, thn, 'HK M-1' AS periode,
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' AND itemgb LIKE '%BTDT%' THEN 'CIROLL BTDT'			
			 WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CIROLL'
			 --
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' AND itemgb LIKE '%RM%' THEN 'EMOJI PRM'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI'
			 --
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND itemgb LIKE '%BTDT%' THEN 'BROWNIES BTDT'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' THEN 'BROWNIES'
			 --
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' AND itemgb LIKE '%BTDT%' THEN 'WA.HH BTDT'
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			 --
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' AND itemgb LIKE '%@10%' THEN 'IMPE PRM'
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' THEN 'IMPERIAL 2000'
			 --
			 WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '%BTDT%' THEN 'WFL BTDT'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '% - 8B PRM%' THEN 'GOSOK'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			 --
			 WHEN chKatLevel1 = 'W2-Wafer 2000' AND itemgb LIKE '%BTDT%' THEN 'BTDT WFR2'
			 WHEN chKatLevel1 = 'W2-Wafer 2000'
			 		AND itemgb IN ('7300-WAFER TANGO MILKY CHOCO BITE 35 GR @12', '7298-WAFER TANGO VNL DELIGHT BITE 35 GR @12', '7297-WAFER TANGO ROYAL CHOCO BITE 35 GR @12',
									'7294-WAFER TANGO LONG CHEESE 37 GR @12', '7293-WAFER TANGO LONG SASSY SBJ 37 GR @12', '7292-WAFER TANGO LONG VNL DELIGHT 37 GR @12',
									'7291-WAFER TANGO LONG ROYAL CHOCO 37 GR @12', '7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026',
									'7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR')
					THEN 'WF2000 @12'
			 WHEN chKatLevel1 = 'W2-Wafer 2000' THEN 'WF 2000'
			 END AS KP,
		SUM(qty_krt) AS KRT, SUM(rp)/1000000 AS JtRp
FROM DtCMOBI.OmsUmum
WHERE (kelompok IN ('G1-TANGO BROWNIES CRISPY 2000', 'L1-TANGO CRISPY ROLL 2000', 'K2-TANGO EMOJI 2000', 'E1-IMPERIAL CREME 2000')
	    OR
	  grup = 'GN-WAFFLE TANGO 2000'
	    OR
	  chKatLevel1 = 'W2-Wafer 2000')
	  AND thn = 2026 AND bln = 10 AND tgl < '2026-10-02'
GROUP BY 1, 2, 3, 4
------------------------------------------------------------------------------------------------------ H-1
UNION
SELECT wil, thn, 'H-1' AS periode,
		CASE WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' AND itemgb LIKE '%BTDT%' THEN 'CIROLL BTDT'			
			 WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CIROLL'
			 --
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' AND itemgb LIKE '%RM%' THEN 'EMOJI PRM'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI'
			 --
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' AND itemgb LIKE '%BTDT%' THEN 'BROWNIES BTDT'
			 WHEN kelompok = 'G1-TANGO BROWNIES CRISPY 2000' THEN 'BROWNIES'
			 --
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' AND itemgb LIKE '%BTDT%' THEN 'WA.HH BTDT'
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WA.HH'
			 --
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' AND itemgb LIKE '%@10%' THEN 'IMPE PRM'
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' THEN 'IMPERIAL 2000'
			 --
			 WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '%BTDT%' THEN 'WFL BTDT'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '% - 8B PRM%' THEN 'GOSOK'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			 --
			 WHEN chKatLevel1 = 'W2-Wafer 2000' AND itemgb LIKE '%BTDT%' THEN 'BTDT WFR2'
			 WHEN chKatLevel1 = 'W2-Wafer 2000'
			 		AND itemgb IN ('7300-WAFER TANGO MILKY CHOCO BITE 35 GR @12', '7298-WAFER TANGO VNL DELIGHT BITE 35 GR @12', '7297-WAFER TANGO ROYAL CHOCO BITE 35 GR @12',
									'7294-WAFER TANGO LONG CHEESE 37 GR @12', '7293-WAFER TANGO LONG SASSY SBJ 37 GR @12', '7292-WAFER TANGO LONG VNL DELIGHT 37 GR @12',
									'7291-WAFER TANGO LONG ROYAL CHOCO 37 GR @12', '7374-TANGO WAFFLE COOKIEZ & CREAM 63G-PD 2026', '7373-TANGO WAFFLE CHOCO HAZELNUT 63G-PD 2026',
									'7283-WAFFLE TANGO CHOCO HAZELNUT 70 GR')
					THEN 'WF2000 @12'
			 WHEN chKatLevel1 = 'W2-Wafer 2000' THEN 'WF 2000'
			 END AS KP,
		SUM(qty_krt) AS KRT, SUM(rp)/1000000 AS JtRp
FROM DtCMOBI.OmsUmum
WHERE (kelompok IN ('G1-TANGO BROWNIES CRISPY 2000', 'L1-TANGO CRISPY ROLL 2000', 'K2-TANGO EMOJI 2000', 'E1-IMPERIAL CREME 2000')
	    OR
	  grup = 'GN-WAFFLE TANGO 2000'
	    OR
	  chKatLevel1 = 'W2-Wafer 2000')
	   AND tgl = '2026-11-02'
GROUP BY 1, 2, 3, 4
	




	



----------- OMS UPA PKO -----------
SELECT 'UM' AS market,
		CONCAT(LEFT(klp, 2), SUBSTRING(klp, 4, 2)) AS kode, klp,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P35' THEN qty_krt ELSE 0 END) AS P1_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P36' THEN qty_krt ELSE 0 END) AS P2_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P37' THEN qty_krt ELSE 0 END) AS P3_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P38' THEN qty_krt ELSE 0 END) AS P4_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P39' THEN qty_krt ELSE 0 END) AS P5_9,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT itemgb, kelompok AS klp FROM DtDWHBI.VW_BICMOProduct) AS B
		ON A.ItemGB  = b.ItemGB
GROUP BY 1, 2, 3
UNION
SELECT 'UM' AS market,
		LEFT(grup, 2) AS kode, grup,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P35' THEN qty_krt ELSE 0 END) AS P1_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P36' THEN qty_krt ELSE 0 END) AS P2_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P37' THEN qty_krt ELSE 0 END) AS P3_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P38' THEN qty_krt ELSE 0 END) AS P4_9,
		SUM(CASE WHEN thn = 2025 AND KetPekan = 'P39' THEN qty_krt ELSE 0 END) AS P5_9,
		SUM(CASE WHEN thn = 2025 AND bln = 9 THEN qty_krt ELSE 0 END) AS KRT_9
FROM DtCMOBI.OmsUmum
GROUP BY 1, 2, 3
--
UNION
--
SELECT 'P90' AS market,
		CONCAT(LEFT(klp, 2), SUBSTRING(klp, 4, 2)) AS kode, klp,
		SUM(CASE WHEN ketpekan = 'P36' THEN qty_krt ELSE 0 END) AS P1_9,
		SUM(CASE WHEN ketpekan = 'P37' THEN qty_krt ELSE 0 END) AS P2_9,
		SUM(CASE WHEN ketpekan = 'P38' THEN qty_krt ELSE 0 END) AS P3_9,
		SUM(CASE WHEN ketpekan = 'P39' THEN qty_krt ELSE 0 END) AS P4_9,
		SUM(CASE WHEN ketpekan = 'P40' THEN qty_krt ELSE 0 END) AS P5_9,
		SUM(CASE WHEN bulan = 9 THEN qty_krt ELSE 0 END) AS SEP
FROM DtDWHBI.VW_BICMOP90Daily AS A
INNER JOIN (SELECT DISTINCT itemgb, Kelompok AS klp FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(a.ItemGB, 4) = LEFT(b.ItemGB , 4)
WHERE tahun = 2025 AND bulan = 9
GROUP BY 1, 2, 3
UNION
SELECT 'P90' AS market,
		LEFT(grup, 2) AS kode, grup,
		SUM(CASE WHEN ketpekan = 'P36' THEN qty_krt ELSE 0 END) AS P1_9,
		SUM(CASE WHEN ketpekan = 'P37' THEN qty_krt ELSE 0 END) AS P2_9,
		SUM(CASE WHEN ketpekan = 'P38' THEN qty_krt ELSE 0 END) AS P3_9,
		SUM(CASE WHEN ketpekan = 'P39' THEN qty_krt ELSE 0 END) AS P4_9,
		SUM(CASE WHEN ketpekan = 'P40' THEN qty_krt ELSE 0 END) AS P5_9,
		SUM(CASE WHEN bulan = 9 THEN qty_krt ELSE 0 END) AS SEP
FROM DtDWHBI.VW_BICMOP90Daily
WHERE tahun = 2025 AND bulan = 9
GROUP BY 1, 2, 3







-------------------------------------------- MONTORIING OMS HARIAN --------------------------------------------
WITH S AS (
------------------------------------------------------------------------------------------------------------------------------ 2024
--SELECT cust, wil, bln, 'TOTAL' AS Tim,
--		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
--			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
--			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
--			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
--			 END AS KP,
--		SUM(qty_krt)/12 AS KRT,
--		SUM(rp)/12000000 AS Jt
--FROM DtCMOBI.OmsUmum AS A
--INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
--		ON LEFT(A.itemgb,4) = B.chkditemgb
--WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
--		AND thn = 2024
--GROUP BY 1, 2, 3, 4, 5
--UNION
--SELECT cust, wil, bln, Kelpteam AS Tim,
--		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
--			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
--			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
--			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
--			 END AS KP,
--		SUM(qty_krt)/12 AS KRT,
--		SUM(rp)/12000000 AS Jt
--FROM DtCMOBI.OmsUmum AS A
--INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
--		ON LEFT(A.itemgb,4) = B.chkditemgb
--WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
--		AND thn = 2024
--GROUP BY 1, 2, 3, 4, 5
--UNION ---------------------------------------------------------------------------------------------------------------------
--SELECT cust, wil, bln, 'TOTAL' AS Tim, grupgab AS KP,
--		SUM(qty_krt)/12 AS KRT,
--		SUM(rp)/12000000 AS Jt
--FROM DtCMOBI.OmsUmum AS A
--INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
--		ON LEFT(A.itemgb,4) = B.chkditemgb
--WHERE grupgab = 'GGAP-WAFER TANGO'
--		AND thn = 2024
--GROUP BY 1, 2, 3, 4, 5
--UNION 
--SELECT cust, wil, bln, Kelpteam AS Tim, grupgab AS KP,
--		SUM(qty_krt)/12 AS KRT,
--		SUM(rp)/12000000 AS Jt
--FROM DtCMOBI.OmsUmum AS A
--INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
--		ON LEFT(A.itemgb,4) = B.chkditemgb
--WHERE grupgab = 'GGAP-WAFER TANGO'
--		AND thn = 2024
--GROUP BY 1, 2, 3, 4, 5
--UNION  ---------------------------------------------------------------------------------------------------------------------
--SELECT cust, wil, bln, 'TOTAL' AS Tim, 'BISCUIT' AS KP,
--		SUM(qty_krt)/12 AS KRT,
--		SUM(rp)/12000000 AS Jt
--FROM DtCMOBI.OmsUmum AS A
--INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
--		ON LEFT(A.itemgb,4) = B.chkditemgb
--WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
--		AND thn = 2024
--GROUP BY 1, 2, 3, 4, 5
--UNION
--SELECT cust, wil, bln, Kelpteam AS Tim, 'BISCUIT' AS KP,
--		SUM(qty_krt)/12 AS KRT,
--		SUM(rp)/12000000 AS Jt
--FROM DtCMOBI.OmsUmum AS A
--INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
--		ON LEFT(A.itemgb,4) = B.chkditemgb
--WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
--		AND thn = 2024
--GROUP BY 1, 2, 3, 4, 5
--
--
--
--
-------------------------------------------------------------------------------------------------------------------------------- PEKAN
SELECT cust, wil, CONCAT('P', PEAO)  AS Periode, 'TOTAL' AS Tim,
		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
			 END AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION 
SELECT cust, wil, CONCAT('P', PEAO)  AS Periode, Kelpteam AS Tim,
		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
			 END AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
SELECT cust, wil, CONCAT('P', PEAO)  AS Periode, 'TOTAL' AS Tim, grupgab AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAP-WAFER TANGO' AND itemgb NOT LIKE '%BROWNIES%'
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, CONCAT('P', PEAO)  AS Periode, Kelpteam AS Tim, grupgab AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAP-WAFER TANGO' AND itemgb NOT LIKE '%BROWNIES%'
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
SELECT cust, wil, CONCAT('P', PEAO)  AS Periode, 'TOTAL' AS Tim, 'BISCUIT' AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION 
SELECT cust, wil, CONCAT('P', PEAO)  AS Periode, Kelpteam AS Tim, 'BISCUIT' AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------ TANGAL
SELECT cust, wil, RIGHT(CAST(tgl AS VARCHAR), 2) AS Periode, 'TOTAL' AS Tim,
		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
			 END AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, RIGHT(CAST(tgl AS VARCHAR), 2) AS Periode, Kelpteam AS Tim,
		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
			 END AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
SELECT cust, wil, RIGHT(CAST(tgl AS VARCHAR), 2) AS Periode, 'TOTAL' AS Tim,  grupgab AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAP-WAFER TANGO' AND itemgb NOT LIKE '%BROWNIES%'
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, RIGHT(CAST(tgl AS VARCHAR), 2) AS Periode, Kelpteam AS Tim,  grupgab AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAP-WAFER TANGO' AND itemgb NOT LIKE '%BROWNIES%'
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
SELECT cust, wil, RIGHT(CAST(tgl AS VARCHAR), 2) AS Periode, 'TOTAL' AS Tim, 'BISCUIT' AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, RIGHT(CAST(tgl AS VARCHAR), 2) AS Periode, Kelpteam AS Tim, 'BISCUIT' AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln = 10
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------- BULAN
SELECT cust, wil, CONCAT('B', bln)  AS Periode, 'TOTAL' AS Tim,
		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
			 END AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln > 7
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, CONCAT('B', bln)  AS Periode, Kelpteam AS Tim,
		CASE WHEN itemgb = '7063-WAFFLE TANGO WA.HH JUST CHOCO 22.5 GR' THEN 'TANGO WAFFLE WA.HH CHOCO 2000'
			 WHEN grupgab IN ('GGAP-WAFER TANGO')  THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' AND chKatLevel2 = 'F04-Fullo Sticki' THEN 'FULLO STICKI'
			 WHEN grupgab IN ('GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGBI-IMPERIAL') THEN grupgab
			 END AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln > 7
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
SELECT cust, wil, CONCAT('B', bln)  AS Periode, Kelpteam AS Tim,  grupgab AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAP-WAFER TANGO' AND itemgb NOT LIKE '%BROWNIES%'
		AND thn = 2025 AND bln > 7
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, CONCAT('B', bln)  AS Periode, 'TOTAL' AS Tim,  grupgab AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAP-WAFER TANGO' AND itemgb NOT LIKE '%BROWNIES%'
		AND thn = 2025 AND bln > 7
GROUP BY 1, 2, 3, 4, 5
UNION ---------------------------------------------------------------------------------------------------------------------
SELECT cust, wil, CONCAT('B', bln)  AS Periode, Kelpteam AS Tim, 'BISCUIT' AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln > 7
GROUP BY 1, 2, 3, 4, 5
UNION
SELECT cust, wil, CONCAT('B', bln)  AS Periode, 'TOTAL' AS Tim, 'BISCUIT' AS KP,
		SUM(qty_krt) AS KRT,
		SUM(rp)/1000000 AS Jt
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp, chketkelpitem FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab IN ('GGAP-WAFER TANGO', 'GGAW-WAFFLE TANGO', 'GGFM-TWL', 'GGAT-FULLO', 'GGAR-KLOP SALUTO', 'GGBI-IMPERIAL')
		AND thn = 2025 AND bln > 7
GROUP BY 1, 2, 3, 4, 5
)
SELECT wil, Periode, KP, Tim,
		CASE WHEN cust LIKE ANY ('%SELISIH%', '%KONTAN%', '%LANGGANAN KANTOR%', '%Selisih%', '%Langganan Kantor%', '%Kontan%', '%TUNAI%', '%Tunai%') THEN 'Tidak Hitung LT'
			 WHEN KRT < 0 THEN 'Tidak Hitung LT'
			 ELSE 'Hitung LT'
			 END AS Ket,
		COUNT(DISTINCT cust) AS LT,
		SUM(KRT) AS Oms,
		SUM(Jt) AS Rp
FROM S
GROUP BY 1, 2, 3, 4, 5








WITH S AS (
SELECT cust, 
	CASE WHEN itemgb LIKE '%STICKI%' THEN 'Stick'
		 WHEN grupgab = 'GGBC-POP' THEN 'Lollipops'
		 WHEN kategori = '6-COOKIES REAL' THEN 'Cookies Sandwich'
		 WHEN kategori IN ('11-HARD CANDIES', '12-LOLYPOP') THEN 'Hard Candies'
		 WHEN kategori IN ('9-SOFT CANDIES', '54-GUMMY') THEN 'Soft Candies'
		 ELSE kategori END AS KP,
	thn, bln, SUM(qty_krt) AS KRT
FROM DtCMOBI.OmsUmum
WHERE WIL like '%SUMUT%'
	AND grupgab NOT LIKE '%FST%'
	AND grupgab NOT LIKE '%MSW%'
	AND grupgab NOT LIKE '%FESTIVE%'
	AND Supplier = 'UPA'
GROUP BY 1, 2, 3, 4
UNION
SELECT cust,
	CASE WHEN item LIKE '%STICKI%' THEN 'Stick'
		 WHEN grupgab = 'GGBC-POP' THEN 'Lollipops'
		 WHEN kategori = '6-COOKIES REAL' THEN 'Cookies Sandwich'
		 WHEN kategori IN ('11-HARD CANDIES', '12-LOLYPOP') THEN 'Hard Candies'
		 WHEN kategori IN ('9-SOFT CANDIES', '54-GUMMY') THEN 'Soft Candies'
		 ELSE kategori END AS KP,
	intahun, inbulan, SUM(deqtykrt) AS KRT
FROM DtDWHBI.VW_OmsTokoItemHis2017
WHERE chmarket = 'UMUM' AND wil LIKE '%SUMUT%' AND intahun = 2023
		AND grupgab NOT LIKE '%FST%'
		AND grupgab NOT LIKE '%MSW%'
		AND grupgab NOT LIKE '%FESTIVE%'
GROUP BY 1, 2, 3, 4
)
SELECT KP, thn, bln, COUNT(DISTINCT CASE WHEN KRT > 0 THEN cust ELSE NULL END) AS LT, SUM(KRT) AS Oms
FROM S
GROUP BY 1, 2, 3
