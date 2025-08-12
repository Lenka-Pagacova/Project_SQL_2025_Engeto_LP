# Project_SQL_2025_Engeto_LP

## Úvod
  Na našem analytickém oddělení jsme dostali vydefinované otázky, na které jsme se měli pokusit odpovědě, minimálně připravit datové podklady, ze kterých se bude moct vycházet na konferenci. K dispozici máme primární a dodatečné tabulky a také Číselníky ČR.
  Při tvorbě primární tabulky se vycházelo z primárních tabulek. Během tvorby bylo zjištěno, že u některých záznamů chybí industry_index a industry_name (jedná se o hodnoty, které končí po industry_index = S. Různé tabulky byly spojovány na základě primárního a sekundárního klíče dle diagramu (viz SQL skript).
  Při tvorbě sekundární tabulky se vycházelo z dodatečných tabulek Country a Economies. Někde chyběla data o GINI Indexu, to samé u HDP (ale Gini index chybí více). Gibraltar a Faroe Islands byly vyfiltrovány z tabulky, jelikož se nejedná o samostatné státy.
  
## Otázka č. 1 - Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
  Na základě výsledků analýzy nelze říct, že by ve všech odvětvích mzdy rostly/klesaly, protože se **objevují výkyvy cen ve všech odvětvích v průběhu let 2006-2018**. Po vyfiltrování odvětví, kde mzda pouze klesala oproti předchozímu roku jde skoro u všech odvětvích vidět spojitost, že mzda nejvíce klesala v období od 2009-2013. V tomto období si ČR procházela ČR recesí (světová ekonomická krize od roku 2008), což mělo za následek celkový pokles poptávky (u některých odvětví viz SQL script) --> projeví se snížením zisku firem --> méně peněz na zaplacení zaměstnanců (případně navýšení mzdy). Naopak v některých odvětvích mzdy každoročně rostou (Zpracovatelský průmysl, Doprava a skladování, Administrativní a podpůrné činnosti, Zdravotní a sociální péče, Ostatní činnosti).

## Otázka č. 2 - Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
  Při průměrné ceně produktu (za kilo / litr) a průměrnému platu je možné si zakoupit **1 257 kg chleba a 1 404 litrů mléka** za první sledované období (rok 2006).
  Za poslední sledované období (rok 2018) je možné si zakoupit **1 317 kg chleba a 1 611 litrů mléka** při průměrných cenách a platech

## Otázka č. 3 - Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuálně meziroční nárůst)?
  	Dle výsledků nejpomaleji zdražuje kategorie: **Jakostní víno bílé, ALE** tato jediná kategorie má začátek šetření až od roku **2015-2018**, tudíž se bralo zdražování pouze za 3 roky oproti ostatním kteří mají měření od 2006-2018.
  	Správně tedy dává smysl, že **nejpomaleji zdražují Banány žluté (naopak nejvíce zlevňuje svoji cenu Cukr krystalový – je u něj meziroční pokles)**, nejvíce zdražují papriky hned po máslu

## Otázka č. 4 - Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
  Ne takový rok neexistuje, z analýzy vyplývá, že nastala situace, kdy **nárůst cen potravin NEBYL vyšší než nárůst mezd**. Nejvyšší rozdíl mezi mzdou a cenou potravin, kdy cena potravin byla výrazně vyšší nastala v roce 2012, kdy byla cena potravin vyšší o 4,36 %.

## Otázka č. 5 - Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mezd ve stejném nebo následujícím roce výraznějším růstem?
  
  
