
------------------ CEK CEK ------------------
SELECT depo, cust, chketsubkp,
		ROUND(SUM(CASE WHEN thn = 2026 AND bln = 9 then qty_krt ELSE 0 END), 2) AS Krt,
		ROUND(SUM(CASE WHEN thn = 2026 AND bln = 9 then rp ELSE 0 END), 0) AS Rp,
		ROUND(COALESCE(SUM(CASE WHEN thn = 2026 AND bln = 9 then rp ELSE 0 END)/SUM(CASE WHEN thn = 2026 AND bln = 9 then qty_krt ELSE 0 END), 0), 0) AS Harnett
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT itemgb itemgbb, chketsubkp FROM DtDWHBI.VW_BICMOProduct) AS B
  		ON LEFT(A.itemgb, 4) = LEFT(B.itemgbb, 4)
WHERE chketsubkp = 'WAFER TANGO 2000' --AND wil LIKE ANY ('%-JATENG%', '%-JATIM%', '%BALI%')
--		AND cust LIKE ANY ('%6100SM33-%', '%51134356%')
GROUP BY 1, 2, 3
HAVING KRT > 0
--HAVING KRT > 7 AND KRT < 10
ORDER BY 6 ASC








---------------- STRATA BIAYA PROMOSI ----------------
WITH S AS (
SELECT wil, cust, thn, bln AS periode,
		CASE WHEN grup = 'GN-WAFFLE TANGO 2000' AND itemgb LIKE '%8B PRM%' THEN 'WAFFLE 8B'
			 WHEN kelompok = 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000' THEN 'WAHH'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 6B'
			 WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%SLW%' THEN 'SEALWARE'
			 WHEN chkatlevel1 = 'W3-Wafer 500' AND itemgb LIKE '%BAN%' THEN 'REFILL'
			 WHEN chkatlevel1 = 'W3-Wafer 500' THEN 'BOX'
			 WHEN chkatlevel1 = 'W2-Wafer 2000' AND itemgb LIKE ANY ('%(F)%', '%(G)%') THEN 'WF 2000 KHUSUS'
			 WHEN chkatlevel1 = 'W2-Wafer 2000' AND CAST(LEFT(itemgb, 4) AS INT) > 7290 THEN 'WF XTRA BARANG'
			 WHEN chkatlevel1 = 'W2-Wafer 2000' THEN 'WF 2000'
			 WHEN chketsubkp = 'WAFER TANGO 7000' AND itemgb LIKE ANY ('%(D)%', '%(J)%') THEN 'WF 7000 KHUSUS'
			 WHEN chketsubkp = 'WAFER TANGO 7000' THEN 'WF 7000'
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' AND itemgb LIKE ANY('%27 GR @11%', '%8X10X%') THEN 'IMPE 8B'
			 WHEN kelompok = 'E1-IMPERIAL CREME 2000' THEN 'IMPE 6B'
			 WHEN itemgb IN ('7272-TANGO BROWNIES CRISPY POUCH 100 GR 2026', '7357-TANGO BROWNIES CRISPY POUCH 100 GR 2026 (P)',
			 				 '1534-(P)-TANGO BROWNIES CRISPY POUCH 100G 2026', '7382-TANGO BROWNIES CRISPY POUCH 100G (RP)') THEN 'BROWNIES FESTIVE'
			 WHEN grup = 'RG-TANGO BROWNIES CRISPY' THEN kelompok
			 WHEN chketsubkp IN ('WAFER TANGO POUCH', 'WAFER TANGO 10000', 'WAFER TANGO 1000') THEN chketsubkp
			 WHEN grupgab = 'GGAT-FULLO' THEN chketsubkp
			 WHEN grupgab = 'GGFM-TWL' THEN 'WALUT'
			 WHEN kelompok = 'E4-IMPERIAL CREME 8000' THEN 'IMPE 8000'
			 WHEN kelompok = 'K2-TANGO EMOJI 2000' THEN 'EMOJI 2000'
			 WHEN kelompok = 'L1-TANGO CRISPY ROLL 2000' THEN 'CROLL 2000'
			 ELSE NULL
		END AS Ket,
SUM(qty_krt) AS KRT,
SUM(RP) AS Rp
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT itemgb itemgbb, chketsubkp FROM DtDWHBI.VW_BICMOProduct) AS B
  		ON LEFT(A.itemgb, 4) = LEFT(B.itemgbb, 4)
