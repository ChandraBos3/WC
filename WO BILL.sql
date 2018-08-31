use eip
GO

drop table #billlist

select d.sector_code,d.Sector_Description, a.HBILL_Job_Code, c.job_description, a.HBILL_WO_Number, a.HBILL_Bill_Number,b.DWMBL_PBS_Code,
cast(null as varchar(500)) Costpackage, cast(null as varchar(15)) workcategorycode,cast(null as varchar(500)) workCategory, 
b.DWMBL_Item_Code,
cast(null as varchar(500)) itemdesc,HWO_Currency_Code, cast( null as varchar(15))currencydesc,  b.DWMBL_Qty, b.DWMBL_Rate, b.DWMBL_Amount,b.DWMBL_Service_Tax_Componant_Total_Amount, b.dwmbl_vat_amount,
cast ( null as varchar(15) ) PlanningModule, job_status,job_active, cc_percentage, c.inserted_on, location, c.SBG_Code
into #billlist
from eip.sqlwom.wom_h_bills a , eip.sqlwom.wom_d_bills b, lnt.dbo.job_master c, lnt.dbo.sector_master d, eip.sqlwom.WOM_H_Work_Orders
WHERE
a.HBILL_Bill_Number = b.DWMBL_Bill_Number and HWO_WO_Number = a.HBILL_WO_Number
--and a.HBILL_Bill_Date>='01-Jan-2017' and hbill_bill_date <='31-Dec-2017' 
and a.HBILL_Job_Code= c.job_code
and c.Sector_Code = d.Sector_Code and c.company_code='LE' and c.company_code = d.Company_Code

AND HBILL_JOB_CODE = 'LE130413'
AND HWO_DS_CODE =3



Update a set Costpackage = MPBS_Description
from #billlist a, eip.sqlmas.GEN_M_Project_Breakdown_Structure
where a.hbill_job_Code = MPBS_Job_Code
and MPBS_PBS_Code= a.dwmbl_pbs_code
and MPBS_Company_Code=1

Update a set workcategorycode = MJITC_Item_Group_Code,itemdesc = left(MJITC_Item_Description,500)
from #billlist a, eip.sqlwom.wom_m_job_item_codes
where a.hbill_job_Code = MJITC_Job_Code
and MJITC_Item_Code= a.dwmbl_item_code
and MJITC_Company_Code=1


Update a set workCategory = b.MIGRP_Description
from #billlist a, EIP.SQLMAS.GEN_M_ITEM_GROUPS B
where workcategorycode= b.MIGRP_Item_Group_Code


Update a set currencydesc = left(b.MCUR_Short_Description,50)
from #billlist a, eip.sqlmas.GEN_M_Currencies b
where HWO_Currency_Code= b.MCUR_Currency_Code 



update a set PlanningModule = case when B.TCM_PMP_TAG='Y' then 'New Plan' else 'Old' End
from #billlist a,  epm.sqlepm.EPM_M_Control_Master B
where a.hbill_job_code = b.TCM_Job_Code



Update #billlist set itemdesc = replace(itemdesc , char(9),'-'), costpackage=replace(costpackage, char(9),'-')

Update #billlist set itemdesc = replace(itemdesc , char(10),'-'),costpackage=replace(costpackage, char(10),'-')

Update #billlist set itemdesc = replace(itemdesc , char(11),'-'),costpackage=replace(costpackage, char(11),'-')

Update #billlist set itemdesc = replace(itemdesc , char(12),'-'),costpackage=replace(costpackage, char(12),'-')

Update #billlist set itemdesc = replace(itemdesc , char(13),'-'),costpackage=replace(costpackage, char(13),'-')

Update #billlist set itemdesc = replace(itemdesc , char(14),'-'),costpackage=replace(costpackage, char(14),'-')

Update #billlist set itemdesc=replace (itemdesc , '''','f')
Update #billlist set itemdesc=replace (itemdesc , '"','i')

alter table #billlist add BUdesc varchar(100)
alter table #billlist add sbgdesc varchar (200)
alter table #billlist add Locdesc varchar(100)

uPDATE a SET  BUdesc= d.bu_description
FROM #billlist a, lnt.dbo.business_unit_master d, LNT.DBO.JOB_MASTER c
WHERE a.HBILL_Job_Code= c.job_code
AND c.BU_CODE = d.bu_code

UPDATE a SET sbgdesc = b.SBG_Description
from #billlist a, lnt.dbo.sbg_master b
WHERE a.sbg_code = b.sbg_code 


UPDATE a SET Locdesc  = b.region_description
from #billlist a, lnt.dbo.region_master b
WHERE a.location = b.region_code
and b. Company_Code='LE'

select * from #billlist 
