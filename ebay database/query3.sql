select ItemID 
from Item 
where Buy_Price = (
	select Max(Buy_Price) 
	from Item);