-- --select *
----from covidDealths
----ORDER BY 3,4

----select *
----from covidVaccination
----ORDER BY 3,4


--SELECT location, date, total_cases , new_cases, total_deaths, population
--from covidDealths
--order by  1,2 


----looking at total_cases vs total_dealth
SELECT location, date, total_cases,total_deaths, (CAST(total_deaths AS FLOAT) / total_cases) * 100 as DealthPercentag
from covidDealths
order by  1,2 



----likelood of dying if you contact covid in your country
SELECT location, date, total_cases,total_deaths, (CAST(total_deaths AS FLOAT) / total_cases) * 100 as DealthPercentage
from covidDealths
where location like '%states%'
order by  1,2 



----looking at total cases vs population
SELECT location, date, total_cases, population
from covidDealths
order by  1, 2


----percentage of population that got covid
SELECT location, date, total_cases, population, (total_cases / cast(population as float))  as PercentPopInfected
from covidDealths
order by  1, 2



----countries with highest infection rate compared to population

select location, population, max( total_cases )  as HighestInfectionCount, max (total_cases/ cast( population as float))*100 as
PercentPopulationInfected
from covidDealths
group by location, population
order by PercentPopulationInfected desc


----showing countries with highest dealth count per population 

select location, max(cast(total_deaths as int)) as TotalDaealthCount
from covidDealths
where continent is not null
group by location
order by  TotalDaealthCount desc


-----grouping by continent and total dealth count

select continent, max(cast(total_deaths as int)) as TotalDaealthCount
from covidDealths
where continent is not null
group by continent
order by  TotalDaealthCount desc



---- Global count 

select sum(new_cases) as TotalCases , sum(cast(new_deaths as int)) as TotalDeath, sum(cast(new_deaths as float))/sum(new_cases)*100
as DealthPercentage
from covidDealths
where continent is not null

--select *
from covidDealths cd
JOIN covidVaccination cv
ON cd.location = cv.location
	and cd.date = cv.date

--	--looking at Total Population vs Vaccination 
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(convert(float,cv.new_vaccinations )) over (partition by cd.location
order by cd.location, cd.date) as RollingPeopleVaccinated
from covidDealths cd
JOIN covidVaccination cv
ON cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null
order by 2,3




----using CTE

with Popvsvac (continent, location,date,population,new_vaccinations, RollingPeopleVaccinated)
as
(
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(convert(float,cv.new_vaccinations )) over (partition by cd.location
order by cd.location, cd.date) as RollingPeopleVaccinated
from covidDealths cd
JOIN covidVaccination cv
ON cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null
)
--order by 2,3
select *, (RollingPeopleVaccinated/population)*100
from Popvsvac




-----using temp table
drop table if exists  #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(continent nvarchar(50), location varchar(50), Date datetime, population numeric, 
new_vaccinations numeric, 
RollingPeopleVaccinated numeric)

insert into #PercentPopulationVaccinated

select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(convert(float,cv.new_vaccinations )) over (partition by cd.location
order by cd.location, cd.date) as RollingPeopleVaccinated
from covidDealths cd
JOIN covidVaccination cv
ON cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null

select *, (RollingPeopleVaccinated/population)*100
from #PercentPopulationVaccinated



--creating view to store data for later visualizations

create view PercentPopulationVaccinated as
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(convert(float,cv.new_vaccinations )) over (partition by cd.location
order by cd.location, cd.date) as RollingPeopleVaccinated
from covidDealths cd
JOIN covidVaccination cv
ON cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null


--create view TotalPopulationVsVaccination as 

select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, sum(convert(float,cv.new_vaccinations )) over (partition by cd.location
order by cd.location, cd.date) as RollingPeopleVaccinated
from covidDealths cd
JOIN covidVaccination cv
ON cd.location = cv.location
	and cd.date = cv.date
where cd.continent is not null




--create view Globalcount as
select sum(new_cases) as TotalCases , sum(cast(new_deaths as int)) as TotalDeath, sum(cast(new_deaths as float))/sum(new_cases)*100
as DealthPercentage
from covidDealths
where continent is not null

