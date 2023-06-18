create table Employee
(
	Id INT PRIMARY KEY IDENTITY,
	Name varchar(30),
)

create table Sales 
(
	Id INT PRIMARY KEY IDENTITY,
	Employee_id	INT REFERENCES Employee(Id),
	Price INT,
)

Insert into Employee Values('Bob')
Insert into Employee Values('Egor')
Insert into Employee Values('Ivan')
Insert into Employee Values('Alex')
Insert into Employee Values('Artem')
Insert into Employee Values('Igor')
Insert into Employee Values('Anna')

Insert into Sales(Employee_id, Price) Values(2, 1300)
Insert into Sales(Employee_id, Price) Values(2, 1300)
Insert into Sales(Employee_id, Price) Values(1, 100)
Insert into Sales(Employee_id, Price) Values(1, 100)
Insert into Sales(Employee_id, Price) Values(1, 2300)
Insert into Sales(Employee_id, Price) Values(4, 10300)
Insert into Sales(Employee_id, Price) Values(4, 10300)
Insert into Sales(Employee_id, Price) Values(4, 10300)
Insert into Sales(Employee_id, Price) Values(1, 3000)
Insert into Sales(Employee_id, Price) Values(1, 53000)
Insert into Sales(Employee_id, Price) Values(4, 1000)

select Employee.ID, Employee.Name, Count(Sales.Employee_id) as sales_c, rank() over (order by Count(Sales.Employee_id) desc) [rank], 
SUM(Sales.Price) AS sales_s, rank() over (order by SUM(Sales.Price) desc) [sales_rank_s]
from Employee, Sales
WHERE Employee.Id = Sales.Employee_id
GROUP BY Employee.Id, Employee.Name 
ORDER BY sales_s DESC
