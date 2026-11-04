-- 
WITH A AS 
	(SELECT 
		DISTINCT CUST, 
		GRUPKA, 
		KA
	 FROM DtDWHBI.VW_BIP90Cust),
	 B AS
	(SELECT 
		Concat(left(D.cust,5),substring(D.cust,9,5)) as Kode_Site,
		A.KA,
		Divisi,
		Kategori,
		KELPITEM,
		THN,
		BLN,
		SUM(QTY_KRT) as QTY,
		ROW_NUMBER() OVER (PARTITION BY Kode_Site,A.KA,Divisi,Kategori,kelpitem ORDER BY QTY DESC) as Ranking
	FROM dtDWHBI.VW_BICMOP90Daily D
	INNER JOIN A
		on D.CUST = A.CUST
	WHERE D.Divisi in ('11-AB2','31-AB3') and thn = 2026
	GROUP BY 1,2,3,4,5,6,7)
--
SELECT 
	DISTINCT F.Site,
	F.cust_name,
	G.KA,
	DIVISI,
	KATEGORI,
	left(kelpitem,5) as Kode_SKU,
	substring(Kelpitem,7,99) as SKU,
	QTY,
	CASE 
		WHEN KATEGORI IN ('16-TOOTHBRUSH',
							'17-TOOTHPASTE',
							'18-MOUTHWASH',
							'19-RAZOR',
							'20-HAIR CARE',
							'21-SANITIZER',
							'22-HAND SOAP',
							'23-TOILET SOAP',
							'24-DISPOSABLE MASK',
							'25-WET WIPES',
							'30-FLOOR CLEANER') THEN SH_UPANONFOOD
		WHEN DIVISI = '31-AB3' THEN SH_AB3
		ELSE SH_UPAFOOD
	END as SH,
	fisik_total
FROM Dtcmobi.LL_P90 F
LEFT JOIN (SELECT * FROM B WHERE Ranking = 1) as G
	ON F.site = G.Kode_Site
ORDER BY 3,1,2 DESC
;



--kak dina
WITH A AS 
	(SELECT 
		DISTINCT CUST, 
		GRUPKA, 
		KA
	 FROM DtDWHBI.VW_BIP90Cust),
	 B AS
	(SELECT 
--		Concat(left(D.cust,5),substring(D.cust,9,5)) as Kode_Site,
		A.KA,
		Divisi,
		Kategori,
		KELPITEM,
		THN,
		BLN,
		SUM(QTY_KRT) as QTY,
		ROW_NUMBER() OVER (PARTITION BY A.KA,Divisi,Kategori,kelpitem ORDER BY QTY DESC) as Ranking
	FROM dtDWHBI.VW_BICMOP90Daily D
	INNER JOIN A
		on D.CUST = A.CUST
	WHERE D.Divisi in ('11-AB2','31-AB3') and thn = 2026
	GROUP BY 1,2,3,4,5,6)
--
SELECT 
	DISTINCT
--	F.Site,
--	F.cust_name,
	G.KA,
	DIVISI,
	KATEGORI,
	left(kelpitem,5) as Kode_SKU,
	substring(Kelpitem,7,99) as SKU,
	QTY,
	CASE 
		WHEN KATEGORI IN ('16-TOOTHBRUSH',
							'17-TOOTHPASTE',
							'18-MOUTHWASH',
							'19-RAZOR',
							'20-HAIR CARE',
							'21-SANITIZER',
							'22-HAND SOAP',
							'23-TOILET SOAP',
							'24-DISPOSABLE MASK',
							'25-WET WIPES',
							'30-FLOOR CLEANER') THEN SH_UPANONFOOD
		WHEN DIVISI = '31-AB3' THEN SH_AB3
		ELSE SH_UPAFOOD
	END as SH--,
--	fisik_total
FROM Dtcmobi.LL_P90 F
LEFT JOIN (SELECT * FROM B WHERE Ranking = 1) as G
	ON F.keyacc = LEFT(G.KA, 2)
ORDER BY 3,1,2 DESC
limit 50;

		
		
COPY DtCMOBI.OutletP90
FROM LOCAL 'D:\DWM Thesa\QUERY SQL\OutletP90.csv' 
DELIMITER ',' 
ENCLOSED BY '"' 
SKIP 1 
EXCEPTIONS 'D:\DWM Thesa\QUERY SQL\error_log.txt'
REJECTED DATA 'D:\DWM Thesa\QUERY SQL\rejected_data.csv'

SELECT * from DtCMOBI.OutletP90
		