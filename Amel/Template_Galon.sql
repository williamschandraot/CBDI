/*
 * Umum - DtCMOBI.OmsUmum
 * P90 - DtDWHBI.VW_BICMOP90Daily
 */

-- Omset Daily
select tgl, wil, depo, grupgab, kelompok, cust, sum(qty_sda) as qty
from DtDWHBI.VW_BICMOP90Daily
where kelompok = 'L2-CRYSTALIN GALON 15 L'
and thn in (2026)
group by 1,2,3,4,5,6
order by 1,2,3,4,5,6
;

-- Omset Monthly
select wil, depo, grupgab, kelompok, cust, -- propinsi, kabkodya, kecamatan, kelurahan,
sum(case when thn = 2026 and bln = 4 then qty_sda end) as Apr26,
sum(case when thn = 2026 and bln = 5 then qty_sda end) as Mei26,
sum(case when thn = 2026 and bln = 6 then qty_sda end) as Jun26,
sum(case when thn = 2026 and bln = 7 then qty_sda end) as Jul26,
sum(case when thn = 2026 and bln = 8 then qty_sda end) as Agt26,
sum(case when thn = 2026 and bln = 9 then qty_sda end) as Sep26,
sum(case when thn = 2026 and bln = 10 then qty_sda end) as Okt26,
sum(case when thn = 2026 and bln = 11 then qty_sda end) as Nov26
from DtDWHBI.VW_BICMOP90Daily
where kelompok = 'L2-CRYSTALIN GALON 15 L'
group by 1,2,3,4,5 --,6,7,8,9
order by 1,2,3,4,5 --,6,7,8,9
;