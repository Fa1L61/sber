with cte as
(
select 
	t1.[from],
	t1.tdate, 
	0 - t1.amount as amount
from Transfers t1
union all
select 
	t2.[to],
	t2.tdate,
	t2.amount
from Transfers t2
) , find_prev_value as
(
select 
	t1.[from], 
	t1.tdate, 
	--t1.amount,
	coalesce(sum(t1.amount) over (partition by t1.[from] order by t1.[from], 
	t1.tdate rows between unbounded preceding and current row) , 0) as BALANCE
from cte t1, cte t2
where t1.[from] <> t2.[from] 
and t1.tdate = t2.tdate
group by t1.[from], t1.tdate, t1.amount
)
, count_periods as
(

select [from], 
	convert(varchar, tdate, 104)  as dt_from, 
	convert(varchar, coalesce(lead(tdate) over (partition by [from] order by [from],tdate), '3000-01-01'), 104) as dt_to
from
(
select 
	t1.[from],
	t1.tdate
from Transfers t1
union all
select 
	t2.[to],
	t2.tdate
from Transfers t2
) a

)

select cp.*, fpv.BALANCE 
from count_periods cp
left join find_prev_value fpv
on cp.[from] = fpv.[from]
and cp.dt_from = fpv.tdate

--select * from count_current_balance

