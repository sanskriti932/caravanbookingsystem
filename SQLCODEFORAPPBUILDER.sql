-- SQL CODE FOR DASHBOARD(VISUAL REPRESENTATION OF DATA IN DASHBOARD)
-- CHART1 (NO. OF STAFFS WORKING ON EACH LOCATION)
SELECT L.LOCATION_NAME,C.LOCATION_ID,COUNT(STAFF_ID)
FROM STAFF S
JOIN CARAVAN_PARK_SITE C
ON S.CPS_ID=C.CPS_ID
JOIN LOCATION L
ON L.LOCATION_ID=C.LOCATION_ID
GROUP BY L.LOCATION_NAME,C.LOCATION_ID;

-- CHART2 (LOST DEPOSIT PER MONTH RESPECT TO BOOKING)
SELECT EXTRACT(MONTH FROM BOOKING_DATE) AS MONTH,SUM(TOTAL_DEPOSITAMOUNT)
FROM BOOKING
WHERE BOOKING_DATE=DATE_DEPOSIT OR ABS(DATE_DEPOSIT-DATE_ARRIVAL)<4
GROUP BY EXTRACT(MONTH FROM BOOKING_DATE)
ORDER BY SUM(TOTAL_DEPOSITAMOUNT) DESC;

-- CHART3(MOST POPULAR CARAVAN PARK SITE)
SELECT CPS_NAME,COUNT(BOOKING_ID)
FROM CARAVAN_PARK_SITE cps
JOIN CARAVAN c
ON cps.CPS_ID=c.CPS_ID
JOIN BOOKING b
ON b.C_ID=c.C_ID
GROUP BY CPS_NAME;

-- CHART4(MAXIMUM NO. OF CARAVAN FACILITY GREATER THAN SIX BELONGING TO A CARAVAN)
SELECT MAX(NO_OF_CFACILITY),C.C_NAME,C.C_ID,CF.CFACILITY_NAME
FROM C_FACILITY CF
JOIN CARAVAN C
ON C.C_ID = CF.C_ID
GROUP BY C.C_NAME,C.C_ID,CF.CFACILITY_NAME
HAVING MAX(NO_OF_CFACILITY)>6;

-- SQL CODE FOR CARDS
-- DETAILS OF STAFF WORKING ON EACH LOCATION
SELECT L.LOCATION_NAME,C.LOCATION_ID,S.STAFF_ID,S.STAFF_NAME
FROM STAFF S
JOIN CARAVAN_PARK_SITE C
ON S.CPS_ID=C.CPS_ID
JOIN LOCATION L
ON L.LOCATION_ID=C.LOCATION_ID;

-- LOWEST RENTAL TARIFF FOR EACH CARAVAN
SELECT C_ID,C_NAME, MIN(RENTAL_TARIFF) AS "LOWEST RENTAL TARIFF"
FROM CARAVAN
GROUP BY C_ID,C_NAME
HAVING SUM (RENTAL_TARIFF)>800;
