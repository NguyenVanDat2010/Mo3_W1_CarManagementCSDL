create database CarManagement;

use carmanagement;

create table Offices
(
    officeCode   char(15) primary key,
    city         nvarchar(50),
    phone        varchar(50),
    addressLine1 nvarchar(50),
    addressLine2 nvarchar(50),
    state        nvarchar(50),
    country      nvarchar(50),
    postalCode   char(15)
);

create table Productlines
(
    productLine     char(50) primary key,
    textDescription text,
    image           text
);

create table Employees
(
    employeeNumber int primary key,
    lastName       nvarchar(50)  not null,
    firstName      nvarchar(50)  not null,
    email          varchar(100)  not null,
    jobTitle       nvarchar(100) not null,
    reportTo       int,
    constraint FK_Employees_Employees foreign key (reportTo)
        references Employees (employeeNumber)
);

create table Customers
(
    customerNumber   int primary key,
    customerName     nvarchar(50) not null,
    contactLastName  nvarchar(50) not null,
    contactFirstName nvarchar(50) not null,
    phone            nvarchar(50) not null,
    addressLine1     nvarchar(50) not null,
    addressLine2     nvarchar(50) not null,
    city             nvarchar(50) not null,
    state            nvarchar(50) not null,
    postalCode       nvarchar(15) not null,
    country          nvarchar(50) not null,
    creditLimit      nvarchar(50),
    employeeNumber   int,
    officeCode       char(15),
    constraint FK_Customers_Employees foreign key (employeeNumber)
        references Employees (employeeNumber),
    constraint FK_Customers_Offices foreign key (officeCode)
        references Offices (officeCode)
);

create table Orders
(
    orderNumber     int primary key,
    orderDate       date    not null,
    requiredDate    date    not null,
    shippedDate     date,
    status          boolean not null,
    comments        text,
    quantityOrdered int     not null,
    priceEach       float   not null,
    customerNumber  int,
    constraint FK_Orders_Customers foreign key (customerNumber)
        references Customers (customerNumber)
);

create table Products
(
    productCode        char(15) primary key,
    productName        nvarchar(50) not null,
    productScale       nchar(10)    not null,
    productVendor      nvarchar(50) not null,
    productDescription text         not null,
    quantityInStock    int          not null,
    buyPrice           float        not null,
    MSRP               float        not null,
    productLine        char(50),
    constraint FK_Products_Productlines foreign key (productLine)
        references Productlines (productLine)
);

create table OrderDetails
(
    orderNumber int,
    productCode char(15),
    constraint PK_OrderDetails primary key (orderNumber, productCode),
    constraint FK_OrderDetails_Products foreign key (productCode)
        references Products (productCode),
    constraint FK_OrderDetails_Orders foreign key (orderNumber)
        references Orders (orderNumber)
);

create table Payments
(
    checkNumber    varchar(50) primary key,
    paymentDate    date  not null,
    amount         float not null,
    customerNumber int,
    constraint FK_Payments_Customers foreign key (customerNumber)
        references Customers (customerNumber)

);


