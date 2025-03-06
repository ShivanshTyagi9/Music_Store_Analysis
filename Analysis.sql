SELECT COUNT(*) as c, billing_country
from invoice
GROUP BY billing_country
ORDER BY c DESC;