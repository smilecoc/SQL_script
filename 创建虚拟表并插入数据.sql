;with cte_data as 
(
select 'A' as Department,'A1' as [Name],'Y' as pan,17.78 as Rate 
union all 
select 'A','A2','N',16.82 
union all 
select 'A','A3','Y',16.82
union all 
select 'B','B1','N',10.25 
union all 
select 'B','B2','N',50.48 

)
select Department
    ,[Name]
	,pan
    ,Rate
into #data
from cte_data
go

drop table #data
select * from #data


select Department,sum(Rate)
from #data
where pan ='Y'
group by Department




select Department,pan,sum(Rate)
from #data
group by Department,pan

select Department,sum(Rate) over
(partition by Department order by Department)
from  #data