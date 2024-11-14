SELECT count(c.State), c.State
from Customer c
where c.Country = "USA"
group by c.State
having count(c.State)<3
order by c.State asc;