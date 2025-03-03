SELECT AVG(utilization_percentage) AS average_utilization FROM machine_utilization
select * from machine_utilization

select * from production_orders

UPDATE production_orders
SET status = CASE
    WHEN random() < 0.0833 THEN 'Order Placed'
    WHEN random() < 0.1667 THEN 'Order Confirmed'
    WHEN random() < 0.25 THEN 'Order Processed'
    WHEN random() < 0.3333 THEN 'Order Picked'
    WHEN random() < 0.4167 THEN 'Order Packed'
    WHEN random() < 0.5 THEN 'Order Dispatched'
    WHEN random() < 0.5833 THEN 'In Transit'
    WHEN random() < 0.6667 THEN 'Out for Delivery'
    WHEN random() < 0.75 THEN 'Delivered'
    WHEN random() < 0.8333 THEN 'Order Returned'
    WHEN random() < 0.9167 THEN 'Order Cancelled'
    ELSE 'Order Refunded'
END
RETURNING *;

