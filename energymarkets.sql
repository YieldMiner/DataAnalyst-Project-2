#SQL OPERATIONS PERFORMED, MADE INTO VIEWS THEN PORTED INTO POWERBI TO BE UTILIZED FOR DATA VISUALIZATIONS/CONCLUSIONS
SELECT * FROM public.energymarkets

CREATE VIEW value_opportunities AS
SELECT company, sector, peratio, ptbratio, dividendyield,
       CASE 
           WHEN ptbratio < 1 THEN 'Undervalued'
           WHEN ptbratio < 1.5 THEN 'Fair Value' 
           ELSE 'Overvalued' 
       END as value_classification,
       NTILE(4) OVER (ORDER BY peratio) as pe_quartile
FROM energymarkets
WHERE peratio IS NOT NULL AND ptbratio IS NOT NULL;

CREATE VIEW risk_analysis AS
SELECT company, sector, beta, marketcap,
       CASE 
           WHEN beta < 0.8 THEN 'Low Risk'
           WHEN beta < 1.2 THEN 'Market Risk'
           ELSE 'High Risk'
       END as risk_tier,
       CASE 
           WHEN marketcap > 50000000000 THEN 'Large Cap'
           WHEN marketcap > 10000000000 THEN 'Mid Cap'
           ELSE 'Small Cap'
       END as market_cap_tier
FROM energymarkets
WHERE beta IS NOT NULL;


CREATE VIEW dividend_analysis AS
SELECT company, sector, dividendyield, peratio,
       RANK() OVER (ORDER BY dividendyield DESC) as dividend_rank,
       AVG(dividendyield) OVER (PARTITION BY sector) as sector_avg_yield,
       CASE 
           WHEN dividendyield > 0.05 THEN 'High Yield'
           WHEN dividendyield > 0.02 THEN 'Moderate Yield'
           ELSE 'Low Yield'
       END as yield_category
FROM energymarkets
WHERE dividendyield IS NOT NULL;


CREATE VIEW financial_health AS
SELECT company, sector, peratio, ptbratio, beta,
       (peratio * ptbratio) as peg_estimate,
       CASE 
           WHEN beta < 1 AND peratio < 15 THEN 'Conservative'
           WHEN beta > 1.5 AND peratio > 20 THEN 'Aggressive'
           ELSE 'Moderate'
       END as investment_style
FROM energymarkets
WHERE peratio IS NOT NULL;

