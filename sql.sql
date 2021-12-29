/* 
Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью 
менее 500 дол. Вывести: model, speed и hd
*/  

Select model, speed, hd from PC
where price < 500;

/* 
Найдите производителей принтеров. Вывести: maker
*/  
Select distinct maker from Product
where type = 'Printer';

/* 
Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, 
цена которых превышает 1000 дол.
*/  
Select model, ram, screen from Laptop
where price > 1000;

/* 
Найдите все записи таблицы Printer для цветных принтеров.
*/  
Select * from Printer 
where color = 'y';

/* 
Найдите номер модели, скорость и размер жесткого диска ПК, 
имеющих 12x или 24x CD и цену менее 600 дол.
*/  
Select model, speed, hd from PC
where (cd = '12x' or cd = '24x') and  price < 600;

/* 
Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска 
не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
*/  
select DISTINCT product.maker, laptop.speed from Laptop 
inner join Product
on Laptop.model= Product.model
where Laptop.hd >= 10;

/* 
Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) 
производителя B (латинская буква).
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
8 Найдите производителя, выпускающего ПК, но не ПК-блокноты.
*/  
SELECT DISTINCT maker
FROM product
WHERE type = 'PC'
MINUS
SELECT DISTINCT product.maker
FROM product
Where type = 'Laptop';

/* 
Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
*/  
Select distinct maker from product
inner join PC on PC.model = product.model
where speed > 449;

/* 
Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
*/  
Select model, price from printer
where price = (select max(price)  from printer);

/* 
Найдите среднюю скорость ПК.
*/  
Select avg(speed) from pc;

/* 
Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
*/  
Select avg(speed) from laptop
where price > 1000;

/* 
Найдите среднюю скорость ПК, выпущенных производителем A.
*/  
Select avg(speed) from pc
inner join product on pc.model = product.model
where maker = 'A';

/* 
Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
*/  
Select c.class, s.name, c.country from Classes c 
inner join ships s
on s.class = c.class
where numGuns >=10;

/* 
Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
*/  
Select hd from pc
group by hd
having count(*) > 1;

/* 
Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате 
каждая пара указывается только один раз, т.е. (i,j), но не (j,i), 
Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
*/  
select distinct pc1.model, pc2.model, pc1.speed, pc1.ram from pc pc1, pc pc2
where pc1.speed = pc2.speed and pc2.ram = pc1.ram and pc1.model> pc2.model;

/* 
Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
Вывести: type, model, speed
*/  
Select distinct p.type, l.model, l.speed from laptop l
inner join product p
on p.model = l.model
where l.speed < ALL (select speed  from pc);

/* 
Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
*/  
select distinct p.maker, pri.price from product p
inner join printer pri on pri.model = p.model
where color = 'y' and price = (select min(price) from printer where color = 'y');

/* 
Для каждого производителя, имеющего модели в таблице Laptop, 
найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана.
*/  
Select maker, avg(screen) from product p
inner join laptop l 
on l.model = p.model
group by maker;

/* 
Найдите максимальную цену ПК, выпускаемых каждым производителем, 
у которого есть модели в таблице PC.
Вывести: maker, максимальная цена.
*/  
Select maker, max(price) from product pr
inner join pc on pc.model = pr.model
group by pr.maker;

/* 
Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК 
с такой же скоростью. Вывести: speed, средняя цена.
*/  
Select speed, avg(price) from pc
where speed > 600
group by speed;

/* 
Найдите производителей, которые производили бы как ПК
со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
Вывести: Maker
*/  
Select distinct maker from product pr
join pc on pr.model = pc.model
where pc.speed >= 750 and maker in 
(select distinct pr.maker from product pr
join laptop l on pr.model = l.model
where l.speed >= 750);

/* 
Перечислите номера моделей любых типов, имеющих самую высокую цену 
по всей имеющейся в базе данных продукции.
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
Найдите средний размер диска ПК каждого из тех производителей, которые выпускают 
и принтеры. Вывести: maker, средний размер HD.
*/  
Select maker, avg(pc.hd) from pc 
join product pr on pr.model = pc.model
where maker in (select maker from product where type = 'Printer')
group by maker;

/* 
Используя таблицу Product, определить количество производителей,
выпускающих по одной модели.
*/  
Select count(maker) from product
where maker in (select maker from product 
group by maker
having count(*) = 1);

/* 
В предположении, что приход и расход денег на каждом пункте приема фиксируется
не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос
с выходными данными (пункт, дата, приход, расход). 
Использовать таблицы Income_o и Outcome_o.
*/  
select i.point, i."date", i.inc, o."out" from Income_o i 
left join Outcome_o o on o."date" = i."date" and o.point = i.point
union
select o.point, o."date", i.inc, o."out" from Income_o i 
right join Outcome_o o on o."date" = i."date" and o.point = i.point;

/* 
В предположении, что приход и расход денег на каждом пункте приема фиксируется 
произвольное число раз (первичным ключом в таблицах является столбец code), 
требуется получить таблицу, в которой каждому пункту за каждую дату выполнения 
операций будет соответствовать одна строка.
Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта 
за день (inc). Отсутствующие значения считать неопределенными (NULL).
*/  
select point, date, SUM(sum_out), SUM(sum_inc)
from( select point, date, SUM(inc) as sum_inc, null as sum_out from Income Group by point, date
Union
select point, date, null as sum_inc, SUM(out) as sum_out from Outcome Group by point, date ) as t
group by point, date order by point;

