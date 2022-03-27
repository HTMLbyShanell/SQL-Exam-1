DROP database HoltDistributors;
go
CREATE database HoltDistributors;
go
USE HoltDistributors;
go

CREATE TABLE Territory(
	TerritoryNumber INT, 
	TerritoryName VARCHAR(100),
	Region VARCHAR(50),
	Quota VARCHAR(25),
	PRIMARY KEY (TerritoryNumber));

	INSERT into Territory
		(TerritoryNumber, TerritoryName, Region, Quota)
	values
		(1, 'Northwest', 'Pacific', '1000');


CREATE TABLE Employee(
	EmployeeID INT,
	EmpName VARCHAR(25),
	EmpAddress1 VARCHAR(50),
	EmpAddress2 VARCHAR(50),
	EmpCity VARCHAR(25),
	EmpState VARCHAR(20),
	EmpZip VARCHAR(5),
	EmpPhone VARCHAR(10),
	PRIMARY KEY (EmployeeID));

	INSERT into Employee
		(EmployeeID, EmpName, EmpAddress1, EmpAddress2, EmpCity, EmpState, EmpZip, EmpPhone)
	values
		(1234, 'Shirley Chisolm', '10100 West Freedom Street', 'Apt 100', 'Fargo', 'ND', '00000', '777-9311');


CREATE TABLE SalesRep(
	EmployeeID INT,
	MTDSales NUMERIC(6,2),
	YTDSales NUMERIC(7,2),
	MTDCommission NUMERIC(4,2),
	YTDCommission NUMERIC(4,2),
	CommissionRate NUMERIC(2,2),
	TerritoryNumber INT,
	PRIMARY KEY (EmployeeID, TerritoryNumber),
	FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
	FOREIGN KEY (TerritoryNumber) REFERENCES Territory (TerritoryNumber));

	INSERT into SalesRep
		(EmployeeID, MTDSales, YTDSales, MTDCommission, YTDCommission, CommissionRate, TerritoryNumber)
	values
		(1234, 1800.00, 34544.00, 180.00, 345.00, 0.10, 3);

CREATE TABLE Customer(
	CustomerNumber INT,
	FName VARCHAR(25),
	LName VARCHAR(25),
	Address1 VARCHAR(50),
	Address2 VARCHAR(50),
	City VARCHAR(25),
	State VARCHAR(10),
	ZipCode VARCHAR(5),
	PhoneNum VARCHAR(10),
	MTDSales NUMERIC(6,2),
	YTDSales NUMERIC(7,2),
	CurrentBalance NUMERIC(6,2),
	CreditLimit NUMERIC(6,2),
	ShipName VARCHAR(25),
	ShipAddress1 VARCHAR(50),
	ShipAddress2 VARCHAR(50),
	ShipCity VARCHAR(25),
	ShipState VARCHAR(10),
	ShipZipCode VARCHAR(5),
	CurrentInvoiceTotal NUMERIC(5,2),
	CurrentPaymentTotal NUMERIC(5,2),
	CurrentAmount NUMERIC(5,2),
	Over30 NUMERIC(5,2),
	Over60 NUMERIC(5,2),
	Over90 NUMERIC(5,2),
	PreviousBalance NUMERIC(5,2),
	EmployeeID INT,
	PRIMARY KEY (CustomerNumber),
	FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID));

	INSERT into Customer
		(CustomerNumber, FName, LName, Address1, Address2, City, State, ZipCode, PhoneNum, MTDSales, YTDSales, CurrentBalance, CreditLimit, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZipCode, CurrentInvoiceTotal, CurrentPaymentTotal, CurrentAmount, Over30, Over60, Over90, PreviousBalance, EmployeeID)
	values
		(56789, 'Beyonce', 'Knowles', '100 East JayZ Ave', 'Penthouse 1', 'Brooklyn', 'NY', '10001', '414-777-7777', 2500.00, 35000.00, 3238.45, 5000.00, 'Beyonce Knowles', '1 Pennsylvania Ave', '', 'Washington', 'DC', '20002', 120.00, 240.00,255.00, 125.00, 333.00, 803.00, 190.00, 1287456);



CREATE TABLE Vendor(
	VendorNumber INT,
	Name VARCHAR(25),
	Address VARCHAR(100),
	City VARCHAR(25),
	State VARCHAR(10),
	ZipCode VARCHAR(5),
	PhoneNum VARCHAR(10),
	CreditLimit NUMERIC(5,2),
	PRIMARY KEY (VendorNumber));

	INSERT into Vendor
		(VendorNumber, Name, Address, City, State, ZipCode, PhoneNum, CreditLimit)
	values
		(18234, 'Janet Jackson Vendor', '99 Jasmine Street', 'Unit 10', 'Virginia Beach', 'VA', '20245', '281-338-8004', 875.00);


