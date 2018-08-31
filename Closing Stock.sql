use eip
go



drop table #stocklimit
select a.TWHCS_Material_Code, cast (null as varchar(500)) MMAT_Description, a.TWHCS_Qty, a.TWHCS_Value, a.TWHCS_Job_Code, b.job_description,B.Sector_Code IC,TWHCS_STOCK_YEAR, TWHCS_STOCK_MONTH,
			C.SECTOR_DESCRIPTION,B.BU_CODE,D.bu_description into #stocklimit 
from eip.sqlscm.SCM_T_Warehouse_Closing_Stock a, lnt.dbo.job_master b, LNT.DBO.SECTOR_MASTER c, lnt.dbo.business_unit_master D
where a.TWHCS_Job_Code =b.job_code 
--and job_status in ('P','B')
---and a.TWHCS_Material_Code like '7%'
AND b.company_code='LE'
---and TWHCS_Stock_Year = 2017 and TWHCS_Stock_Month = 6 
AND TWHCS_JOB_CODE = 'LE130413' 
and TWHCS_Stock_Detail_Code =11
AND B.SECTOR_CODE = C.SECTOR_CODE AND C.COMPANY_CODE = B.COMPANY_CODE
AND B.BU_CODE = D.BU_CODE AND D.COMPANY_CODE = B.COMPANY_CODE

alter table #stocklimit add UOM varchar(100)
UPDATE A SET UOM= UUOM_Description, a.mmat_Description = c.mmat_material_description  from #stocklimit a, eip.sqlmas.GEN_M_Materials c, EIP.SQLMAS.GEN_U_Unit_Of_Measurement d
where a.TWHCS_Material_Code = c.MMAT_Material_Code 
and c.MMAT_Company_Code=1
and d.UUOM_UOM_CODE= C.MMAT_UOM_Code
SELECT *FROM #STOCKLIMIT


SELECT * FROM #stocklimit
alter table #stocklimit add BUdesc varchar(100)
alter table #stocklimit add ICdesc varchar(100)

Update a set ICdesc= c.Sector_description from #STOCKLIMIT A, LNT.DBO.SECTOR_MASTER c, LNT.DBO.JOB_MASTER B
where A.TWHCS_Job_Code=B.job_code and c.sector_code =b. sector_code

Update a set BUdesc= D.bu_description FROM #STOCKLIMIT A,LNT.DBO.JOB_MASTER B, lnt.dbo.business_unit_master d
WHERE A.twhcs_job_code= B.job_code
and b.bu_code =d.BU_code

update #stocklimit set BUdesc=replace(BUdesc,',','-'),ICdesc=replace(ICdesc,',','-')

select *from #stocklimit


