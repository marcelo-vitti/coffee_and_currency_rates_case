WITH coffee_and_currency_base AS (

  SELECT
    strftime("%Y", coffee.Date) AS activity_year,
    coffee.Date,
    coffee.Close,  
    AVG(
    CASE
      WHEN currency_rates.currency = "USDBRL" THEN currency_rates.rate
      ELSE NULL
    END) AS brl_usd_rate,
    AVG(
      CASE
        WHEN currency_rates.currency = "USDCLP" THEN currency_rates.rate
        ELSE NULL
      END) AS clp_usd_rate,
    AVG(
      CASE
        WHEN currency_rates.currency = "USDEUR" THEN currency_rates.rate
        ELSE NULL
      END) AS eur_usd_rate,
    ROW_NUMBER() OVER (
      PARTITION BY strftime("%Y", coffee.Date) 
      ORDER BY currency_rates.activity_date DESC
    ) AS row_number_desc

  FROM coffee

    LEFT JOIN currency_rates ON coffee.Date = currency_rates.activity_date

  GROUP BY activity_year, Date, Close

)

SELECT 
  activity_year,
  brl_usd_rate,
  clp_usd_rate,
  eur_usd_rate,
  SUM(Close) AS total_negotiated_coffee

FROM coffee_and_currency_base

WHERE row_number_desc = 1 -- Selecting only the last rate for that year

GROUP BY activity_year
