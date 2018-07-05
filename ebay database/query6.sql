select count(*) 
from Category 
where itemID in ( 
select itemID 
from Bid 
where amount > 1000);