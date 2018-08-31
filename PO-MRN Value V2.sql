--PO

--drop table #link
select dpo_material_code,DPO_Net_Rate,DPO_Basic_Rate,mmatc_description,MMGRP_Description,MMAT_UOM_Code,UUOM_Description,job_code,(DPO_Qty - DPO_Cancelled_Qty) Volume,DPO_PO_Number, hpo_po_date, ((DPO_Qty - DPO_Cancelled_Qty)*DPO_Net_Rate) Value,MMAT_Material_Description, location, HPO_Currency_Code,HPO_Last_Amendment_Number
,HPO_BA_Code, vendor_description, p.sector_code, p.bu_code , p.SBG_Code, HPO_Warehouse_Code,HPO_DS_Code,a.HPO_PO_Basic_Value, HPO_PO_Net_Value
 into #link
 from eip.sqlscm.SCM_H_Purchase_Orders a, eip.sqlscm.scm_d_purchase_orders, lnt.dbo.job_master p,
  eip.sqlmas.GEN_M_Material_Groups c, eip.sqlmas.GEN_M_Materials , eip.sqlmas.GEN_M_Material_Classes ,eip.sqlmas.GEN_U_Unit_Of_Measurement , lnt.dbo.vendor_master j
where hpo_po_number = dpo_po_number 

and HPO_Last_Amendment_number=DPO_Amendment_Number
and mmat_material_code = DPO_Material_Code and mmat_mg_Code = c.MMGRP_MG_Code 
and MMGRP_Company_Code= mmat_company_code 
and MMATC_Class_Code = c.MMGRP_Class_Code 
and MMGRP_Company_Code=MMATC_Company_Code
and MMAT_Company_Code =1
and HPO_BA_CODE= j.vendor_code

and HPO_Company_Code=1 
and HPO_Job_Code= p.job_code 
and j.company_code = 'LE'
and p.company_code='LE'
--and HPO_JOB_CODE in ('LE130413')
and MMAT_UOM_Code = UUOM_UOM_Code
and hpo_po_date between '01-Apr-2017' and '31-Mar-2018'
and MMAT_Company_Code= MMATC_Company_Code 
and HPO_DS_Code ='3'
and sector_code = 'B'

Update #link set MMATC_Description= replace(MMATC_Description,char(9),'-'),mmgrp_description=replace(mmgrp_description,char(9),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(9),'-')


Update #link set MMATC_Description= replace(MMATC_Description,char(10),'-'),mmgrp_description=replace(mmgrp_description,char(10),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(10),'-')

						
Update #link set MMATC_Description= replace(MMATC_Description,char(11),'-'),mmgrp_description=replace(mmgrp_description,char(11),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(11),'-')

Update #link set MMATC_Description= replace(MMATC_Description,char(12),'-'),mmgrp_description=replace(mmgrp_description,char(12),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(12),'-')
						
Update #link set MMATC_Description= replace(MMATC_Description,char(13),'-'),mmgrp_description=replace(mmgrp_description,char(13),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(13),'-')
						
Update #link set MMATC_Description= replace(MMATC_Description,char(14),'-'),mmgrp_description=replace(mmgrp_description,char(14),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(14),'-')

Update #link set MMATC_Description= replace(MMATC_Description,char(15),'-'),mmgrp_description=replace(mmgrp_description,char(15),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(15),'-')

Update #link set MMATC_Description= replace(MMATC_Description,'"','-'),mmgrp_description=replace(mmgrp_description,'"','-'),MMAT_Material_Description=replace(MMAT_Material_Description,'"','-')


alter table #link add ICdesc varchar(100)
alter table #link add BUdesc varchar(100)
alter table #link add Jobdesc varchar(200)
alter table #link add Locdesc varchar(200)
alter table #link add sbgdesc varchar (200)


UPDATE a SET ICdesc = b.Sector_Description
from #link a, lnt.dbo.Sector_Master b
WHERE a.sector_code = b.Sector_Code 
AND b.Company_Code='LE'


UPDATE a SET BUdesc = b.bu_description
from #link a, lnt.dbo.business_unit_master b
WHERE a.bu_code = b.bu_code 
AND b.Company_Code='LE'

