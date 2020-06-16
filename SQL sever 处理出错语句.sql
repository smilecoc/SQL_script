---处理出错语句，如果语句出错的话会使用后面的语句处理出错动作

begin try
select left([ga_ad_content],charindex('?',[ga_ad_content])) as ga_adcontent_stan from [dbo].[adi_digital_fact_ga]
end try 
begin catch 
--sql (处理出错动作)
select [ga_ad_content] as ga_adcontent_stan from [dbo].[adi_digital_fact_ga]
end catch