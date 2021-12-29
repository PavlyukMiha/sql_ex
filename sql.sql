/* 
������� ����� ������, �������� � ������ �������� ����� ��� ���� �� ���������� 
����� 500 ���. �������: model, speed � hd
*/  

Select model, speed, hd from PC
where price < 500;

/* 
������� �������������� ���������. �������: maker
*/  
Select distinct maker from Product
where type = 'Printer';

/* 
������� ����� ������, ����� ������ � ������� ������� ��-���������, 
���� ������� ��������� 1000 ���.
*/  
Select model, ram, screen from Laptop
where price > 1000;

/* 
������� ��� ������ ������� Printer ��� ������� ���������.
*/  
Select * from Printer 
where color = 'y';

/* 
������� ����� ������, �������� � ������ �������� ����� ��, 
������� 12x ��� 24x CD � ���� ����� 600 ���.
*/  
Select model, speed, hd from PC
where (cd = '12x' or cd = '24x') and  price < 600;

/* 
��� ������� �������������, ������������ ��-�������� c ������� �������� ����� 
�� ����� 10 �����, ����� �������� ����� ��-���������. �����: �������������, ��������.
*/  
select DISTINCT product.maker, laptop.speed from Laptop 
inner join Product
on Laptop.model= Product.model
where Laptop.hd >= 10;

/* 
������� ������ ������� � ���� ���� ��������� � ������� ��������� (������ ����) 
������������� B (��������� �����).
*/  
Select product.model, PC.price from product
inner join PC on PC.model = product.model
where maker = 'B'
UNION
Select product.model, Laptop.price from product
inner join Laptop on Laptop.model = product.model
where maker = 'B'
UNION
Select product.model, Printer.price from product
inner join Printer on Printer.model = product.model
where maker = 'B';

/* 
8 ������� �������������, ������������ ��, �� �� ��-��������.
*/  
SELECT DISTINCT maker
FROM product
WHERE type = 'PC'
MINUS
SELECT DISTINCT product.maker
FROM product
Where type = 'Laptop';

/* 
������� �������������� �� � ����������� �� ����� 450 ���. �������: Maker
*/  
Select distinct maker from product
inner join PC on PC.model = product.model
where speed > 449;

/* 
������� ������ ���������, ������� ����� ������� ����. �������: model, price
*/  
Select model, price from printer
where price = (select max(price)  from printer);

/* 
������� ������� �������� ��.
*/  
Select avg(speed) from pc;

/* 
������� ������� �������� ��-���������, ���� ������� ��������� 1000 ���.
*/  
Select avg(speed) from laptop
where price > 1000;

/* 
������� ������� �������� ��, ���������� �������������� A.
*/  
Select avg(speed) from pc
inner join product on pc.model = product.model
where maker = 'A';

/* 
������� �����, ��� � ������ ��� �������� �� ������� Ships, ������� �� ����� 10 ������.
*/  
Select c.class, s.name, c.country from Classes c 
inner join ships s
on s.class = c.class
where numGuns >=10;

/* 
������� ������� ������� ������, ����������� � ���� � ����� PC. �������: HD
*/  
Select hd from pc
group by hd
having count(*) > 1;

/* 
������� ���� ������� PC, ������� ���������� �������� � RAM. � ���������� 
������ ���� ����������� ������ ���� ���, �.�. (i,j), �� �� (j,i), 
������� ������: ������ � ������� �������, ������ � ������� �������, �������� � RAM.
*/  
select distinct pc1.model, pc2.model, pc1.speed, pc1.ram from pc pc1, pc pc2
where pc1.speed = pc2.speed and pc2.ram = pc1.ram and pc1.model> pc2.model;

/* 
������� ������ ��-���������, �������� ������� ������ �������� ������� �� ��.
�������: type, model, speed
*/  
Select distinct p.type, l.model, l.speed from laptop l
inner join product p
on p.model = l.model
where l.speed < ALL (select speed  from pc);

/* 
������� �������������� ����� ������� ������� ���������. �������: maker, price
*/  
select distinct p.maker, pri.price from product p
inner join printer pri on pri.model = p.model
where color = 'y' and price = (select min(price) from printer where color = 'y');