WHERE (grup = 'GN-WAFFLE TANGO 2000'
		 OR chkatlevel1 IN ('W3-Wafer 500', 'W2-Wafer 2000')
		 OR kelompok IN ('E1-IMPERIAL CREME 2000', 'E4-IMPERIAL CREME 8000', 'L1-TANGO CRISPY ROLL 2000', 'K2-TANGO EMOJI 2000')
		 OR chketsubkp IN ('WAFER TANGO 7000', 'WAFER TANGO POUCH', 'WAFER TANGO 10000', 'WAFER TANGO 1000')
		 OR grup = 'RG-TANGO BROWNIES CRISPY'
		 OR grupgab IN ('GGAT-FULLO', 'GGFM-TWL')
		 )
		 AND itemgb NOT LIKE '%8B'
		 AND flagfestive = 'Non Festive'
GROUP BY 1, 2, 3, 4, 5
----------------------------------------------
----------------------------------------------
UNION
----------------------------------------------
----------------------------------------------
SELECT wil, cust, thn, bln AS periode,
		CASE WHEN chketsubkp = 'WAFER TANGO 2000' THEN 'WF 2000 TTL'
			 WHEN chketsubkp = 'WAFER TANGO 7000' THEN 'WF 7000 TTL'
			 WHEN grup = 'GN-WAFFLE TANGO 2000' THEN 'WAFFLE 2000'
			 END AS Ket,
	  SUM(qty_krt) AS KRT,
	  SUM(RP) AS Rp
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE (chketsubkp IN ('WAFER TANGO 7000', 'WAFER TANGO 2000')
		OR
	   grup = 'GN-WAFFLE TANGO 2000')
	  AND kelompok != 'N8-WAFFLE TANGO WA.HH CHOCOLATE 2000'
GROUP BY 1, 2, 3, 4, 5
----------------------------------------------
----------------------------------------------
UNION
----------------------------------------------
----------------------------------------------
SELECT wil, cust, thn, bln AS periode, 'WAFFLE 6B' AS Ket,
	  SUM(qty_krt)*6/8 AS KRT,
	  SUM(RP) AS Rp
FROM DtCMOBI.OmsUmum AS A
INNER JOIN (SELECT DISTINCT chkditemgb, chketsubkp FROM DtDWHBI.VW_BICMOProduct) AS B
		ON LEFT(A.itemgb,4) = B.chkditemgb
WHERE grupgab = 'GGAW-WAFFLE TANGO' AND itemgb LIKE '%8B'
GROUP BY 1, 2, 3, 4, 5
)
--
--
SELECT wil, thn, periode, Ket,
		CASE WHEN KRT >= 7000 THEN 7000
			 WHEN KRT >= 6000 THEN 6000
			 WHEN KRT >= 5000 THEN 5000
			 WHEN KRT >= 4000 THEN 4000
			 WHEN KRT >= 3000 THEN 3000
			 WHEN KRT >= 2000 THEN 2000
			 WHEN KRT >= 1000 THEN 1000
			 WHEN KRT >= 700 THEN 700
			 WHEN KRT >= 600 THEN 600
			 WHEN KRT >= 500 THEN 500
			 WHEN KRT >= 400 THEN 400
			 WHEN KRT >= 300 THEN 300
			 WHEN KRT >= 200 THEN 200
			 WHEN KRT >= 100 THEN 100
			 WHEN KRT >= 70 THEN 70
			 WHEN KRT >= 50 THEN 50
			 WHEN KRT >= 30 THEN 30
			 WHEN KRT >= 10 THEN 10
			 WHEN KRT >= 7 THEN 7
			 WHEN KRT >= 5 THEN 5
			 WHEN KRT >= 3 THEN 3
			 WHEN KRT >= 1 THEN 1
			 WHEN KRT >= 0.51 THEN 0.51
			 WHEN KRT >= 0.26 THEN 0.26
			 WHEN KRT >= 0.01 THEN 0.01
			 WHEN KRT >0 THEN 999
			 WHEN KRT <= 0 THEN 99
			 END AS Strata,
		COUNT(DISTINCT cust) AS LT,
		SUM(KRT) AS Qty,
		SUM(Rp) AS Rp
FROM S
WHERE thn > 2024
GROUP BY 1, 2, 3, 4, 5




