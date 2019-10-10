select * from course;
select * from student;
select * from instructor;
select * from section;
select * from take;
select * from teach;
select * from department;
/*1.*/
select iname,depname,location from instructor join department using(depname);
/*2.*/
insert into section
values(109,'CS100',5,2010,133);	
select ctitle from course join section using(ccode)
where year=2010 and sem=5;
/*3*/
insert into section
values(110,'MAT02',5,2017,134);	
select ctitle from course join section using(ccode)
where year=2017 and sem=5;
/*4*/
insert into section
values(111,'CS100',5,2017,134);
select ccode from section where sem=5 and year=2010 union select ccode from section where sem=5 and year=2017;
/*5*/
select ccode from section where sem=5 and year=2010 union all select ccode from section where sem=5 and year=2017;
/*6*/
select ccode from section where sem=5 and year=2010 intersect select ccode from section where sem=5 and year=2017;
/*7*/
select ccode from section where sem=5 and year=2010 except select ccode from section where sem=5 and year=2017;
/*8*/
insert into teach
values(125,111,'CS100',5,2017);
select count(*) from teach where sem=5 and year=2017;
/*9*/
select depname,avg(salary) from instructor group by depname;
/*10*/
select depname,count(*) from instructor join teach using(id) where sem=5 and year=2017 group by depname;
/*11*/
select depname,avg(salary) from instructor group by depname
having avg(salary) >45000;

/*PART 2*/
create table salesman
( salesman_id int primary key,name varchar(50),city varchar(40),commission numeric (3,2));
insert into salesman values(5001,'James Hoog','New York',0.15);
insert into salesman values(5002,'Nail Knite','Paris',0.13);
insert into salesman values(5005,'Pit Alex','London',0.11);
insert into salesman values(5006,'Mc Lyon','Paris',0.14);
insert into salesman values(5003,'Lauson Hen',NULL,0.12);
insert into salesman values(5007,'Paul Adam','Rome',0.13);

select * from salesman;

create table customer
(customer_id int primary key,cust_name varchar(80),city varchar(80),grade int, salesman_id int references salesman);

insert into customer values(3002,'Nick Rimando','New York',100,5001);
insert into customer values(3005,'Graham Zusi','California',200,5002);
insert into customer values(3001,'Brad Guzan','London',NULL,5005);
insert into customer values(3004,'Fabian Johns','Paris',300,5006);
insert into customer values(3007,'Brad Davis','New York',200,5001);
insert into customer values(3009,'Geoff Camero','Berlin',100,5003);
insert into customer values(3008,'Julian Green','London',300,5002);
insert into customer values(3003,'Jozy Altidor','Moncow',200,5007);

select * from customer;

create table orders
(ord_no  int primary key,purch_amt numeric(10,2),ord_date date,customer_id int references customer,salesman_id int references salesman);

insert into orders values(70001,150.5,'2012-10-05',3005,5002);
insert into orders values(70009,270.65,'2012-09-10',3001,5005);
insert into orders values (70002,65.26,'2012-10-05',3002,5001);
insert into orders values (70004,110.5,'2012-08-17',3009,5003);
insert into orders values (70007,948.5,'2012-09-10',3005,5002);
insert into orders values (70005,2400.6,'2012-07-27',3007,5001);
insert into orders values (70008,5760,'2012-09-10',3002,5001);
insert into orders values (70010,1983.43,'2012-10-10',3004,5006);
insert into orders values (70003,2480.4,'2012-10-10',3009,5003);
insert into orders values (70012,250.45,'2012-06-27',3008,5002);
insert into orders values (70011,75.29,'2012-08-17',3003,5007);
insert into orders values (70013,3045.6,'2012-04-25',3002,5001);

select * from orders;
/*1*/
select cust_name,name as "Salesman Name" from customer join salesman using(salesman_id);
/*2*/
select customer_id from customer join salesman using(salesman_id) where commission=0.12;
/*3*/
select customer_id from customer join salesman using(salesman_id) where commission=0.12 and customer.city<>salesman.city;
/*4*/
select ord_no,ord_date,purch_amt,customer_id,salesman_id,salesman.commission from orders join salesman using(salesman_id); 
/*5*/
select distinct cust_name from customer,orders where customer.customer_id=orders.customer_id
order by cust_name;
/*6*/
select distinct cust_name from customer,orders 
where customer.customer_id=orders.customer_id and customer.grade<300
order by cust_name;
/*7*/
insert into customer
values(3010,'Rakesh Dhawan','Bengaluru',100,5001);
select customer.cust_name,customer.city,orders.ord_no,orders.ord_date,purch_amt 
from customer left outer join orders on customer.customer_id=orders.customer_id
order by ord_date;
/*8*/
insert into customer
values(3011,'Satish Dhawan','Mumbai',100,null);
insert into orders
values(70014,40000.59,'2012-05-27',3011,null);
/*9*/
select customer.cust_name,customer.city,orders.ord_no,orders.ord_date,purch_amt,orders.ord_date,
salesman.name,salesman.commission
from customer left outer join orders on customer.customer_id=orders.customer_id 
left outer join salesman on salesman.salesman_id=orders.salesman_id;
/*10*/
select distinct salesman.name from salesman left outer join orders on salesman.salesman_id=orders.salesman_id 
order by salesman.name;
/*11*/
select distinct salesman.name from salesman left outer join orders on salesman.salesman_id=orders.salesman_id
left outer join customer on orders.customer_id=customer.customer_id
where orders.purch_amt >2000 and customer.grade is not null;
/*12*/
select * from salesman cross join customer;
/*13*/
select * from salesman cross join customer where salesman.city=customer.city;
/*14*/
select * from salesman cross join customer where salesman.city=customer.city and
customer.grade is not null;