UPDATE a SET Jobdesc = b.job_description
from #link a, LNT.dbo.job_master b
WHERE a.job_code = b.job_code 
AND b.Company_Code='LE'

UPDATE a SET Locdesc  = b.region_description
from #link a, lnt.dbo.region_master b
WHERE a.location = b.region_code
and b. Company_Code='LE'

UPDATE a SET sbgdesc = b.SBG_Description
from #link a, lnt.dbo.sbg_master b
WHERE a.sbg_code = b.sbg_code 


select *from #link








---MRN

drop table #link


select HMRN_MRN_DATE, HMRN_JOB_CODE,job_description, n.Sector_Code,n.bu_code,HPO_PO_Date, HMRN_PO_NUMBER,HMRN_WAREHOUSE_CODE,HMRN_BA_CODE,j.vendor_description,
Sector_Description, bu_description, DMRN_MRN_Number, DMRN_MATERIAL_CODE, DMRN_ACCEPTED_QTY,DMRN_Basic_Rate, DMRN_Net_Rate,DMRN_Value, MMAT_MG_Code,MMGRP_Description,MMAT_UOM_Code,UUOM_Description,
MMAT_Material_Description,mmatc_description, HMRN_Currency_Code,MMAT_Material_Code
into #link
from eip.sqlscm.SCM_D_MRN a, eip.sqlscm.SCM_H_MRN b, eip.sqlmas.GEN_M_Materials, eip.sqlmas.GEN_M_Material_Groups,eip.sqlmas.GEN_U_Unit_Of_Measurement, 
lnt.dbo.vendor_master j,lnt.dbo.job_master n,eip.sqlmas.GEN_M_Material_Classes, lnt.dbo.business_unit_master p, lnt.dbo.Sector_Master q, eip.sqlscm.SCM_H_Purchase_Orders,  eip.sqlscm.SCM_D_Purchase_Orders



WHERE hmrn_mrn_number = DMRN_MRN_Number 
and HPO_PO_Number = hmrn_po_number 
and HPO_PO_NUMBER = DPO_PO_NUMBER
AND DPO_Material_Code = DMRN_Material_Code
and MMAT_Material_Code= DMRN_Material_Code
and MMAT_Company_Code=1 
and MMAT_MG_Code= MMGRP_MG_Code and MMGRP_Company_Code=MMAT_Company_Code
and MMAT_UOM_Code = UUOM_UOM_Code
and Hmrn_BA_CODE= j.vendor_code
and j.company_code = 'LE'
and Hmrn_Job_Code =job_code
and HPO_Job_Code = hmrn_job_code
and MMATC_Class_Code = MMGRP_Class_Code
and MMGRP_Class_Code = MMATC_Class_Code and MMGRP_Company_Code=MMATC_Company_Code

and MMAT_Company_Code= MMATC_Company_Code 

and MMAT_Company_Code= MMATC_Company_Code
e
---and HMRN_MRN_DATE between '01-Jan-2017' AND '31-Dec-2017'
and HMRN_Company_code  ='1'
and n.bu_code = p.bu_code 
AND p.Company_Code='LE'
and HPO_Company_Code=1
and n.sector_code = q.Sector_Code 
AND q.Company_Code='LE'
and hpo_ds_code =3
and HMRN_JOB_CODE ='LE130413' 

update #link set MMATC_Description= replace(replace(replace(replace(replace(replace(replace(replace(replace(MMATC_Description,char(9),'-'),char(10),'-'),
                                  char(11),'-'),char(12),'-'),char(13),'-'),char(14),'-'),char(15),'-'),'''','-'),'"','-')
update #link set mmgrp_description= replace(replace(replace(replace(replace(replace(replace(replace(replace(mmgrp_description,char(9),'-'),char(10),'-'),
                                  char(11),'-'),char(12),'-'),char(13),'-'),char(14),'-'),char(15),'-'),'''','-'),'"','-')
update #link set MMAT_Material_Description= replace(replace(replace(replace(replace(replace(replace(replace(replace(MMAT_Material_Description,char(9),'-'),char(10),'-'),
                                  char(11),'-'),char(12),'-'),char(13),'-'),char(14),'-'),char(15),'-'),'''','-'),'"','-')


select *from #link