/* 
Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.
*/  
select CLASS, COUNTRY from Classes 
where BORE > 15;

/* 
Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). 
Вывод: ship.
*/  
select ship from Outcomes 
where BATTLE = 'North Atlantic' and result = 'sunk';

/* 
По Вашингтонскому международному договору от начала 1922 г. запрещалось строить 
линейные корабли водоизмещением более 35 тыс.тонн. Укажите корабли, 
нарушившие этот договор (учитывать только корабли c известным годом спуска на воду). 
Вывести названия кораблей.
*/  
Select distinct name from Classes c
join ships s on s.class = c.class
where DISPLACEMENT>35000 and LAUNCHED >= 1922 and type = 'bb';

/* 
В таблице Product найти модели, которые состоят только из цифр или только из 
латинских букв (A-Z, без учета регистра). Вывод: номер модели, тип модели.
*/  
SELECT model, type 
FROM product 
WHERE model NOT LIKE '%[^0-9]%' OR model NOT LIKE '%[^a-z]%'; 

/* 
Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes).
*/  
Select name from ships where class = name
union
select ship as name from classes,outcomes where classes.class = outcomes.ship;

/* 
Найдите классы, в которые входит только один корабль из базы данных 
(учесть также корабли в Outcomes).
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
Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') 
и имевшие когда-либо классы крейсеров ('bc').
*/  
SELECT country
FROM classes
GROUP BY country
HAVING COUNT(DISTINCT type) = 2;

/* 
Найти производителей, которые выпускают более одной модели, при этом все выпускаемые 
производителем модели являются продуктами одного типа. Вывести: maker, type
*/  
SELECT maker, MAX(type)
FROM product
GROUP BY maker
HAVING COUNT(DISTINCT type) = 1 AND COUNT(model) > 1;

/* 
Для каждого производителя, у которого присутствуют модели хотя бы в одной из таблиц PC, 
Laptop или Printer, определить максимальную цену на его продукцию. 
Вывод: имя производителя, если среди цен на продукцию данного производителя 
присутствует NULL, то выводить для этого производителя NULL, иначе максимальную цену.
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
Найдите названия кораблей, потопленных в сражениях, и название сражения, 
в котором они были потоплены.
*/  
Select ship, battle from Outcomes 
where result = 'sunk';

/* 
Укажите сражения, которые произошли в годы, не совпадающие ни с одним 
из годов спуска кораблей на воду.
*/  
select NAME from BATTLES t
where to_char("date", 'YYYY') not in 
(select launched from ships 
where launched is not null);

/* 
Найдите названия всех кораблей в базе данных, начинающихся с буквы R.
*/  
select name from SHIPS t
where name like 'R%'
UNION
SELECT Ship From Outcomes
where Ship LIKE 'R%';

/* 
Найдите названия всех кораблей в базе данных, состоящие из трех и более слов 
(например, King George V). Считать, что слова в названиях разделяются единичными 
пробелами, и нет концевых пробелов.
*/  
select name from SHIPS t
where name like '% % %'
UNION
SELECT Ship From Outcomes
where Ship LIKE '% % %';

/* 
Для каждого корабля, участвовавшего в сражении при Гвадалканале (Guadalcanal), 
вывести название, водоизмещение и число орудий.
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
Определить страны, которые потеряли в сражениях все свои корабли.
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
Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении.
*/  
SELECT cl.class
FROM Classes cl
LEFT JOIN Ships s ON s.class = cl.class
WHERE cl.class IN (SELECT ship FROM Outcomes WHERE result = 'sunk') OR
s.name IN (SELECT ship FROM Outcomes WHERE result = 'sunk')
GROUP BY cl.class;

/* 
Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes).
*/  
select name from Ships s
join classes c on s.class = c.class
where bore = 16
union
select class from Outcomes o
join classes c on o.ship= c.class
where bore = 16;

/* 
Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
*/  
select battle from Outcomes o
join ships s on s.name = o.ship
where class = 'Kongo';

/* 
Найдите названия кораблей, имеющих наибольшее число орудий среди всех имеющихся 
кораблей такого же водоизмещения (учесть корабли из таблицы Outcomes).
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
Определить названия всех кораблей из таблицы Ships, которые могут быть линейным 
японским кораблем, имеющим число главных орудий не менее девяти, калибр орудий 
менее 19 дюймов и водоизмещение не более 65 тыс.тонн
*/  
select name from ships s
join Classes c on c.class = s.class 
where (type = 'bb' or type is null) 
and (COUNTRY = 'Japan' or COUNTRY is null) 
and (NUMGUNS > 8 or NUMGUNS is null) 
and (BORE < 19 or BORE is null) 
and (DISPLACEMENT <=65000 or DISPLACEMENT is null);

/* 
Определите среднее число орудий для классов линейных кораблей.
Получить результат с точностью до 2-х десятичных знаков.
*/  
Select round(avg(numGuns), 2) from Classes 
where type = 'bb';

/* 
С точностью до 2-х десятичных знаков определите среднее число орудий 
всех линейных кораблей (учесть корабли из таблицы Outcomes).
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
Для каждого класса определите год, когда был спущен на воду первый корабль 
этого класса. Если год спуска на воду головного корабля неизвестен, определите 
минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
*/  
select c.class,  min(launched) from ships s
right join Classes c on c.class = s.class
group by c.class ;

/* 
Для каждого класса определите число кораблей этого класса, потопленных в сражениях. 
Вывести: класс и число потопленных кораблей.
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

