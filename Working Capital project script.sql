
use PMS
GO
select a.job_code, b.Performance_date, a.Sector_Code, a.bu_code,c.contract_start_date, c.expected_end_date,a.job_status,
b.CostCompPC, b.InvCompPC,b.Invoice_Cum InvCum, b.Amount_Certified_Cum CertInv,CURRENCY_CODE, b.Total_OS, b.Net_Cash_Retention, b.Other_Current_Assets, b.Stock_Valued, b.Stock_Consum, b.Stock_FG,
b.Stock_Raw_Materials, b.Cost_Over_Invoice SOI, b.Vendor_Credit, b.Plant_Advance- b.Plant_Advance_Recovery plntadv,
b.Matrl_Advance-b.Matrl_Advance_Recovery matrladv, b.Mobile_Advance-b.Mobile_Advance_Recovery mobadv,
b.Other_Current_Liabil , b.Sales_Cum,b.BGTotal
into #temp1
from lnt.dbo.job_master a, PMS.dbo.Job_Performance b, PMS.dbo.job_overview c
where a.job_Code = c.job_code and a.job_code= b.Job_code
and b.Revision_Tag=2 and b.Performance_date>='01-Apr-2012'
and a.company_code='LE'
and a.job_type=1 and a.main_sub_dept='M'
--and a.job_code in ('LE100548')
AND CURRENCY_CODE ='inr'



alter table #temp1 add ICdesc varchar(100)
alter table #temp1 add BUdesc varchar(100)
alter table #temp1 add Jobdesc varchar(200)

UPDATE a SET ICdesc = b.Sector_Description
from #temp1 a, lnt.dbo.Sector_Master b
WHERE a.sector_code = b.Sector_Code 
AND b.Company_Code='LE'


UPDATE a SET BUdesc = b.bu_description
from #temp1 a, lnt.dbo.business_unit_master b
WHERE a.bu_code = b.bu_code 
AND b.Company_Code='LE'

UPDATE a SET Jobdesc = b.job_description
from #temp1 a, LNT.dbo.job_master b
WHERE a.job_code = b.job_code 
AND b.Company_Code='LE'

select *from #temp1

