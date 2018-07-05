# Constraint: The end time for a bid must be after its start time.

drop trigger if exists item_check_before;
drop trigger if exists before_insert_bid;
drop trigger if exists after_insert_bid;
drop trigger if exists before_update_time;


delimiter //
create trigger item_check_before before insert on Item
for each row
begin
if new.ends < new.started then
call 'Error0:The end time must be after its start time.';
end if;
end; //
delimiter;

create trigger before_insert_bid before insert on Bid

;

create trigger after_insert_bid after insert on Bid
for each row
begin
set new.Currently = new.Amount;
end;


delimiter //
create trigger before_update_time before update time on CurrentTime
for each row
begin
if old.timeNow > new.timeNow then
call 'Error8: The current time can only advance forward in time, not backward in time.';
end if;
end; //
;