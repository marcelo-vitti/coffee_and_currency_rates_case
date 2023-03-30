SELECT
  "yearly"                    AS analysis_interval,
  strftime("%Y", coffee.Date) AS activity_date,
  AVG(Volume)                 AS average_of_negotiated_coffee

FROM coffee

GROUP BY strftime("%Y", coffee.Date)

UNION ALL

SELECT
  "monthly"                      AS analysis_interval,
  strftime("%Y-%m", coffee.Date) AS activity_date,
  AVG(Volume)                    AS average_of_negotiated_coffee

FROM coffee

GROUP BY strftime("%Y-%m", coffee.Date)
