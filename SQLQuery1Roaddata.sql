use Roadaccident

select *
from Roadaccidentdata

--CHECKING if column data is distinct
select distinct(accident_index)
from Roadaccidentdata

select distinct(Urban_or_Rural_Area)
from Roadaccidentdata



select distinct(Road_Surface_Conditions)
from Roadaccidentdata

update RoadAccidentData set Road_Surface_Conditions = 'WET' 
where Road_Surface_Conditions in ('flood over 3cm. deep', 'wet or damp')

update RoadAccidentData set Road_Surface_Conditions = 'Snow/ice' 
where Road_Surface_Conditions in ('frost or ice', 'snow')


select distinct(Vehicle_Type)
from Roadaccidentdata

select distinct(Accident_Severity), count(Accident_Severity), Day_of_Week
from Roadaccidentdata
group by Accident_Severity, Day_of_Week
having Accident_Severity




select distinct(Light_Conditions)
from Roadaccidentdata





--checking number of casualties by accident_severity

select sum(Number_of_Casualties) as Fatal_casualties
from roadaccidentdata
where Accident_Severity = 'Fatal'

select sum(Number_of_Casualties) as Slight_casualties
from roadaccidentdata
where Accident_Severity = 'Slight'


select sum(Number_of_Casualties) as Serious_casualties
from roadaccidentdata
where Accident_Severity = 'Serious'


update Roadaccidentdata set Vehicle_Type = 'pedal'
where Vehicle_Type = 'pedal cycle'


--combining similar data together in vehicle type data 

--CAR
update Roadaccidentdata set Vehicle_Type  = 'Car'
where Vehicle_Type like '%car%'

--BIKE   
update Roadaccidentdata set Vehicle_Type  = 'Bike'
where Vehicle_Type like '%cycle%'

--BUS
update Roadaccidentdata set Vehicle_Type  = 'Bus'
where Vehicle_Type like '%bus%'

--Van
update Roadaccidentdata set Vehicle_Type  = 'Van'
where Vehicle_Type like '%goods%'

-- others
update Roadaccidentdata set Vehicle_Type  = 'Others'
where Vehicle_Type in ('pedal', 'ridden horse', 'other vehicle');

--combining data together in light condition 
update Roadaccidentdata set Light_Conditions  = 'Darkness'
where Light_Conditions like '%darkness%'

--combining data together in road surface condition 





select distinct(Road_Surface_Conditions)
from Roadaccidentdata


--cleaning data, removing unwanted columns 
alter table  Roadaccidentdata drop column junction_control, junction_detail, latitude, local_authority_district;
alter table  Roadaccidentdata drop column longitude, police_force


--finding total number of casualties

select sum(Number_of_Casualties) as TOTAL_CASUALTIES
from Roadaccidentdata

-- renaming fetal in accident_severity to fatal 
update Roadaccidentdata set Accident_Severity = 'Fatal'
where Accident_Severity = 'Fetal'
select distinct(Accident_Severity )
from Roadaccidentdata



--getting KPIs vehicle type

--TOTAL casualties by car 
select sum(Number_of_Casualties) as 'CAR'
from roadaccidentdata
where Vehicle_Type = 'CAR'

use Roadaccident

with cte_road as (
select accident_severity, count(number_of_casualties) 
from RoadAccidentData
group by accident_severity, number_of_casualties
order by Number_of_Casualties desc



--Total casualties by BUS
select sum(Number_of_Casualties) as 'BUS'
from roadaccidentdata
where Vehicle_Type = 'bus'

--Total casualties by BIKE
select sum(Number_of_Casualties) as 'Bike'
from roadaccidentdata
where Vehicle_Type = 'Bike'


--Total casualties by VAN
select sum(Number_of_Casualties) as 'Van'
from roadaccidentdata
where Vehicle_Type = 'Van'

--Total casualties by agricultural vehicle
select sum(Number_of_Casualties) as 'Agricultural Vehicle'
from roadaccidentdata
where Vehicle_Type = 'agricultural vehicle'

--Total casualties by others
select sum(Number_of_Casualties) as 'Others'
from roadaccidentdata
where Vehicle_Type = 'others'


--SUM OF NUMBER OF CASUALTIES FOR URBAN AND RURAL

-- URBAN
select sum(Number_of_Casualties) AS 'TOTAL CASUALTIES IN URBAN'
from roadaccidentdata
where  Urban_or_Rural_Area = 'URBAN';

-- RURAL
select sum(Number_of_Casualties) AS 'TOTAL CASUALTIES IN RURAL'
from roadaccidentdata
where  Urban_or_Rural_Area = 'RURAL';



-- SUM of casualties for light conditions

--Daylight
select sum(Number_of_Casualties) AS 'TOTAL CASUALTIES IN Daylight'
from roadaccidentdata
where Light_Conditions = 'daylight';


--Darkness
select sum(Number_of_Casualties) AS 'TOTAL CASUALTIES IN Darkness'
from roadaccidentdata
where Light_Conditions = 'Darkness';









create database Agricdata
use Agricdata
--QUESTION 1 
select State_Code,State_Name,RICE_AREA_1000_ha,RICE_PRODUCTION_1000_tons
from districtdata
WHERE State_Name = 'GUJARAT'

--QUESTION 2
select State_Name, sum(RICE_PRODUCTION_1000_tons)
from districtdata
where year = '2006'
group by State_Name
order by State_Name 

--question 3
select top (5) State_Name, sum(SUGARCANE_PRODUCTION_1000_tons) as total_sugar_prod
from districtdata
where year = '2006' 
group by State_Name
order by total_sugar_prod desc


--question 4
select State_Name, avg(RICE_YIELD_Kg_per_ha) as AVG_rice_yield
from districtdata
where year = '2006' 
group by State_Name


--Question 5
select top (1) state_code, sum(FRUITS_AND_VEGETABLES_AREA_1000_ha)
from districtdata
where year = '2006'
group by state_code
order by sum(FRUITS_AND_VEGETABLES_AREA_1000_ha) desc

select *
from districtdata


select state_code, state_name
from states




















