-- Each result should be 0. Read-only data validation queries.
SELECT COUNT(*) AS invalid_review_count
FROM review r JOIN booking b ON r.booking_id = b.booking_id
JOIN booking_status bs ON b.booking_status_id = bs.booking_status_id
WHERE bs.status_name <> 'Completed' OR r.customer_id <> b.customer_id
   OR r.driver_id <> b.driver_id;

SELECT COUNT(*) AS completed_bookings_missing_final_charge
FROM booking b JOIN booking_status bs ON b.booking_status_id = bs.booking_status_id
WHERE bs.status_name = 'Completed' AND b.total_final_cost IS NULL;

SELECT COUNT(*) AS non_demo_contacts FROM (
  SELECT email, phone FROM customer UNION ALL SELECT email, phone FROM driver
) contacts WHERE email NOT LIKE '%@example.com' OR phone NOT LIKE '07700900%';