/* 
��� ������� �������������, �������� ������ � ������� Laptop, 
������� ������� ������ ������ ����������� �� ��-���������.
�������: maker, ������� ������ ������.
*/  
Select maker, avg(screen) from product p
inner join laptop l 
on l.model = p.model
group by maker;

/* 
������� ������������ ���� ��, ����������� ������ ��������������, 
� �������� ���� ������ � ������� PC.
�������: maker, ������������ ����.
*/  
Select maker, max(price) from product pr
inner join pc on pc.model = pr.model
group by pr.maker;

/* 
��� ������� �������� �������� ��, ������������ 600 ���, ���������� ������� ���� �� 
� ����� �� ���������. �������: speed, ������� ����.
*/  
Select speed, avg(price) from pc
where speed > 600
group by speed;

/* 
������� ��������������, ������� ����������� �� ��� ��
�� ��������� �� ����� 750 ���, ��� � ��-�������� �� ��������� �� ����� 750 ���.
�������: Maker
*/  
Select distinct maker from product pr
join pc on pr.model = pc.model
where pc.speed >= 750 and maker in 
(select distinct pr.maker from product pr
join laptop l on pr.model = l.model
where l.speed >= 750);

/* 
����������� ������ ������� ����� �����, ������� ����� ������� ���� 
�� ���� ��������� � ���� ������ ���������.
*/  
SELECT model
FROM (
 SELECT model, price
 FROM pc
 UNION
 SELECT model, price
 FROM Laptop
 UNION
 SELECT model, price
 FROM Printer
) t1
WHERE price = (
 SELECT MAX(price)
 FROM (
  SELECT price
  FROM pc
  UNION
  SELECT price
  FROM Laptop
  UNION
  SELECT price
  FROM Printer
  ) t2
 );
 
/* 
������� ������� ������ ����� �� ������� �� ��� ��������������, ������� ��������� 
� ��������. �������: maker, ������� ������ HD.
*/  
Select maker, avg(pc.hd) from pc 
join product pr on pr.model = pc.model
where maker in (select maker from product where type = 'Printer')
group by maker;

/* 
��������� ������� Product, ���������� ���������� ��������������,
����������� �� ����� ������.
*/  
Select count(maker) from product
where maker in (select maker from product 
group by maker
having count(*) = 1);

/* 
� �������������, ��� ������ � ������ ����� �� ������ ������ ������ �����������
�� ���� ������ ���� � ���� [�.�. ��������� ���� (�����, ����)], �������� ������
� ��������� ������� (�����, ����, ������, ������). 
������������ ������� Income_o � Outcome_o.
*/  
select i.point, i."date", i.inc, o."out" from Income_o i 
left join Outcome_o o on o."date" = i."date" and o.point = i.point
union
select o.point, o."date", i.inc, o."out" from Income_o i 
right join Outcome_o o on o."date" = i."date" and o.point = i.point;

/* 
� �������������, ��� ������ � ������ ����� �� ������ ������ ������ ����������� 
������������ ����� ��� (��������� ������ � �������� �������� ������� code), 
��������� �������� �������, � ������� ������� ������ �� ������ ���� ���������� 
�������� ����� ��������������� ���� ������.
�����: point, date, ��������� ������ ������ �� ���� (out), ��������� ������ ������ 
�� ���� (inc). ������������� �������� ������� ��������������� (NULL).
*/  
select point, date, SUM(sum_out), SUM(sum_inc)
from( select point, date, SUM(inc) as sum_inc, null as sum_out from Income Group by point, date
Union
select point, date, null as sum_inc, SUM(out) as sum_out from Outcome Group by point, date ) as t
group by point, date order by point;

/* 
��� ������� ��������, ������ ������ ������� �� ����� 16 ������, ������� ����� � ������.
*/  
select CLASS, COUNTRY from Classes 
where BORE > 15;

/* 
������� �������, ����������� � ��������� � �������� ��������� (North Atlantic). 
�����: ship.
*/  
select ship from Outcomes 
where BATTLE = 'North Atlantic' and result = 'sunk';

