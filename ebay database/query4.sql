select count(distinct(Item.userID)) 
from Item,User 
where Item.userID = User.userID 
and User.rating > 1000;