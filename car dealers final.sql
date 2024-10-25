--highest and lowest dealers' sales
select dealers.DealerName,sum(Sales.Quantity)as totalsales
from sales join Dealers on sales.DealerID=Dealers.DealerID   
group by  dealers.DealerName
order by sum(Sales.Quantity) desc

--regional dealers' perfomance
select dealers.DealerName,Dealers.Country,dealers.city ,sum(Sales.Quantity) as totalsales
from sales join Dealers on sales.DealerID=Dealers.DealerID   
group by  dealers.DealerName,Dealers.Country,dealers.city 
order by sum(Sales.Quantity) desc

--car model most and least sold
select models.Brand,models.Model,sum(Sales.Quantity) as totalsales
from sales join Models on sales.ModelID =models.ModelID
group by models.Brand,models.Model
order by sum(Sales.Quantity) desc

--monthly sales
select  convert (char(4),date ,100)+convert (char(4),date,120)
       as monthyear,sum (Quantity) as total,
	          cast (convert (char(4),date,120)as int) as year ,datepart(m,date) AS month
        from sales
group by   convert (char(4),date ,100)+convert (char(4),date,120),cast (convert (char(4),date,120)as int) ,datepart(m,date) 
order by year ,month

--monthly brand sales 
select models.Brand,models.Model,  convert (char(4),date ,100)+convert (char(4),date,120)
       as monthyear, sum(Sales.Quantity) as totalsales
from sales join Models on sales.ModelID =models.ModelID
group by models.Brand,models.Model,  convert (char(4),date ,100)+convert (char(4),date,120)
order by Model,totalsales desc 

--brand sales in terms of their prizes
select models.Brand,models.Model,models.[Price (USD)],sum (sales.Quantity) as totalsales
from Models join sales on models.ModelID=sales.ModelID
group by models.Brand,models.Model,models.[Price (USD)]
order by models.[Price (USD)] desc, totalsales desc

--brand sales by location																																																																																																																	 
select dealers.Country,Dealers.City,Models.Brand,sum(sales.Quantity)as totalsales
from sales join dealers on sales.DealerID=Dealers.DealerID 
join Models on sales.ModelID=Models.ModelID
group by dealers.Country,Dealers.City,Models.Brand
order by dealers.Country,Dealers.City,totalsales desc
