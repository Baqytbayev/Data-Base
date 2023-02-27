-- 1 Сколько и каких товаров доставлено на указанный склад за указанный период дат? 
-- По каждому наименованию указывать общее количество поставок этого товара на 
-- указанный склад (склад определяется по коду). Результат представить в виде 
-- таблицы с двумя полями – наименование товара, количество. 
-- Каждое наименование должно быть в таблице результатов не более 
-- одного раза. Результаты отсортировать по наименованию товара.
select
products.name,
sum(supplies.quantity)
from products

inner join supplies ON products.id = supplies.product_id
inner join stock ON supplies.stock_id = stock.id
where stock.id = 1
and supplies.date_arrival between '2016-01-01' and '2019-04-13'
group by products.name,
supplies.quantity
order by products.name

-- 2 Сколько и каких товаров забрали (списали) с указанного склада за указанный период дат?
-- По каждому наименованию указывать общее количество списания этого товара с указанного склада 
-- (склад определяется по коду). Результат представить в виде таблицы с двумя полями – наименование товара,
-- количество. Каждое наименование должно быть в таблице результатов не более одного раза. 
-- Результаты отсортировать по наименованию товара.

select
products.name as name,
sum(supplies.quantity) as quantity
from products

inner join supplies ON products.id = supplies.product_id
inner join stock ON supplies.stock_id = stock.id
where stock.id = 4
and supplies.date_arrival between '2016-01-01' and '2019-04-13'
and supplies.operation_type = 'выдан'
group by products.name,
supplies.quantity
order by products.name


-- 3 Какое количество товаров и каких категорий доставлено на указанный склад за указанный период дат.
--  Склад определяется по коду. Результат представить в виде таблицы с двумя полями – категория,
--   количество. Каждая категория должна 
-- быть в таблице результатов не более одного раза. Результаты отсортировать по наименованию категории.

select distinct
categories.type,
sum(supplies.quantity)

from products

inner join supplies ON products.id = supplies.product_id
inner join stock ON supplies.stock_id = stock.id
inner join categories on categories.id = products.category_id
where stock.id = 3
and supplies.date_arrival between '2016-01-01' and '2016-04-13'
group by categories.type
order by categories.type desc

-- 4 Какое количество и каких брендов товаров доставлено на указанный склад 
-- за указанный период дат? Склад определяется по коду. 
-- Товары без бренда выводить отдельной строкой. Результат 
-- представить в виде таблицы с двумя полями – бренд, количество. 
-- Каждый бренд должен быть в таблице результатов не более одного раза. 
-- Результаты отсортировать по наименованию бренда.

select distinct
brands.name,
sum(supplies.quantity)

from products

inner join supplies ON products.id = supplies.product_id
inner join stock ON supplies.stock_id = stock.id
inner join brands on brands.id = products.category_id
where stock.id = 1
and supplies.date_arrival between '2016-01-01' and '2016-04-13'
group by brands.name
order by brands.name desc


-- 5 Количественные остатки товаров на выбранном складе на указанную дату. Склад определяется по коду.
--  Результат представить в виде таблицы с двумя полями – наименование товара, количество. 
--  Каждое наименование должно быть в таблице результатов не более одного раза. Результаты отсортировать 
--  по наименованию товара.


select
products.name,
sum(supplies.quantity)
from products
left join supplies ON products.id = supplies.product_id
left join stock ON supplies.stock_id = stock.id
where stock.id = 2
and supplies.date_arrival = '2017-09-17'
group by products.name,
supplies.quantity
order by products.name desc


--  6 Сколько и каких товаров поставил на все склады указанный контрагент за указанный период дат? 
--  Контрагент определяется по коду. Результат представить в виде таблицы с двумя полями – наименование 
--  товара, количество. Каждое наименование должно быть в таблице результатов не более одного раза. Результаты 
--  отсортировать по наименованию товара.


select distinct
products.name,
sum(supplies.quantity)

from products

inner join supplies ON products.id = supplies.product_id
inner join counterparty ON supplies.counterparty_id = counterparty.id
where counterparty.id = 3
and supplies.operation_type = 'пришел'
and supplies.date_arrival between '2016-01-01' and '2018-09-13'
group by products.name,
supplies.quantity
order by products.name desc




