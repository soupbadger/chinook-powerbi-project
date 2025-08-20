#This project uses SQL and Power BI to analyze global revenue from the **Chinook sample database**

##SQL

**Filtering & cleaning**  
   - Excluded non-music media (e.g., videos)  
   - Removed non-music genres

**Aggregating revenue**  
   - Total revenue calculated per country, city, genre, artist, and album

**SQL Query**  

The following query organizes and filters data for Power BI import

```sql
SELECT
  i.BillingCountry,
  i.BillingCity,
  g.Name AS Genre,
  art.Name AS Artist,
  alb.Title AS AlbumTitle,
  SUM(t.UnitPrice * il.Quantity) AS TotalRevenue
FROM
  track t
  JOIN invoiceline il ON t.TrackId = il.TrackId
  JOIN invoice i ON il.InvoiceId = i.InvoiceId
  JOIN mediatype m ON t.MediaTypeId = m.MediaTypeID
  JOIN album alb ON t.AlbumId = alb.AlbumId
  JOIN artist art ON art.ArtistId = alb.ArtistId
  JOIN genre g ON t.GenreId = g.GenreId
  -- Exclude video files (MediaTypeId = 3) and non-music genres (GenreId 18-23)
WHERE
  t.MediaTypeId != 3
  AND g.GenreId NOT BETWEEN 18 AND 23
GROUP BY
  i.BillingCountry,
  i.BillingCity,
  g.Name,
  art.Name,
  alb.Title
ORDER BY
  i.BillingCountry,
  g.Name;
```
##Power BI

### Total Revenue by Country
![Country Revenue Map](images/country_revenue.png)
*Clicking a country filters the data to show genre revenue within that country*
*Drillthrough goes to the City Revenue Map*

### Total Revenue by City
![City Revenue Map](images/city_revenue.png)
*After drilling through from the country map, this map shows city revenue.*
*Drillthrough goes to the Genre Revenue Pie*


### Revenue by Genre, Artist, and Album
![Genre Revenue Pie](images/genre_pie.png)
*Pie chart showing the most profitable genre, artist, and album revenue.*













