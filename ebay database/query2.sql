select count(*) 
from( 
select NULL 
from Category 
group by itemID 
having count(*) = 4)COUNT4_TABLE;