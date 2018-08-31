drop table #temp
use EIP 
GO
Select HISS_Date, DISS_Debit_Job_Code,Job_description,Sector_Description,q.bu_description, DISS_Material_Code,MMAT_Material_Description, MMGRP_Description,  HISS_Currency_Code, DISS_Rate, DISS_Value, DISS_Qty, DISS_Indent_Number,DISS_Issue_Number,
MTD_Trans_Type_Desc, MCUR_Description, c.sector_code, c.bu_code,HISS_Warehouse_Code
into #temp
from EIP.SQLSCM.SCM_D_Issue, EIP.SQLSCM.SCM_H_Issue, eip.sqlmas.GEN_M_Transaction_Details, eip.sqlmas.GEN_M_Currencies, lnt.dbo.job_master c,lnt.dbo.Sector_Master d,lnt.dbo.business_unit_master q
,eip.sqlmas.GEN_M_Material_Groups , eip.sqlmas.GEN_M_Materials, eip.sqlmas.GEN_M_Material_Classes 
Where HISS_Issue_Number = DISS_Issue_Number
and HISS_ISSUE_TYPE_CODE = MTD_Trans_Type_Code AND HISS_Issue_Detail_Code = MTD_Trans_Detail_Code
and HISS_Currency_Code =MCUR_Currency_Code and c.company_Code = 'LE'

and HISS_Job_Code = Job_Code
and c.sector_code= d.Sector_Code 
and c.bu_code = q.bu_code 
AND q.Company_Code='LE'
--and HISS_Date between '01-Dec-2017' and '31-Dec-2017'
and c.company_code='LE'
and HISS_Company_Code =1
AND hiss_job_code = 'LE130413' 
AND MTD_TRANS_TYPE_DESC NOT LIKE '%AMORTIZATION%'



and mmat_material_code = DISS_Material_Code and mmat_mg_Code = MMGRP_MG_Code and MMGRP_Company_Code= mmat_company_code and MMATC_Class_Code = MMGRP_Class_Code
and MMGRP_Class_Code = MMATC_Class_Code and MMGRP_Company_Code=MMATC_Company_Code
and MMAT_Company_Code =1
and MMGRP_Company_Code= MMAT_Company_Code and MMAT_Company_Code= 1
and MMAT_Company_Code= MMATC_Company_Code 
Update #temp set mmgrp_description=replace(mmgrp_description,char(9),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(9),'-')


Update #temp set mmgrp_description=replace(mmgrp_description,char(10),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(10),'-')

						
Update #temp set mmgrp_description=replace(mmgrp_description,char(11),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(11),'-')

Update #temp set mmgrp_description=replace(mmgrp_description,char(12),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(12),'-')
						
Update #temp set mmgrp_description=replace(mmgrp_description,char(13),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(13),'-')
						
Update #temp set mmgrp_description=replace(mmgrp_description,char(14),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(14),'-')

Update #temp set mmgrp_description=replace(mmgrp_description,char(15),'-'),MMAT_Material_Description=replace(MMAT_Material_Description,char(15),'-')

Update #temp set mmgrp_description=replace(mmgrp_description,'"','-'),MMAT_Material_Description=replace(MMAT_Material_Description,'"','-')

select *from #temp 

SELECT *FROM eip.sqlmas.GEN_M_Transaction_Details