/* 
�� �������������� �������������� �������� �� ������ 1922 �. ����������� ������� 
�������� ������� �������������� ����� 35 ���.����. ������� �������, 
���������� ���� ������� (��������� ������ ������� c ��������� ����� ������ �� ����). 
������� �������� ��������.
*/  
Select distinct name from Classes c
join ships s on s.class = c.class
where DISPLACEMENT>35000 and LAUNCHED >= 1922 and type = 'bb';

/* 
� ������� Product ����� ������, ������� ������� ������ �� ���� ��� ������ �� 
��������� ���� (A-Z, ��� ����� ��������). �����: ����� ������, ��� ������.
*/  
SELECT model, type 
FROM product 
WHERE model NOT LIKE '%[^0-9]%' OR model NOT LIKE '%[^a-z]%'; 

/* 
����������� �������� �������� ��������, ��������� � ���� ������ (������ ������� � Outcomes).
*/  
Select name from ships where class = name
union
select ship as name from classes,outcomes where classes.class = outcomes.ship;

/* 
������� ������, � ������� ������ ������ ���� ������� �� ���� ������ 
(������ ����� ������� � Outcomes).
*/  
SELECT c.class
FROM classes c
 LEFT JOIN (
 SELECT class, name
 FROM ships
 UNION
 SELECT ship, ship
 FROM outcomes
) s ON s.class = c.class
GROUP BY c.class
HAVING COUNT(s.name) = 1;

/* 
������� ������, ������� �����-���� ������ ������� ������ �������� ('bb') 
� ������� �����-���� ������ ��������� ('bc').
*/  
SELECT country
FROM classes
GROUP BY country
HAVING COUNT(DISTINCT type) = 2;

/* 
����� ��������������, ������� ��������� ����� ����� ������, ��� ���� ��� ����������� 
�������������� ������ �������� ���������� ������ ����. �������: maker, type
*/  
SELECT maker, MAX(type)
FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1 AND COUNT(model) > 1;

/* 
��� ������� �������������, � �������� ������������ ������ ���� �� � ����� �� ������ PC, 
Laptop ��� Printer, ���������� ������������ ���� �� ��� ���������. 
�����: ��� �������������, ���� ����� ��� �� ��������� ������� ������������� 
������������ NULL, �� �������� ��� ����� ������������� NULL, ����� ������������ ����.
*/  
with D as
(select model, price from PC
union
select model, price from Laptop
union
select model, price from Printer);

Select distinct P.maker,
CASE WHEN MAX(CASE WHEN D.price IS NULL THEN 1 ELSE 0 END) = 0 THEN
MAX(D.price) END
from Product P
right join D on P.model=D.model
group by P.maker;

/* 
������� �������� ��������, ����������� � ���������, � �������� ��������, 
� ������� ��� ���� ���������.
*/  
Select ship, battle from Outcomes 
where result = 'sunk';

/* 
������� ��������, ������� ��������� � ����, �� ����������� �� � ����� 
�� ����� ������ �������� �� ����.
*/  
select NAME from BATTLES t
where to_char("date", 'YYYY') not in 
(select launched from ships 
where launched is not null);

/* 
������� �������� ���� �������� � ���� ������, ������������ � ����� R.
*/  
select name from SHIPS t
where name like 'R%'
UNION
SELECT Ship From Outcomes
where Ship LIKE 'R%';

/* 
������� �������� ���� �������� � ���� ������, ��������� �� ���� � ����� ���� 
(��������, King George V). �������, ��� ����� � ��������� ����������� ���������� 
���������, � ��� �������� ��������.
*/  
select name from SHIPS t
where name like '% % %'
UNION
SELECT Ship From Outcomes
where Ship LIKE '% % %';

/* 
��� ������� �������, �������������� � �������� ��� ������������ (Guadalcanal), 
������� ��������, ������������� � ����� ������.
*/  
SELECT o.ship, displacement, numGuns FROM
(SELECT name AS ship, displacement, numGuns
FROM Ships s JOIN Classes c ON c.class=s.class
UNION
SELECT class AS ship, displacement, numGuns
FROM Classes c) a
RIGHT JOIN Outcomes o
ON o.ship=a.ship
WHERE battle = 'Guadalcanal';

