/* select count(*)
from Bid
where exists
(select itemID, count(*) 
from Bid 
group by itemID 
having count(*) > 1);

have number of items that got bid on more than once.

select count(*)/2
from (
select a.userID as Bidder1, b.userID as Bidder2
from Bid a, Bid b
where a.itemID = b.itemID
and a.userID <> b.userID)BIDDER_PAIRS; */

select count(*) * 0.5
from (
select a.userID as Bidder1, b.userID as Bidder2
from Bid a, Bid b
where a.itemID = b.itemID
and a.userID <> b.userID
group by Bidder1, Bidder2)DISTINCT_BIDDER_PAIRS;