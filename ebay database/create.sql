-- cleanup if residuals exist



drop table if exists Bid;
drop table if exists Category;
drop table if exists Item;
drop table if exists User;
drop table if exists Current_Time;
create table User(
	UserID varchar(255) not null,
	Rating int not null,
	Location varchar(255), -- some of the values in this field are garbage
	Country varchar(255), -- large majority USA
	primary key (UserID)
);

create table Item(
	ItemID int not null,
	primary key (ItemID),
	Name varchar(255), -- name of the item
	Currently float, 
	Buy_Price float,
	First_Bid float,
	Started datetime,
	Ends datetime,
	UserID varchar(255), -- this person is the seller
	constraint fk_seller foreign key (UserID) references User(UserID),
	Description varchar(4096) -- very long!
);

create table Bid(
	ItemID int not null,
	constraint fk_item_bids foreign key (ItemID) references Item(ItemID),
	UserID varchar(255) not null,
	constraint fk_bidder foreign key (UserID) references User(UserID),
	Time datetime not null,
	Amount float not null,
	primary key (UserID, Time)
	
);
create table Category(
	ItemID int not null,
	constraint fk_item_category foreign key (ItemID) references Item(ItemID),
	category varchar(255) not null,
	primary key (ItemID, category)
);

create table CurrentTime(
	timeNow datetime not null
);

insert into CurrentTime values ('2001-12-20 00:00:01');
select timeNow from CurrentTime;