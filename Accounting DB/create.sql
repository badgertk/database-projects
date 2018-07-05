drop table if exists Ledger;
drop table if exists Company;
drop table if exists Balance_Sheet;
drop table if exists Item;
drop table if exists Employee;
drop table if exists Has;
drop table if exists Owns;
drop table if exists Lookup;
drop table if exists Updates;
drop table if exists Requests;
drop table if exists Approves_Requests;

CREATE TABLE Ledger (
Transaction_ID integer NOT NULL,
Purchase_For integer NOT NULL, -- the amount of liquid currency being transferred for the item
Exchange_For char() NOT NULL, -- the item being requested
Request_From char() NOT NULL, -- the company that is requesting the item
PRIMARY KEY Transaction_ID
);

CREATE TABLE Company (
Company_ID integer NOT NULL,
Name char() NOT NULL,
PRIMARY KEY Company_ID
);

CREATE TABLE Balance_Sheet (
Company_ID integer NOT NULL,
Income float,
Expenditures float,
Cash_on_Hand float,
FOREIGN KEY Company_ID REFERENCES Company(Company_ID) ON DELETE CASCADE
);
CREATE TABLE Item (
Item_ID integer NOT NULL,
Name char() NOT NULL,
Owner integer, -- the company_ID that owns the item
Fair_Market_Value float, -- the value of the item if it were to be sold to another company
PRIMARY KEY Item_ID,
FOREIGN KEY Owner REFERENCES Company(Company_ID) ON DELETE RESTRICT -- the company must liquidate all item assets before dissolving.
);

CREATE TABLE Employee(
Employee_ID integer NOT NULL,
Name char() NOT NULL,
Works_For integer, -- Refers to the company_id that this employee works for, NULL means
unemployed
Is_Admin Boolean DEFAULT FALSE, -- does this person have more privileges? Admins can update item, employee details, and approve requests.
PRIMARY KEY Employee_ID,
FOREIGN KEY Works_For REFERENCES Company(Company_ID) ON DELETE RESTRICT -- the company must lay off all employees first (set their Works_For field to NULL or a different Company_ID)
);

CREATE TABLE Has (
Company integer, -- the Company_ID of the company
Transaction integer, -- the Transaction_ID that is causing the change in the income,
expenditures, cash on hand values.
Date datetime, -- income expenditures and cash on hand values can change due to monthly accounting (or any other arbitrary amount of time)
Income float,
Expenditures float,
Cash on Hand float,
UNIQUE(date),
FOREIGN KEY (Company) REFERENCES Company(Company_ID),
FOREIGN KEY (Transaction) REFERENCES Ledger(Transaction_ID)
);

CREATE TABLE Owns (
Company_Name integer,
Date datetime,
Item_ID integer
Item_Name char(),
Fair_Market_Value float,
UNIQUE(Date),
FOREIGN KEY (Company_Name) REFERENCES Company(Company_ID),
FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID)
);

CREATE TABLE Lookup (
Lookup_ID integer, -- each query is recorded
Employee_ID integer,
Item_ID integer,
Item_Name char(),
Owner integer,
PRIMARY KEY (Lookup_ID),
FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID),
FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID)
);

CREATE TABLE Updates (
Name char(),
ID integer,
Works_For char(),
FOREIGN KEY (ID) REFERENCES Employee(ID)
);

CREATE TABLE Requests (
Transaction_ID integer,
Item_Name char(),
Owner char(),
Requests_from char(),
FOREIGN KEY (Transaction_ID) REFERENCES Cross_Company_Ledger(Transaction_ID)
);

CREATE TABLE Approves_Requests (-- may need some work
Transaction_ID integer,
Date datetime,
Is_Admin boolean,
Works_For integer,
UNIQUE(Date),
PRIMARY_KEY (Date),
FOREIGN KEY (Works_For) REFERENCES Employee(Works_For),
FOREIGN KEY (Transaction_ID) REFERENCES Cross_Company_Ledger(Transaction_ID)
);