--  7 Сколько и каких товаров поставил указанный контрагент на выбранный склад за указанный период дат? 
--  Контрагент определяется по коду. Результат представить в виде таблицы с двумя полями – наименование товара, 
--  количество. Каждое наименование должно быть в таблице результатов не более одного раза. Результаты отсортировать 
--  по наименованию товара.


select distinct
products.name,
sum(supplies.quantity)

from products

inner join supplies ON products.id = supplies.product_id
inner join counterparty ON supplies.counterparty_id = counterparty.id
inner join stock ON stock.id = supplies.stock_id
where counterparty.id = 3
and stock.id = 2
and supplies.operation_type = 'пришел'
and supplies.date_arrival between '2016-01-01' and '2018-09-13'
group by products.name,
supplies.quantity
order by products.name desc



-- 8 Сколько и каких товаров выдано указанному контрагенту с выбранного склада за указанный период дат? 
-- Результат представить в виде таблицы с двумя полями – наименование товара, количество. 
-- Каждое наименование должно быть в таблице результатов не более одного раза. Результаты отсортировать 
-- по наименованию товара.


select distinct
products.name,
sum(supplies.quantity)

from products

inner join supplies ON products.id = supplies.product_id
inner join counterparty ON supplies.counterparty_id = counterparty.id
inner join stock ON stock.id = supplies.stock_id
where counterparty.id = 1
and stock.id = 3
and supplies.operation_type = 'выдан'
and supplies.date_arrival between '2016-01-01' and '2018-09-13'
group by products.name,
supplies.quantity
order by products.name desc

--  9 Какие контрагенты и в каком количестве поставили указанный товар на все 
--  склады за указанный период дат? Результат представить в виде таблицы с двумя полями – 
--  название контрагента, количество. Каждое название контрагента должно быть в таблице результатов 
--  не более одного раза. Результаты отсортировать по количеству поставок в убывающем порядке.

select distinct
counterparty.name,
sum(supplies.quantity)

from supplies

inner join products ON products.id = supplies.product_id
inner join counterparty ON supplies.counterparty_id = counterparty.id
inner join stock ON stock.id = supplies.stock_id
where products.id = 47
and supplies.operation_type = 'пришел'
and supplies.date_arrival between '2016-01-01' and '2019-09-13'
group by counterparty.name,
supplies.quantity
order by counterparty.name desc


-- 10 Каким контрагентам и в каком количестве был выдан указанный товар со всех складов 
-- за указанный период дат? Результат представить в виде таблицы с двумя полями – название контрагента, 
-- количество. Каждое название контрагента должно быть в таблице результатов не более одного раза. 
-- Результаты отсортировать по количеству поставок в убывающем порядке.



select distinct
counterparty.name,
sum(supplies.quantity)

from supplies

inner join products ON products.id = supplies.product_id
inner join counterparty ON supplies.counterparty_id = counterparty.id
inner join stock ON stock.id = supplies.stock_id
where products.id = 33
and supplies.operation_type = 'выдан'
and supplies.date_arrival between '2016-01-01' and '2019-09-13'
group by counterparty.name,
supplies.quantity
order by counterparty.name desc



-- 11 Сколько и каких товаров поступило на указанный склад с других складов за указанный период дат? 
-- Результат представить в виде таблицы с двумя полями – наименование товара, количество. 
-- Каждое наименование должно быть в таблице результатов не более одного раза. Результат отсортировать 
-- по наименованию товара.


select distinct
products.name,
sum(moving.quantity)

from products
inner join moving ON products.id = moving.stock_id_give
inner join stock ON moving.stock_id_give = stock.id

where  stock.id = 3
and moving.date_give between '2016-01-01' and '2022-09-13'
group by products.name,
moving.quantity
order by products.name desc


-- 12 Сколько и каких товаров передано с указанного склада на другие склады за указанный период дат? 
-- Результат представить в виде таблицы с двумя полями – наименование товара, количество. 
-- Каждое наименование должно быть в таблице результатов не более одного раза. Результат отсортировать 
-- по наименованию товара




select distinct
products.name,
sum(moving.quantity)

from products
inner join moving ON products.id = moving.stock_id_give
inner join stock ON moving.stock_id_take = stock.id

where  stock.id = 2
and moving.date_give between '2016-01-01' and '2022-09-13'
group by products.name,
moving.quantity
order by products.name desc








