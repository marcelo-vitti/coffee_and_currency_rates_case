-- If we have a currency_rates table with all currencies in just one line we wouldn't need to do this treatment, it would be easier.
-- I am doing an inner join to bring only data from coffee in dates that we have currency data.

SELECT
  coffee.Date AS activity_date,
  coffee.High AS higher_coffee_volume,
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
    END) AS eur_usd_rate
  
FROM coffee

  INNER JOIN currency_rates ON coffee.Date = currency_rates.activity_date

GROUP BY coffee.Date, coffee.High
