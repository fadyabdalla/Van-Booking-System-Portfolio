-- Read-only business analysis queries | MySQL / MariaDB
-- Run after importing van_booking_system.sql into the selected database.

-- 1. Booking pipeline: retain statuses with no bookings.
SELECT bs.status_name, COUNT(b.booking_id) AS booking_count
FROM booking_status bs LEFT JOIN booking b ON b.booking_status_id = bs.booking_status_id
GROUP BY bs.booking_status_id, bs.status_name ORDER BY booking_count DESC, bs.status_name;

-- 2. Average completed booking value and total completed booking charges (GBP).
-- Charges are not the same as cash received or profit.
SELECT COUNT(*) AS completed_bookings, ROUND(AVG(b.total_final_cost), 2) AS average_booking_gbp,
       SUM(b.total_final_cost) AS completed_charges_gbp
FROM booking b JOIN booking_status bs ON b.booking_status_id = bs.booking_status_id
WHERE bs.status_name = 'Completed';

-- 3. Cash recorded as received, including deposits (not pending payments).
SELECT SUM(amount_paid) AS recorded_receipts_gbp
FROM payment WHERE payment_status IN ('Completed', 'Deposit Paid');

-- 4. Completed booking charges attributed to each driver, including inactive or unused drivers.
SELECT d.driver_id, d.first_name, d.last_name, COUNT(b.booking_id) AS completed_bookings,
       COALESCE(SUM(b.total_final_cost), 0) AS completed_charges_gbp
FROM driver d LEFT JOIN booking b ON d.driver_id = b.driver_id
  AND b.booking_status_id IN (SELECT booking_status_id FROM booking_status WHERE status_name = 'Completed')
GROUP BY d.driver_id, d.first_name, d.last_name ORDER BY completed_charges_gbp DESC, d.driver_id;

-- 5. Demand by pickup location (all non-cancelled bookings, fictional locations).
SELECT l.location_id, l.street AS pickup_zone, COUNT(*) AS booking_count
FROM booking b JOIN location l ON b.pickup_location_id = l.location_id
JOIN booking_status bs ON b.booking_status_id = bs.booking_status_id
WHERE bs.status_name <> 'Cancelled'
GROUP BY l.location_id, l.street ORDER BY booking_count DESC, l.location_id;

-- 6. Vehicle fleet composition (not actual usage: bookings do not record a van ID).
SELECT vt.van_type_name, COUNT(v.van_id) AS fleet_count
FROM van_type vt LEFT JOIN van v ON v.van_type_id = vt.van_type_id
GROUP BY vt.van_type_id, vt.van_type_name ORDER BY fleet_count DESC, vt.van_type_name;

-- 7. Quote accuracy for completed bookings.
SELECT b.booking_id, b.total_estimated_cost, b.total_final_cost,
       b.total_final_cost - b.total_estimated_cost AS variance_gbp
FROM booking b JOIN booking_status bs ON b.booking_status_id = bs.booking_status_id
WHERE bs.status_name = 'Completed' ORDER BY b.booking_id;
