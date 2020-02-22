SELECT COUNT(applicants) AS "Total applicants"
FROM promise_apps;

SELECT city
FROM promise_apps
WHERE city = 'Chicago';

SELECT COUNT(applicants) AS "Total applicants"
FROM promise_apps;

SELECT city, COUNT(applicants) AS "Total applicants"
FROM promise_apps
GROUP BY city;

SELECT city, MIN(applicants) AS "Min applicants"
FROM promise_apps
GROUP BY city;

SELECT * FROM public.promise_apps