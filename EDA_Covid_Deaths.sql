/*
Covid 19 Data Exploration 

skills Used: Joins, Window Functions, Aggregate Functions, Creating Views, Converting Data Types

*/


SELECT * 
FROM portfolioproject.covid_deaths
WHERE continent <> ''
ORDER BY location;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths
WHERE continent <> ''
ORDER BY location;

-- Total Cases vs Total Deaths in terms of percentage
-- Chances of dying from getting covid in India

SELECT location, date, total_cases, total_deaths, ((total_deaths/total_cases) * 100) as DeathPercentage
FROM covid_deaths
WHERE location = 'India';

-- Total Cases vs Total Population
-- Shows what percentage of population got covid

SELECT location, date, total_cases, population, ((total_cases/population) * 100) as Percentage_of_Population_Infected
FROM covid_deaths
WHERE location = 'India';

-- Looking at Countries which have the highest infection rate compared to their population

SELECT location, population, max(total_cases) AS Highest_Infection_Count, max(total_cases/population) * 100 as max_infectionrate
FROM covid_deaths
WHERE continent <> ''
GROUP BY population, location
ORDER BY max_infectionrate DESC;

-- Countries with the highest death count

SELECT location, MAX(cast(total_deaths as float)) AS Total_Death_Count
FROM covid_deaths
WHERE continent <> ''
GROUP BY location
ORDER BY Total_Death_Count DESC;

-- Looking at contients with the highest death count

SELECT location, MAX(cast(total_deaths as float)) AS Total_Death_Count
FROM covid_deaths
WHERE continent = ''
GROUP BY location
ORDER BY Total_Death_Count DESC;

-- Global Numbers

SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths AS FLOAT)) as total_deaths, (sum(cast(new_deaths as float))/sum(new_cases)) * 100 as DeathPercentage
FROM covid_deaths
WHERE continent <> ''
GROUP BY date;

-- Total population died until now

SELECT SUM(new_cases) as total_cases, SUM(convert(new_deaths, float)) as total_deaths, (sum(cast(new_deaths as float))/sum(new_cases)) * 100 as DeathPercentage
FROM covid_deaths
WHERE continent <> '';

-- Create View To Visualise later

Create View MaxInfectionRate as
SELECT location, population, max(total_cases) AS Highest_Infection_Count, max(total_cases/population) * 100 as max_infectionrate
FROM covid_deaths
WHERE continent <> ''
GROUP BY population, location
ORDER BY max_infectionrate DESC;
