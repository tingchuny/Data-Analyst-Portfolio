/*Both queries show the same result.
  The first one was done as per course requirement using subquries,
  and the second was done as per personal preference using JOIN.*/

SELECT
	c.id 			AS cus_id,
    c.name 			AS cus_name,
    (SELECT MAX(purchase.id) 
     FROM purchase 
     WHERE purchase.customer_id = c.id) 
     	AS latest_purchase_id,
    (SELECT SUM(purchase_item.quantity) 
     FROM purchase_item 
     WHERE purchase_item.purchase_id IN 
     	(SELECT purchase.id 
         FROM purchase 
         WHERE purchase.customer_id = c.id)
    )   AS all_items_purchased
    
FROM
	customer AS c;




SELECT
	c.id				AS cus_id,
	c.name				AS cus_name,
	MAX(purchase_id)	AS latest_purchase_id,
	SUM(quantity)		AS all_items_purchased


FROM
	customer AS c
	JOIN purchase ON c.id = purchase.customer_id
	JOIN purchase_item ON purchase.id = purchase_item.purchase_id

GROUP BY
	c.id