/* 
���������� ������, ������� �������� � ��������� ��� ���� �������.
*/  
WITH T1 AS ( SELECT COUNT(name) as co, country FROM
(SELECT name, country FROM Classes INNER JOIN Ships ON Ships.class = Classes.class
UNION
SELECT ship, country FROM Classes INNER JOIN Outcomes ON Outcomes.ship = Classes.class) FR1
GROUP BY country;
),

T2 AS ( SELECT COUNT(name) as co, country 
FROM ( SELECT name, country FROM Classes INNER JOIN Ships ON Ships.class = Classes.class
WHERE name IN (SELECT DISTINCT ship FROM Outcomes WHERE result LIKE 'sunk')
UNION
SELECT ship, country 
FROM Classes INNER JOIN Outcomes ON Outcomes.ship = Classes.class
WHERE ship IN (SELECT DISTINCT ship FROM Outcomes WHERE result LIKE 'sunk')
) FR2 GROUP BY country );

SELECT T1.country FROM T1
INNER JOIN T2 ON T1.co = t2.co and t1.country = t2.country;

/* 
������� ������ ��������, � ������� ���� �� ���� ������� ��� �������� � ��������.
*/  
SELECT cl.class
FROM Classes cl
LEFT JOIN Ships s ON s.class = cl.class
WHERE cl.class IN (SELECT ship FROM Outcomes WHERE result = 'sunk') OR
s.name IN (SELECT ship FROM Outcomes WHERE result = 'sunk')
GROUP BY cl.class;

/* 
������� �������� �������� � �������� ������� 16 ������ (������ ������� �� ������� Outcomes).
*/  
select name from Ships s
join classes c on s.class = c.class
where bore = 16
union
select class from Outcomes o
join classes c on o.ship= c.class
where bore = 16;

/* 
������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.
*/  
select battle from Outcomes o
join ships s on s.name = o.ship
where class = 'Kongo';

/* 
������� �������� ��������, ������� ���������� ����� ������ ����� ���� ��������� 
�������� ������ �� ������������� (������ ������� �� ������� Outcomes).
*/  
with sh as (
  select name, class from ships
  union
  select ship, ship from outcomes
)
select
  name
  from sh join classes c on sh.class=c.class
  where numguns >= all(
    select ci.numguns from classes ci
      where ci.displacement=c.displacement
        and ci.class in (select sh.class from sh)
    );

/*     
���������� �������� ���� �������� �� ������� Ships, ������� ����� ���� �������� 
�������� ��������, ������� ����� ������� ������ �� ����� ������, ������ ������ 
����� 19 ������ � ������������� �� ����� 65 ���.����
*/  
select name from ships s
join Classes c on c.class = s.class 
where (type = 'bb' or type is null) 
and (COUNTRY = 'Japan' or COUNTRY is null) 
and (NUMGUNS > 8 or NUMGUNS is null) 
and (BORE < 19 or BORE is null) 
and (DISPLACEMENT <=65000 or DISPLACEMENT is null);

/* 
���������� ������� ����� ������ ��� ������� �������� ��������.
�������� ��������� � ��������� �� 2-� ���������� ������.
*/  
Select round(avg(numGuns), 2) from Classes 
where type = 'bb';

/* 
� ��������� �� 2-� ���������� ������ ���������� ������� ����� ������ 
���� �������� �������� (������ ������� �� ������� Outcomes).
*/  
with sh as (
  select name, s.class, type, numGuns from ships s
  join Classes c on c.class = s.class
  union
  select ship, ship, type, numGuns from outcomes o
  join Classes c on c.class = o.ship
)

select round(avg(numGuns),2) from sh 
where type = 'bb';

/* 
��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� 
����� ������. ���� ��� ������ �� ���� ��������� ������� ����������, ���������� 
����������� ��� ������ �� ���� �������� ����� ������. �������: �����, ���.
*/  
select c.class,  min(launched) from ships s
right join Classes c on c.class = s.class
group by c.class ;

/* 
��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. 
�������: ����� � ����� ����������� ��������.
*/  
SELECT c.class, COUNT(s.ship)
FROM classes c
  LEFT JOIN
    (
       SELECT o.ship, sh.class
       FROM outcomes o
       LEFT JOIN ships sh ON sh.name = o.ship
       WHERE o.result = 'sunk'
    ) s ON s.class = c.class OR s.ship = c.class
GROUP BY c.class;

