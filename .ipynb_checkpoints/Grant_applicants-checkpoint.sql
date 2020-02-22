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

select application_type
from promise_apps
where application_type = 'Nonprofit';

select application_type
from promise_apps
where application_type = 'Other';

select application_type
from promise_apps
where application_type = 'IHE';

select absolute_priority
from promise_apps
where absolute_priority = 'AP1';

select absolute_priority
from promise_apps
where absolute_priority = 'AP2: Rural Communities';

select absolute_priority
from promise_apps
where absolute_priority = 'AP3: Tribal Communities';

