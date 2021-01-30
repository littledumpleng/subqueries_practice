-- Lab 5

-- Q1
-- List vendors by name and state from whom we bought a line item that costs more than $3,000. Use one subquery and one join to build the overall query.

-- Approach 1 (JOIN in subquery)
SELECT vendor_name, vendor_state
	FROM vendors 
    WHERE vendor_id IN 
   (SELECT vendor_id 
		FROM ap.invoice_line_items
        JOIN ap.invoices USING (invoice_id)
        WHERE line_item_amount >  3000)
	ORDER BY vendor_name;

    
-- Approach 2 (two joins)
SELECT DISTINCT vendor_name, vendor_state 
FROM ap.vendors
	JOIN invoices USING(vendor_id)
    JOIN invoice_line_items USING(invoice_id)
WHERE line_item_amount > 3000
ORDER BY vendor_name;


-- Q2
-- Use a correlated subquery to return one row per vendor, representing the vendor's newest invoice (the one with the latest date).

USE ap;
SELECT 
	vendor_name AS 'Vendor Name', -- Vendors
	invoice_number AS 'Invoice Number', -- Invoices
    CAST(invoice_date AS DATETIME) AS 'Invoice Date/Time', -- Invoices
    CONCAT('$', FORMAT(invoice_total, 2)) AS 'Invoice Total' -- Invoices
FROM invoices i
	JOIN vendors v
		USING(vendor_id)
WHERE invoice_date = 
	(SELECT MAX(invoice_date)
		FROM invoices
		WHERE vendor_id = i.vendor_id)
ORDER BY vendor_name;
        

-- Q3
SELECT 
	vendor_name AS 'Vendor Name', 
    CONCAT(LEFT(vendor_phone, 3), '.' , SUBSTRING(vendor_phone, 4, 3), '.' , RIGHT(vendor_phone, 4)) AS 'Vendor Phone', 
    DATE_FORMAT(MAX(invoice_date), '%M %d, %Y') AS 'Latest Invoice' 
FROM ap.vendors v
    JOIN ap.invoices USING(vendor_id)
ORDER BY vendor_name;

    
    

    
    
