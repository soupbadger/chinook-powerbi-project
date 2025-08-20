-- Aggregate total revenue for music artists, albums, and genres for each customer, country, and city
-- Clean up data for import into Power BI

select
  i.BillingCountry,
  i.BillingCity,
  g.Name as Genre,
  art.Name as Artist,
  alb.Title as AlbumTitle,
  sum(t.UnitPrice * il.Quantity) as TotalRevenue
from
  track t
  join invoiceline il on t.TrackId = il.TrackId
  join invoice i on il.InvoiceId = i.InvoiceId
  join mediatype m on t.MediaTypeId = m.MediaTypeID
  join album alb on t.AlbumId = alb.AlbumId
  join artist art on art.ArtistId = alb.ArtistId
  join genre g on t.GenreId = g.GenreId
  -- Exclude video files and non-music genres
where
  t.MediaTypeId != 3
  and g.GenreId NOT BETWEEN 18 AND 23
group by
  i.BillingCountry,
  i.BillingCity,
  g.Name,
  art.Name,
  alb.Title
order by
  i.BillingCountry,
  g.Name;
