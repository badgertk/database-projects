
select count(*)
from (select Item.userID, count(Category.category) 
from Item,Category 
where Item.itemID = Category.itemID
group by Item.userID
having count(distinct(Category.category)) > 10)SELLER_CATEGORIES;
/* 

-- each user sells these items
select userID, itemID
from Item
order by userID;

-- these items belong in these categories
select itemID, category
from Category
order by itemID;

select Item.userID, count(Category.category)
from Item, Category
where Item.itemID = Category.itemID;

select Item.userID, count(*)
from Item, Category 
where Item.itemID = Category.itemID
group by Item.userID
having count(*) > 10;


select Item.userID, Category.category 
from Item,Category 
where Item.itemID = Category.itemID; */