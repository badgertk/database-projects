select count(*)
from (
select distinct(Item.userID)
from Item, Bid
where Item.userID = Bid.userID)SELLER_BIDDER_TABLE;

-- (select distinct(Item.userID)
-- from Item)SELLER_TABLE;

-- (select distinct(Bid.userID)
-- from Bid)BIDDER_TABLE;