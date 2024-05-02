-- EDA - Covid Deaths Table

-- Basic columns
SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM covid_deaths
WHERE continent IS NOT NULL AND total_cases IS NOT NULL
ORDER BY 1, 2

-- Total Cases vs Total Deaths
-- Shows the likelihood of dying if you contract covid in Canada
SELECT location, date, total_cases, total_deaths, 
ROUND((CAST(total_deaths AS NUMERIC)/total_cases)*100, 2)  AS death_percentage
FROM covid_deaths
WHERE location = 'Canada'
ORDER BY 1, 2

-- Total Cases vs Population
-- Shows what percentage of population got Covid
SELECT location, date, population, total_cases, 
ROUND((CAST(total_cases AS NUMERIC)/population)*100, 2)  AS percent_population_infected
FROM covid_deaths
WHERE location = 'Canada' 
ORDER BY 1, 2

-- Countries with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS highest_infection_count, 
MAX(ROUND((CAST(total_cases AS NUMERIC)/population)*100, 2))  AS percent_population_infected
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY 4 DESC

-- Countries with highest death count per population
SELECT location, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
HAVING MAX(total_deaths) IS NOT NULL
ORDER BY 2 DESC

-- Death count by continent
SELECT continent, MAX(total_deaths) AS total_death_count
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC

-- Global Numbers