CREATE TABLE Part(
	PartNumber INT,
	VendorNumber INT,
	PartDesc VARCHAR(100),
	UnitPrice NUMERIC(4,2),
	MTDSales NUMERIC(6,2),
	YTDSales NUMERIC(6,2),
	UnitsOnHand INT,
	UnitsAllocated INT,
	RecorderPoint INT,
	VendorPrice NUMERIC(4,2),
	MinOrderQuantity INT,
	ExpectedLeadTime INT,
	PRIMARY KEY (PartNumber, VendorNumber),
	FOREIGN KEY (VendorNumber) REFERENCES Vendor(VendorNumber));

	INSERT into Part
		(PartNumber, VendorNumber, PartDesc, UnitPrice, MTDSales, YTDSales, UnitsOnHand, UnitsAllocated, RecorderPoint, VendorPrice, MinOrderQuantity, ExpectedLeadTime)
	values
		(456776543, 12345, 'Robot 3000', 50.00, 7504.00, 8000.00, 312, 125, 8, 29.00, 1, 3);


CREATE TABLE Orders(
	OrderNumber INT,
	OrderDate DATE,
	CustomerNumber INT,
	CustomerPONumber INT,
	OrderTotal INT,
	OrderStatus CHAR(10),
	OrderSpecialCharges NUMERIC(3,2),
	OrderSpecialChargeDesc VARCHAR(50),
	ShipName VARCHAR(25),
	ShipAddress1 VARCHAR(50),
	ShipAddress2 VARCHAR(50),
	ShipCity VARCHAR(25),
	ShipState VARCHAR(10),
	ShipZip VARCHAR(5),
	PRIMARY KEY (OrderNumber),
	FOREIGN KEY (CustomerNumber) REFERENCES Customer (CustomerNumber));

	INSERT into Orders
		(OrderNumber, OrderDate, CustomerNumber, CustomerPONumber, OrderTotal, OrderStatus, OrderSpecialCharges, OrderSpecialChargeDesc, ShipName, ShipAddress1, ShipAddress2, ShipCity, ShipState, ShipZip)
	values
		(110234098, 12-12-2012, 2476890, 1234567, 99, 'Y', 9.99, 'Expedited', 'Rosa Parks', '123 W Main Street', 'Apt 100', 'Los Angeles', 'CA', '90210');


CREATE TABLE OrderDetail(
	OrderNumber INT,
	SEQNumber INT,
	PartNumber INT,
	VendorNumber INT,
	NumberOrdered INT,
	QuotedPrice NUMERIC(5,2),
	LineTotal NUMERIC(6,2),
	Comments VARCHAR(100),
	PRIMARY KEY (OrderNumber, PartNumber),
	FOREIGN KEY (PartNumber) REFERENCES Part (PartNumber),
	FOREIGN KEY (VendorNumber) REFERENCES Vendor (VendorNumber));

	INSERT into OrderDetail
		(OrderNumber, SEQNumber, PartNumber, VendorNumber, NumberOrdered, QuotedPrice, LineTotal, Comments)
	values
		(13608633, 99120102, 5555, 23132, 88, 398.76, 9909.87,'');


CREATE TABLE Invoice(
	InvoiceNumber INT,
	ShipDate DATE,
	Freight VARCHAR(15),
	ShipStatus CHAR(6),
	PRIMARY KEY (InvoiceNumber));

	INSERT into Invoice
		(InvoiceNumber, ShipDate, Freight, ShipStatus)
	values
		(456776543, 12-12-2012, 'UPS', 'Y');


CREATE TABLE InvoiceDetail(
	InvoiceNumber INT,
	OrderNumber INT,
	SEQNumber INT,
	QuantityShipped INT,
	PRIMARY KEY (InvoiceNumber, OrderNumber),
	FOREIGN KEY (InvoiceNumber) REFERENCES Invoice (InvoiceNumber),
	FOREIGN KEY (OrderNumber) REFERENCES Orders (OrderNumber));

	INSERT into InvoiceDetail
		(InvoiceNumber, OrderNumber, SEQNumber, QuantityShipped)
	values
		(456776543, 13608633, 99120102, 3);


CREATE TABLE Payment(
	PaymentNumber INT,
	CustomerNumber INT,
	PaymentDate DATE,
	Amount NUMERIC(6,2),
	PRIMARY KEY (PaymentNumber),
	FOREIGN KEY (CustomerNumber) REFERENCES Customer (CustomerNumber));

	INSERT into Payment
		(PaymentNumber, CustomerNumber, PaymentDate, Amount)
	values
		(0052106080, 374829377, 10-10-2010, 1627.38);