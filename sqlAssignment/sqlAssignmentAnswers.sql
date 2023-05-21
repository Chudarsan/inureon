
-- Q.1 Query all columns for all American cities in the CITY table with populations larger than 100000. 
-- The countryCode for America is USA.


CREATE TABLE city(
        id INT,
        name VARCHAR(17),
        countrycode VARCHAR(3),
        district VARCHAR(20),
        population INT

	);


INSERT INTO city VALUES 
        (6,'Rotterdam','NLD','Zuid-Holland',593321),
        (3878,'Scottsdale','USA','Arizona',202705),
        (3965,'Corona','USA','California',124966),
        (3973,'Concord','USA','California',121780),
        (3977,'Cedar Rapids','USA','Iowa',120758),
        (3982,'Coral Springs','USA','Florida',117549),
        (4054,'Fairfield','USA','California',92256),
        (4058,'Boulder','USA','Colorado',91238),
        (4061,'Fall River','USA','Massachusetts',90555),
        (1661,'NYC','USA','Newyork',90525),
        (4333,'Mitaka','JPN','Tokyo',91155),
        (4551,'Hino','JPN','Tokyo',45678);



SELECT  
        id,
        name,
        countrycode,
        district,
        population 
FROM 
        city
WHERE
		population > 100000 
        AND 
        countrycode = 'USA';



-- Q.2 Query the name field for all American cities in the CITY table with populations larger than 120000. 
-- The countryCode for America is USA.


SELECT  
        name
FROM 
        city
WHERE
		population > 120000 
        AND 
        countrycode = 'USA';



-- Q.3 Query all columns (attributes) for every row in the CITY table. 


SELECT  
        id,
        name,
        countrycode,
        district,
        population  
FROM 
        city;



-- Q.4 Query all columns for a city in CITY with the id 1661.


SELECT  
        id,
        name,
        countrycode,
        district,
        population  
FROM 
        city
WHERE
        id = 1661;



-- Q.5 Query all attributes of every Japanese city in the CITY table. The countryCODE for Japan is JPN.


SELECT  
        id,
        name,
        countrycode,
        district,
        population  
FROM 
        city
WHERE
        countrycode = 'JPN';



-- Q.6 Query the names of all the Japanese cities in the CITY table. The countryCODE for Japan is JPN.


SELECT  
        name
FROM 
        city
WHERE
        countrycode = 'JPN';



-- Q.7 Query a list of CITY and STATE from the station table.


CREATE TABLE station(
        id INT,
        city VARCHAR(21),
        state VARCHAR(2),
        lat_n INT,
        long_w INT

	);


INSERT INTO station VALUES 
        (794,'Kissee Mills','MO',139,73),
        (824,'Loma Mar','CA',48,130),
        (603,'Sandy Hook','CT',72,148),
        (478,'Tipton','IN',33,97),
        (619,'Arlington','CO',75,92),
        (711,'Turner','AR',50,101),
        (839,'Slidell','LA',85,151),
        (411,'Negreet','LA',98,105),
        (588,'Glencoe','KY',46,136),
        (665,'Chelsea','IA',98,59),
        (342,'Chignik Lagoon','AK',103,153),
        (733,'Pelahatchie','MS',38,28),
        (441,'Hanna,City','IL',50,136),
        (811,'Dorrance','KS',102,121),
        (698,'Albany','CA',49,80),
        (325,'Monument','KS',70,141),
        (414,'Manchester','MD',73,37),
        (113,'Prescott','IA',39,65),
        (971,'Graettinger','IA',94,150),
        (266,'Cahone','CO',116,127);



SELECT 
		city, 
        state 
FROM 
		station;


-- Q.8 Query a list of CITY names from STATION for cities that have an even ID number. 
-- Print the results in any order, but exclude duplicates from the answer.


SELECT 
		DISTINCT city
FROM
		station
WHERE
		id%2 = 0;


-- Q.9 Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.


SELECT 
		(COUNT(city) -  COUNT(DISTINCT city)) AS difference
FROM 
		station;



-- Q.10 Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths 
-- (i.e.: number of characters in the name). If there is more than one smallest or largest city, 
-- choose the one that comes first when ordered alphabetically.


-- APPROACH 1:



(SELECT
		city, 
        Length(city) AS len
FROM 
		station
ORDER BY 
        Length(city), 
        city 
LIMIT 1)

UNION ALL

(SELECT
		city, 
        Length(city) AS len
FROM 
		station
ORDER BY 
        Length(city) DESC, 
        city 
LIMIT 1);



-- APPROACH 2:



WITH temp_city AS (
					SELECT 
							city,
							LENGTH(city) as len,
							ROW_NUMBER() OVER (ORDER BY LENGTH(city), city) AS smallest,
							ROW_NUMBER() OVER (ORDER BY LENGTH(city) DESC, city) AS largest
					FROM 
							station
                )

SELECT 
        city,
        len
FROM 
        temp_city
WHERE  
        smallest = 1 
        OR 
        largest = 1
ORDER BY 
        len;



-- Q11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from station. Your result cannot contain duplicates.


-- Approach 1


SELECT  
		DISTINCT city
FROM
		station        
WHERE 
        LEFT(city , 1) IN ('a','e','i','o','u');


-- Approach 2


SELECT  
       DISTINCT city
FROM 
        station 
WHERE 
        SUBSTR(city,1,1) IN ('A','E','I','O','U');


-- Approach 3


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city RLIKE '^[aeiouAEIOU]';


-- Approach 4


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city REGEXP '^[aeiouAEIOU]';


-- Approach 5


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city REGEXP '^[aeiou]';



-- Q12. Query the list of CITY names ending with vowels (a, e, i, o, u) from station. Your result cannot contain duplicates.


-- Approach 1


SELECT  
		DISTINCT city
FROM
		station        
WHERE 
        RIGHT(city , 1) IN ('a','e','i','o','u');


-- Approach 2


SELECT  
        DISTINCT city
FROM 
        station 
WHERE 
        SUBSTR(city,-1,1) IN ('A','E','I','O','U');


-- Approach 3


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city RLIKE '.*[aeiouAEIOU]$';
        
        
-- Approach 4 


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city REGEXP '.*[aeiouAEIOU]$';


-- Approach 5


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city REGEXP '[aeiou]$';



-- Q13. Query the list of CITY names from station that do not start with vowels. Your result cannot contain duplicates.


-- Approach 1


SELECT  
		DISTINCT city
FROM
		station        
WHERE 
        LEFT(city , 1) NOT IN ('a','e','i','o','u');


-- Approach 2


SELECT  
        DISTINCT city
FROM 
        station 
WHERE 
        SUBSTR(city,1,1) NOT IN ('A','E','I','O','U');


-- Approach 3


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city NOT RLIKE '^[aeiouAEIOU]';


-- Approach 4


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city NOT REGEXP '^[aeiouAEIOU]';


-- Approach 5


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city NOT REGEXP '^[aeiou]';



-- Q14. Query the list of CITY names from station that do not end with vowels. Your result cannot contain duplicates.


-- Approach 1


SELECT  
		DISTINCT city
FROM
		station        
WHERE 
        RIGHT(city , 1) NOT IN ('a','e','i','o','u');


-- Approach 2


SELECT  
		DISTINCT city
FROM 
        station 
WHERE 
        SUBSTR(city,-1,1) NOT IN ('A','E','I','O','U');


-- Approach 3


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city NOT RLIKE '.*[aeiouAEIOU]$';
  
  
-- Approach 4


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city NOT REGEXP '.*[aeiouAEIOU]$';


-- Approach 5


SELECT  
		DISTINCT city 
FROM
		station
WHERE 
		city NOT REGEXP '[aeiou]$';



-- Q15. Query the list of CITY names from station that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.


-- Approach 1


SELECT 
		DISTINCT city 
FROM 
		station 
WHERE 
		SUBSTR(city,1,1) NOT IN ('A','E','I','O','U') 
        OR
		SUBSTR(city,-1,1) NOT IN ('A','E','I','O','U');
        
        
-- Approach 2


SELECT 
		DISTINCT city 
FROM 
		station 
WHERE 
		city RLIKE '^[^aeiouAEIOU].*|.*[^AEIOUaeiou]$';
        


-- Q16. Query the list of CITY names from station that do not start with vowels and do not end with vowels. 
-- Your result cannot contain duplicates.


-- Approach 1


SELECT 
		DISTINCT city 
FROM 
		station 
WHERE 
		SUBSTR(city,1,1) NOT IN ('A','E','I','O','U') 
        AND 
        SUBSTR(city,-1,1) NOT IN ('A','E','I','O','U');
        

-- Approach 2


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city NOT REGEXP '^[aeiou]|[aeiou]$';


-- Approach 3


SELECT  
		DISTINCT city
FROM
		station
WHERE 
		city REGEXP '^[^aeiou].*[^aeiou]$';



-- Q.17 Write an SQL query that reports the products that were only sold in the first quarter of 2019. 
-- That is, between 2019-01-01 and 2019-03-31 inclusive. Return the result table in any order.


CREATE TABLE product(
        product_id INT,
        product_name VARCHAR(20),
        unit_price INT,
        CONSTRAINT prime_key PRIMARY KEY(product_id)
	);


INSERT INTO product VALUES
        (1,'S8',1000),
        (2,'G4',800),
        (3,'iPhone',1400);


CREATE TABLE sales(
        seller_id INT,
        product_id INT,
        buyer_id INT,
        sales_date DATE,
        quantity INT,
        price INT,
        CONSTRAINT foriegn_key FOREIGN KEY(product_id) REFERENCES product(product_id)       
	);


INSERT INTO sales VALUES
        (1,1,1,'2019-01-21',2,2000),
        (1,2,2,'2019-02-17',1,800),
        (2,2,3,'2019-06-02',1,800),
        (3,3,4,'2019-05-13',2,2800);



-- Approach 1



SELECT 
		p.product_id,
        p.product_name
FROM
		product p
INNER JOIN 
		sales s 
ON
		p.product_id = s.product_id
WHERE 
		p.product_id 
NOT IN (
		SELECT 
				product_id
		FROM 
				sales
		WHERE
				sales_date > '2019-03-31'
        )
GROUP BY 	
		p.product_id
HAVING 
		MAX(s.sales_date) <='2019-03-31' 
        AND 
        MIN(s.sales_date) >='2019-01-01';



-- Approach 2



SELECT 
		p.product_id,
        p.product_name
FROM
		product p
INNER JOIN 
		sales s
ON
		p.product_id = s.product_id
GROUP BY 
		p.product_id,
        p.product_name
HAVING 
		MIN(s.sales_date) >= '2019-01-01' AND MAX(s.sales_date) <= '2019-03-31';



-- Q.18 Write an SQL query to find all the authors that viewed at least one of their own articles. 
-- Return the result table sorted by id in ascending order.


CREATE TABLE views(
        article_id INT,
        author_id INT,
        viewer_id INT,
        view_date DATE
        
	);


INSERT INTO views VALUES
        (1,3,5,'2019-08-01'),
        (1,3,6,'2019-08-02'),
        (2,7,7,'2019-08-01'),
        (2,7,6,'2019-08-02'),
        (4,7,1,'2019-08-22'),
        (3,4,4,'2019-07-21'),
        (3,4,4,'2019-07-21');



SELECT 
		DISTINCT a.author_id
FROM 
		views a
JOIN   
		views v
ON 
		a.author_id = v.viewer_id
ORDER BY 
		a.author_id;



-- Q.19 Write an SQL query to find the percentage of immediate orders in the table, rounded to 2 decimal places.


CREATE TABLE delivery(
        delivery_id INT,
        customer_id INT,
        order_date DATE,
        customer_preferred_delivery_date DATE
        
	);


INSERT INTO delivery VALUES
        (1,1,'2019-08-01','2019-08-02'),
        (2,5,'2019-08-02','2019-08-02'),
        (3,1,'2019-08-11','2019-08-11'),
        (4,3,'2019-08-24','2019-08-26'),
        (5,4,'2019-08-21','2019-08-22'),
        (6,2,'2019-07-11','2019-08-13');



SELECT 
		ROUND(immediate_orders * 100 / total_orders, 2) AS immediate_orders_perct
FROM 
		(
            SELECT 
				    COUNT(
                            CASE 
                            WHEN order_date = customer_preferred_delivery_date 
                            THEN customer_id
                            END
					    ) 	AS immediate_orders, 
				    COUNT(delivery_id) AS total_orders
		    FROM 
				    delivery
		) temp ;



-- Q.20 Write an SQL query to find the ctr of each Ad. Round ctr to two decimal points.
-- Return the result table ordered by ctr in descending order and by ad_id in ascending order in case of a tie.


CREATE TABLE ads(
        ad_id INT,
        user_id INT,
        action ENUM('CLICKED','viewED','IGNORED'),
        CONSTRAINT prime_key PRIMARY KEY(ad_id, user_id)        
	);


INSERT INTO ads VALUES
        (1,1,'CLICKED'),
        (2,2,'CLICKED'),
        (3,3,'VIEWED'),
        (5,5,'IGNORED'),
        (1,7,'IGNORED'),
        (2,7,'VIEWED'),
        (3,5,'CLICKED'),
        (1,4,'VIEWED'),
        (2,11,'VIEWED'),
        (1,2,'CLICKED');



SELECT 
		ad_id,
        CASE 
            WHEN (num_of_clicks * 100) / (num_of_clicks + num_of_views) IS NULL THEN 0
            ELSE ROUND((num_of_clicks * 100) / (num_of_clicks + num_of_views), 2)
            END AS ctr 
FROM 
		(
			SELECT 
					ad_id,
					COUNT(
							CASE 
							WHEN action = 'CLICKED' THEN ad_id
							END
						) 	AS num_of_clicks, 
					COUNT(
							CASE WHEN action = 'VIEWED' THEN ad_id
							END
						) 	AS num_of_views
			FROM 
					ads
			GROUP BY 
					ad_id
		)	temp_ads
ORDER BY
		ctr DESC,
		ad_id ASC;



-- Q.21 Write an SQL query to find the team size of each of the employees.


CREATE TABLE employee(
		employee_id INT,
		team_id INT,
		CONSTRAINT prime_key PRIMARY KEY(employee_id)        
	);


INSERT INTO employee VALUES
        (1,8),
        (2,8),
        (3,8),
        (4,7),
        (5,9),
        (6,9);



SELECT 
		employee_id, 
		COUNT(employee_id) OVER(PARTITION BY team_id) AS team_size
FROM
		employee
ORDER BY 
		employee_id;



-- Q.22 Write an SQL query to find the type of weather in each country for November 2019. The type of weather is:
-- ● Cold if the average weather_state is less than or equal 15,
-- ● Hot if the average weather_state is greater than or equal to 25, and
-- ● Warm otherwise.
-- Return result table in any order.


CREATE TABLE countries(
        country_id INT,
        country_name VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(country_id)
	);


INSERT INTO countries VALUES
        (2, 'USA'),
        (3, 'AUSTRALIA'),
        (7, 'PERU'),
        (5, 'CHINA'),
        (8, 'MOROCCO'),
        (9, 'SPAIN');


CREATE TABLE weather(
        country_id INT,
        weather_state INT,
        day DATE,
        CONSTRAINT prime_key PRIMARY KEY(country_id, day) 
	);


INSERT INTO weather VALUES
        (2,15,'2019-11-01'),
        (2,12,'2019-10-28'),
        (2,12,'2019-10-27'),
        (3,-2,'2019-11-10'),
        (3,0,'2019-11-11'),
        (3,3,'2019-11-12'),
        (5,16,'2019-11-07'),
        (5,18,'2019-10-09'),
        (5,21,'2019-10-23'),
        (7,25,'2019-11-08'),
        (7,22,'2019-12-01'),
        (7,20,'2019-12-02'),
        (8,25,'2019-11-05'),
        (8,27,'2019-11-15'),
        (8,31,'2019-11-25'),
        (9,7,'2019-10-23'),
        (9,3,'2019-12-23');



SELECT 
        c.country_name,
        CASE
			WHEN AVG(weather_state) <= 15 THEN 'COLD'
			WHEN AVG(weather_state) >= 25 THEN 'HOT'
			ELSE 'WARM'
			END AS avg_weather
FROM 
		countries c
INNER JOIN 
		weather w
ON 
		c.country_id = w.country_id
WHERE 
		day BETWEEN '2019-11-01' AND '2019-11-30'
GROUP BY 
		c.country_id,
        c.country_name; 



-- Q.23 Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.


CREATE TABLE prices(
        product_id INT,
        start_date DATE,
        end_date DATE,
        price INT,
        CONSTRAINT prime_key PRIMARY KEY(product_id, start_date, end_date)
	);


INSERT INTO prices VALUES
        (1,'2019-02-17','2019-02-28',5),
        (1,'2019-03-01','2019-03-22',20),
        (2,'2019-02-01','2019-02-20',15),
        (2,'2019-02-21','2019-03-31',30);


CREATE TABLE units_sold(
        product_id INT,
        purchase_date DATE,
        units INT
	);


INSERT INTO units_sold VALUES
        (1,'2019-02-25',100),
        (1,'2019-03-01',15),
        (2,'2019-02-10',200),
        (2,'2019-02-22',30);



SELECT 
		p.product_id,
        ROUND(SUM(p.price * u.units)/SUM(u.units), 2) AS average_price
FROM 
		units_sold u
INNER JOIN
		prices p
ON 
		p.product_id = u.product_id
WHERE 	
		u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
		p.product_id;



-- Q.24 Write an SQL query to report the first login date for each player. Return the result table in any order.


CREATE TABLE activity(
        player_id INT,
        device_id INT,
        event_date DATE,
        games_played INT,
        CONSTRAINT prime_key PRIMARY KEY(player_id, event_date)
	);


INSERT INTO activity VALUES 
        (1,2,'2016-03-01',5),
        (1,2,'2016-03-02',6),
        (2,3,'2017-06-25',1),
        (3,1,'2016-03-02',0),
        (3,4,'2018-07-03',5);



-- Approach 1



WITH temp_activity AS (
							SELECT 
									player_id,
									event_date as first_login,
									ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) as ranking
							FROM
									activity
					)
            
SELECT 
		player_id,
        first_login
FROM 
		temp_activity
WHERE
		ranking = 1;



-- Approach 2



SELECT 
		player_id,
        first_login
FROM  	(
			SELECT 
					player_id,
					event_date as first_login,
					ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) ranking
			FROM
					activity
		) temp_activity
WHERE
		ranking = 1;



-- Q.25 Write an SQL query to report the device that is first logged in for each player. Return the result table in any order.


-- Approach 1



WITH temp_activity AS (
							SELECT 
									player_id,
									device_id,
									ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY device_id) ranking
							FROM
									activity
						)
            
SELECT 
		player_id,
        device_id
FROM 
		temp_activity
WHERE
		ranking = 1;
        
      
-- Approach 2    
        
        
SELECT 
		player_id,
        device_id
FROM  	(
			SELECT 
					player_id,
					device_id,
					ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY device_id) as ranking
			FROM
					activity
		) temp_activity
WHERE
		ranking = 1;



-- Q.26 Write an SQL query to get the names of products that have at least 100 units ordered in February 2020 and their amount.


CREATE TABLE products(
        product_id INT,
        product_name VARCHAR(30),
        product_category VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(product_id)
	);


INSERT INTO products VALUES
        (1,'LEETCODE SOLUTIONS','BOOK'),
        (2,'JEWELS OF STRINGOLOGY','BOOK'),
        (3,'HP','LAPTOP'),
        (4,'LENOVO','LAPTOP'),
        (5,'LEETCODE KIT','T-SHIRT');


CREATE TABLE orders(
        product_id INT,
        order_date DATE,
        unit INT,
        CONSTRAINT foriegn_key FOREIGN KEY(product_id) REFERENCES products(product_id)
	);


INSERT INTO orders VALUES
        (1,'2020-02-05',60),
        (1,'2020-02-05',70),
        (2,'2020-01-05',30),
        (2,'2020-02-05',80),
        (3,'2020-02-05',2),
        (3,'2020-02-05',3),
        (4,'2020-03-05',20),
        (4,'2020-03-05',30),
        (4,'2020-03-05',60),
        (5,'2020-02-05',50),
        (5,'2020-02-05',50),
        (5,'2020-03-05',50);



SELECT 
		p.product_name,
        SUM(o.unit) AS total_unit_sold
FROM 
		products p
INNER JOIN
		orders o
ON 
		p.product_id = o.product_id
WHERE 
		order_date BETWEEN '2020-02-01' AND '2020-02-28'
GROUP BY
		p.product_id
HAVING 
		SUM(o.unit) >= 100;



-- Q.27 Write an SQL query to find the users who have valid emails.


CREATE TABLE users(
		user_id INT,
		name VARCHAR(25),
		mail VARCHAR(25),
		CONSTRAINT prime_key PRIMARY KEY(user_id)
	);


INSERT INTO users VALUE 
        (1,'WINSTON','winston@leetcode.com'),
        (2,'JONATHAN','jonathonisgreat'),
        (3,'ANNABELLE','bella-@leetcode.com'),
        (4,'SALLY','sally.come@leetcode.com'),
        (5,'MARWAN','quarz-- 2020@leetcode.com'),
        (6,'DAVID','david45@gmail.com'),
        (7,'SHAPIRO','.shapo@leetcode.com');



SELECT
		user_id,
        name,
        mail
FROM
		users
WHERE
		mail LIKE '%@leetcode.com' AND mail REGEXP '^[a-zA-Z0-9][a-zA-Z0-9._-]*@[a-zA-Z0-9][a-zA-Z0-9._-]*\\.[a-zA-Z]{2,4}$';



-- Q.28 Write an SQL query to report the customer_id and customer_name of customers who have spent at least $100 in each month of 
-- June and July 2020. Return the result table in any order.


CREATE TABLE customers(
        customer_id INT,
        name VARCHAR(20),
        country VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(customer_id)
	);


CREATE TABLE orders(
        order_id INT,
        customer_id INT,
        product_id INT,
        order_date DATE,
        quantity INT,
        CONSTRAINT prime_key PRIMARY KEY(order_id)
	);


CREATE TABLE products(
        product_id INT,
        description VARCHAR(20),
        price INT,
        CONSTRAINT prime_key PRIMARY KEY(product_id)
	);


INSERT INTO customers VALUES 
        (1,'WINSTON','USA'),
        (2,'JONATHON','PERU'),
        (3,'MOUSTAFA','EGYPT');


INSERT INTO products VALUES 
        (10,'LC PHONE',300),
        (20,'LC T-SHIRT',10),
        (30,'LC BOOK',45),
        (40,'LC KEYCHAIN',2);


INSERT INTO orders VALUES 
        (1,1,10,'2020-06-10',1),
        (2,1,20,'2020-07-01',1),
        (3,1,30,'2020-07-08',2),
        (4,2,10,'2020-06-15',2),
        (5,2,40,'2020-07-01',10),
        (6,3,20,'2020-06-24',2),
        (7,3,30,'2020-06-25',2),
        (9,3,30,'2020-05-08',3);



SELECT 
		customer_id,
		name
 FROM 
		(
			SELECT 
					c.customer_id,
					c.name,
					EXTRACT(MONTH FROM o.order_date) AS month_extracted,
					SUM(o.quantity * p.price) AS total_spent
			FROM 
					orders o
			INNER JOIN 
					customers c 
			ON 
					c.customer_id = o.customer_id
			INNER JOIN 
					products p
			ON 
					p.product_id = o.product_id
			WHERE 
					o.order_date BETWEEN '2020-06-01' AND '2020-07-31'
			GROUP BY 
					c.customer_id,
					c.name, 
                    EXTRACT(MONTH FROM o.order_date)
		) temp_customers
        
WHERE 
		total_spent >= 100
GROUP BY 
		customer_id
HAVING 
		COUNT(customer_id) = 2;



-- Q.29 Write an SQL query to report the distinct titles of the kid-friendly movies streamed in June 2020. 
-- Return the result table in any order.


CREATE TABLE tv_program(
        program_date DATETIME,
        content_id INT,
        channel VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(program_date, content_id)
);


CREATE TABLE content(
        content_id INT,
        title VARCHAR(20),
        kids_content ENUM('Y','N'),
        content_type VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(content_id)
);


INSERT INTO content VALUES
        (1,'LEETCODE MOVIE', 'N','MOVIES'),
        (2,'ALG. FOR KidS', 'Y','SERIES'),
        (3,'DATABASE SOLS', 'N','SERIES'),
        (4,'ALADDIN', 'Y','MOVIES'),
        (5,'CINDERELLA', 'Y','MOVIES');
        

INSERT INTO tv_program VALUES
		('2020-06-10 18:00',1,'LC-channel'),
        ('2020-05-11 12:00',2,'LC-channel'),
        ('2020-05-12 12:00',3,'LC-channel'),
        ('2020-05-13 14:00',4,'DISNEY-CH'),
        ('2020-06-18 14:00',4,'DISNEY-CH'),
        ('2020-07-15 16:00',5,'DISNEY-CH');



SELECT 
		DISTINCT c.title
FROM 
		content c
INNER JOIN 
		tv_program t
ON 
		c.content_id = T.content_id
WHERE 
		c.kids_content = 'Y' 
        AND 
        c.content_type = 'movies' 
        AND 
        T.program_date BETWEEN '2020-06-01' AND '2020-06-30';



-- Q.30 Write an SQL query to find the npv of each query of the Queries table. Return the result table in any order.



CREATE TABLE npv(
        id INT,
        year INT,
        npv INT,
        CONSTRAINT prime_key PRIMARY KEY(id, year)
	);


CREATE TABLE queries(
        id INT,
        year INT,
        CONSTRAINT prime_key PRIMARY KEY(id, year)
	);


INSERT INTO npv VALUES
        (1,2018,100),
        (7,2020,30),
        (13,2019,40),
        (1,2019,113),
        (2,2008,121),
        (3,2009,12),
        (11,2020,99),
        (7,2019,0);


INSERT INTO queries VALUES
        (1,2019),
        (2,2008),
        (3,2009),
        (7,2018),
        (7,2019),
        (7,2020),
        (13,2019);



SELECT 
		DISTINCT n.id,
		n.year,
        n.npv
FROM 
		queries q
INNER JOIN 
		npv n
ON 
		n.id = q.id 
        AND 
        n.year = q.year;



-- Q.31 SAME AS 30



-- Q.32 Write an SQL query to show the unique id of each user, If a user does not have a unique id replace just show null.
-- Return the result table in any order.


CREATE TABLE employees(
		id INT,
		name VARCHAR(20),
		CONSTRAINT prime_key PRIMARY KEY(id)
	);


CREATE TABLE employees_uni(
		id INT,
		unique_id INT,
		CONSTRAINT prime_key PRIMARY KEY(id, unique_id)
	);


INSERT INTO employees VALUES
		(1,'ALICE'),
		(7,'BOB'),
		(11,'MEIR'),
		(90,'WINSTON'),
		(3,'JONATHAN');


INSERT INTO employees_uni VALUES
		(3,1),
		(11,2),
		(90,3);



SELECT
		eu.unique_id,
        e.name
FROM 
		employees e
LEFT JOIN 
		employees_uni eu
ON 
		e.id = eu.id
ORDER BY 
		e.name;



-- Q.33 Write an SQL query to report the distance travelled by each user. Return the result table ordered by travelled_distance 
-- in descending order, if two or more users travelled the same distance, order them by their name in ascending order.


CREATE TABLE users(
		id INT,
		name VARCHAR(20),
		CONSTRAINT prime_key PRIMARY KEY(id)
	);


INSERT INTO users VALUES
		(1,'ALICE'),
		(2,'BOB'),
		(3,'ALEX'),
		(4,'DONALD'),
		(7,'LEE'),
		(13,'JONATHON'),
		(19,'ELVIS');


CREATE TABLE rides(
        id INT,
        user_id INT,
        distance INT,
        CONSTRAINT prime_key PRIMARY KEY(id)
	);


INSERT INTO rides VALUES
        (1,1,120),
        (2,2,317),
        (3,3,222),
        (4,7,100),
        (5,13,312),
        (6,19,50),
        (7,7,120),
        (8,19,400),
        (9,7,230);



SELECT
		u.name AS riders,
		COALESCE(SUM(r.distance), 0) AS distance_travelled
FROM 
		users u
LEFT JOIN 
		rides r
ON 
		u.id = r.user_id
GROUP BY 
		u.name
ORDER BY 
		distance_travelled DESC, 
		riders;



-- Q.34 SAME AS 26



-- Q.35 Write an SQL query to:
-- ● Find the name of the user who has rated the greatest number of movies. In case of a tie,
-- return the lexicographically smaller user name.
-- ● Find the movie name with the highest average rating in February 2020. In case of a tie, 
-- return the lexicographically smaller movie name.


CREATE TABLE users(
		user_id INT,
		name VARCHAR(20),
		CONSTRAINT prime_key PRIMARY KEY(user_id)
	);


INSERT INTO users VALUES
		(1,'DANIEL'),
		(2,'MONICA'),
		(3,'MARIA'),
		(4,'JAMES');


CREATE TABLE movies(
		movie_id INT,
		title VARCHAR(20),
		CONSTRAINT prime_key PRIMARY KEY(movie_id)
	);


INSERT INTO movies VALUES
		(1,'AVENGERS'),
		(2,'FROZEN 2'),
		(3,'JOKER');


CREATE TABLE movie_rating(
		movie_id INT,
		user_id INT,
		rating INT,
		created_at DATE,
		CONSTRAINT prime_key PRIMARY KEY(movie_id, user_id)
	);


INSERT INTO movie_rating VALUES
		(1,1,3,'2020-01-12'),
		(1,2,4,'2020-02-11'),
		(1,3,2,'2020-02-12'),
		(1,4,1,'2020-01-01'),
		(2,1,5,'2020-02-17'),
		(2,2,2,'2020-02-01'),
		(2,3,2,'2020-03-01'),
		(3,1,3,'2020-02-22'),
		(3,2,4,'2020-02-25');



-- Find the name of the user who has rated the greatest number of movies



SELECT 
		u.name as user
FROM 
		users u
INNER JOIN 
		movie_rating mr 
ON
		u.user_id = mr.user_id
GROUP BY 
		u.user_id
ORDER BY 
		COUNT(u.name) DESC,
        LENGTH(u.name)
LIMIT 1;



-- Find the movie name with the highest average rating in February 2020.



SELECT 
        m.title
FROM 
		movies m
INNER JOIN 
		movie_rating mr 
ON
		m.movie_id = mr.movie_id
WHERE 
		mr.created_at BETWEEN '2020-02-01' AND '2020-02-28'
GROUP BY 
		m.movie_id
ORDER BY 
		AVG(rating) DESC,
        m.title
LIMIT 1;



-- Q.36 SAME AS 33



-- Q.37 SAME AS 32



-- Q.38 Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exist.
-- Return the result table in any order.


CREATE TABLE departments(
		id INT,
		name VARCHAR(25),
		CONSTRAINT prime_key PRIMARY KEY(id)
	);


INSERT INTO departments VALUES
		(1,'ELECTRICAL ENGINEERING'),
		(7,'COMPUTER ENGINEERING'),
		(13,'BUSINESS ADMINISTRATION');


CREATE TABLE students(
		id INT,
		name VARCHAR(25),
		department_id INT,
		CONSTRAINT prime_key PRIMARY KEY(id)
	);


INSERT INTO students VALUES
		(23,'ALICE',1),
		(1,'BOB',7),
		(5,'JENNIFER',13),
		(2,'JOHN',14),
		(4,'JASMINE',77),
		(3,'STEVE',74),
		(6,'LUIS',1),
		(8,'JONATHON',7),
		(7,'DAIANA',33),
		(11,'MADELYNN',1);



SELECT
		id,
		name 
FROM 
		students 
WHERE 
		department_id NOT IN (
								SELECT 
										id 
								FROM 
										departments 
							);



-- Q.39 Write an SQL query to report the number of calls and the total call duration between 
-- each pair of distinct persons (person1, person2) where person1 < person2. Return the result table in any order.


CREATE TABLE calls(
		from_id INT,
		to_id INT,
		duration INT
	);


INSERT INTO calls VALUES
		(1,2,59),
		(2,1,11),
		(1,3,20),
		(3,4,100),
		(3,4,200),
		(3,4,200),
		(4,3,499);



-- Approach 1



SELECT 
		CASE
		    WHEN from_id < to_id THEN from_id 
            ELSE to_id 
            END AS person1,
		CASE
		    WHEN from_id < to_id THEN to_id 
            ELSE from_id 
            END AS person2,
        COUNT(*) AS call_count,
		SUM(duration) AS total_duration
FROM 
		calls
GROUP BY 
		person1, 
        person2;



-- Approach 2



SELECT 
        least(from_id, to_id) AS person1,
        greatest(from_id,to_id) AS person2,
        COUNT(*) AS call_count,
        SUM(duration) AS total_duration
FROM 
		calls
GROUP BY 
		person1, 
        person2;



-- Q.40 SAME AS 23



-- Q.41 Write an SQL query to report the number of cubic feet of volume the inventory occupies in each warehouse.
-- Return the result table in any order.


CREATE TABLE warehouse(
		name VARCHAR(25),
		product_id INT,
		units INT,
		CONSTRAINT prime_key PRIMARY KEY(name,product_id)
	);


INSERT INTO warehouse VALUES
		('LCHOUSE1',1,1),
		('LCHOUSE1',2,10),
		('LCHOUSE1',3,5),
		('LCHOUSE2',1,2),
		('LCHOUSE2',2,2),
		('LCHOUSE3',4,1);


CREATE TABLE products(
		product_id INT,
		product_name VARCHAR(25),
		width INT,
		length INT,
		height INT,
		CONSTRAINT prime_key PRIMARY KEY(product_id)
	);


INSERT INTO products VALUES
		(1,'LC-TV',5,50,40),
		(2,'LC-KEYCHAIN',5,5,5),
		(3,'LC-PHONE',2,10,10),
		(4,'LC-SHIRT',4,10,20);



SELECT
        w.name AS warehouse_name,
        SUM(p.length * p.width * p.height * w.units) AS volume
FROM 
        warehouse w
INNER JOIN 
        products p
ON 
        w.product_id = p.product_id
GROUP BY 
        w.name;



-- Q.42 Write an SQL query to report the difference between the number of apples and oranges sold each day. 
-- Return the result table ordered by sale_date.


CREATE TABLE sales(
		sale_date DATE,
		fruit ENUM('APPLES','ORANGES'),
		sold_num INT,
		CONSTRAINT prime_key PRIMARY KEY(sale_date,fruit)
	);


INSERT INTO sales VALUES
		('2020-05-01','APPLES',10),
		('2020-05-01','ORANGES',8),
		('2020-05-02','APPLES',15),
		('2020-05-02','ORANGES',15),
		('2020-05-03','APPLES',20),
		('2020-05-03','ORANGES',0),
		('2020-05-04','APPLES',15),
		('2020-05-04','ORANGES',16);



-- Approach 1



SELECT 
		sale_date, 
		difference 
FROM 
		(
			SELECT 
					sale_date,
					sold_num - LEAD(sold_num, 1) OVER(PARTITION BY sale_date) AS difference
			FROM 
					sales
		)   temp_sales 
WHERE 
		difference IS NOT NULL
ORDER BY 
		sale_date;



-- Approach 2



SELECT
		sale_date,
        SUM(
			CASE
			WHEN fruit = 'APPLES' THEN sold_num
			WHEN fruit = 'ORANGES' THEN -sold_num
			END 
			) AS difference
FROM 
		sales
GROUP BY 
		sale_date
ORDER BY 
		sale_date;



-- Approach 3



SELECT
		s.sale_date, 
        s.sold_num - ss.sold_num AS difference
FROM 
		sales s
INNER JOIN 
		sales ss
ON 
		s.sale_date = ss.sale_date
WHERE 
		s.fruit = 'APPLES' AND ss.fruit = 'ORANGES'
ORDER BY 
		sale_date;



-- Approach 4



SELECT
		sale_date,
        SUM(IF(fruit = 'APPLES', sold_num, -sold_num)) AS difference
FROM
		sales
GROUP BY 
		sale_date
ORDER BY 
		sale_date;



-- Approach 5



SELECT
		sale_date,
        SUM(
			CASE
			WHEN fruit = 'APPLES' THEN sold_num
			ELSE -sold_num
			END 
			) AS difference
FROM 
		sales
GROUP BY 
		sale_date
ORDER BY 
		sale_date;



-- Q.43 Write an SQL query to report the fraction of players that logged in again on the day after the day 
-- they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players 
-- that logged in for at least two consecutive days starting from their first login date, 
-- then divide that number by the total number of players.


-- Approach 1



WITH temp_activity AS (
						SELECT 
								player_id,
								LEAD(event_date, 1) OVER(PARTITION BY player_id ORDER BY event_date)  - event_date  AS difference
						FROM 
								activity
			),

	temp_activity2 AS (
						SELECT 
								COUNT(DISTINCT player_id) AS players_count
						FROM 	
								temp_activity
						WHERE 
								difference = 1
						GROUP BY 
								player_id
			)

SELECT 
		ROUND(COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS fraction
FROM 
		temp_activity2;



-- Approach 2



WITH temp_activity AS (
						SELECT 
								player_id,
								event_date,
								DATEDIFF(event_date,lag(event_date) OVER(PARTITION BY player_id ORDER BY event_date)) AS difference
						FROM 
								activity
			),

	temp_activity2 AS (
						SELECT 
								COUNT(DISTINCT player_id) AS players_count
						FROM 	
								temp_activity
						WHERE 
								difference = 1
						GROUP BY 
								player_id
			)
            

SELECT 
		ROUND(COUNT(*) / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS fraction
FROM 
		temp_activity2;



-- Q.44 Write an SQL query to report the managers with at least five direct reports.


CREATE TABLE employee(
		id INT,
		name VARCHAR(20),
		department VARCHAR(20),
		manager_id INT,
		CONSTRAINT prime_key PRIMARY KEY(id)
	);


INSERT INTO employee VALUES 
		(101,'JOHN','A',NULL),
		(102,'DAN','A',101),
		(103,'JAMES','A',101),
		(104,'AMY','A',101),
		(105,'ANNE','A',101),
		(106,'RON','A',101),
		(107,'BUTTLER','A',111),
		(108,'JIMMY','A',121),
		(111,'ROOT','A',NULL),
		(121,'POPE','A',NULL);



-- Approach 1



SELECT 
		name 
FROM 
		employee 
WHERE 
		id = (
				SELECT 
						e.manager_id
				FROM 
						employee e
				INNER JOIN 
						employee ee
				ON 
						e.manager_id = ee.id
				GROUP BY 
						e.manager_id
				HAVING 
						COUNT(e.manager_id) >= 5
			);



-- Approach 2



SELECT 
		name 
FROM 
		employee 
WHERE 
		id = (
				SELECT 
						manager_id
				FROM 
						employee
				GROUP BY 
						manager_id
				HAVING 
						COUNT(manager_id) >= 5
			);



-- Q.45 Write an SQL query to report the respective department name and number of students majoring in 
-- each department for all departments in the department table (even ones with no current students). 
-- Return the result table ordered by student_number in descending order. In case of a tie, order them by dept_name alphabetically


CREATE TABLE department(
		dept_id INT,
		department_name VARCHAR(20),
		CONSTRAINT prime_key PRIMARY KEY(dept_id)
	);


CREATE TABLE student(
		student_id INT,
		student_name VARCHAR(20),
		gender VARCHAR(6),
		dept_id INT,
		CONSTRAINT prime_key PRIMARY KEY(student_id),
		CONSTRAINT foriegn_key FOREIGN KEY(dept_id) REFERENCES department(dept_id)
	);


INSERT INTO department VALUES 
		(1,'ENGINEERING'),
		(2,'SCIENCE'),
		(3,'LAW');
        
        
INSERT INTO student VALUES 
		(1,'JACK','M',1),
		(2,'JANE','F',1),
		(3,'MARK','M',2);



SELECT 
		d.department_name,
		COUNT(s.student_id) AS number_of_students
FROM 
		department d
LEFT JOIN 
		student s
ON 
		d.dept_id = s.dept_id
GROUP BY 
		d.department_name
ORDER BY 
		number_of_students DESC,
        department_name;



-- Q.46 Write an SQL query to report the customer ids from the Customer table that bought all the products in the product table.
-- Return the result table in any order.


CREATE TABLE customer(
		customer_id INT,
		product_key INT
	);


INSERT INTO customer VALUES 
		(1,5),
		(2,6),
		(3,5),
		(3,6),
		(1,6);


CREATE TABLE product(
		product_key INT,
		CONSTRAINT prime_key PRIMARY KEY(product_key)
	);


INSERT INTO product VALUES 
		(5),
		(6);



SELECT 
		customer_id
FROM 
		customer
GROUP BY 
		customer_id
HAVING 
		COUNT(DISTINCT product_key) = (
										SELECT 
												COUNT(DISTINCT product_key) 
										FROM 
												product
									);



-- Q.47 Write an SQL query that reports the most experienced employees in each project. In case of a tie, 
-- report all employees with the maximum number of experience years. Return the result table in any order.


CREATE TABLE employee(
		employee_id INT,
		name VARCHAR(20),
		experience_years INT,
		CONSTRAINT prime_key PRIMARY KEY(employee_id)
	);


CREATE TABLE project(
		project_id INT,
		employee_id INT,
		CONSTRAINT prime_key PRIMARY KEY(project_id, employee_id)
	);


INSERT INTO employee VALUES 
		(1,'KHALED',3),
		(2,'ALI',2),
		(3,'JOHN',3),
		(4,'DOE',2);


INSERT INTO project VALUES 
		(1,1),
		(1,2),
		(1,3),
		(2,1),
		(2,4);



-- Approach 1



SELECT 
		project_id,
		employee_id
FROM
		(
			SELECT 
					p.project_id, 
					e.employee_id,
					DENSE_RANK() OVER(PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS ranking
			FROM 
					employee e
			INNER JOIN 
					project p
			ON 
					e.employee_id = p.employee_id
		) temp_employee
WHERE 
		ranking = 1;



-- Approach 2



SELECT 
		p.project_id,
		e.employee_id
FROM
		employee e
INNER JOIN 
		project p
ON 
		e.employee_id = p.employee_id
WHERE 
		e.experience_years = 
							(
								SELECT 
										MAX(experience_years)
								FROM 
										employee 
							);



-- Q.48 Write an SQL query that reports the books that have sold less than 10 copies in the last year, 
-- excluding books that have been available for less than one month from today. Assume today is 2019-06-23.
-- Return the result table in any order.


CREATE TABLE books(
		book_id INT,
		name VARCHAR(20),
		available_from DATE,
		CONSTRAINT prime_key PRIMARY KEY(book_id)
	);
    
    
CREATE TABLE orders(
		order_id INT,
		book_id INT,
		quantity INT,
		dispatch_date DATE,
		CONSTRAINT prime_key PRIMARY KEY(order_id),
		CONSTRAINT foriegn_key FOREIGN KEY(book_id) REFERENCES books(book_id)
	);


INSERT INTO books VALUES 
		(1,"Kalila And Demna",'2010-01-01'),
		(2,"28 Letters",'2012-05-12'),
		(3,"The Hobbit",'2019-06-10'),
		(4,"13 Reasons Why",'2019-06-01'),
		(5,"The Hunger Games",'2008-09-21');


INSERT INTO orders VALUES 
		(1,1,2,'2018-07-26'),
		(2,1,1,'2018-11-05'),
		(3,3,8,'2019-06-11'), 
		(4,4,6,'2019-06-05'), 
		(5,4,5,'2019-06-20'), 
		(6,5,9,'2009-02-02'), 
		(7,5,8,'2010-04-13');



SELECT 
		b.book_id, b.name
FROM 
		books b
LEFT JOIN 
		orders o
ON 
		b.book_id = o.book_id 
WHERE 
		available_from < '2019-05-23' 
		AND 
        (o.dispatch_date BETWEEN '2018-06-23' AND '2019-06-23')
		OR 
        dispatch_date IS NULL
GROUP BY  
		b.book_id,
        b.name
HAVING 
		COALESCE(SUM(o.quantity), 0) < 10;



-- Q.49 Write a SQL query to find the highest grade with its corresponding course for each student. 
-- In case of a tie, you should find the course with the smallest course_id. Return the result table 
-- ordered by student_id in ascending order.


CREATE TABLE enrollments(
		student_id INT,
		course_id INT,
		grade INT,
		CONSTRAINT prime_key PRIMARY KEY(student_id,course_id)
    );


INSERT INTO enrollments VALUES 
		(2,2,95),
		(2,3,95),
		(1,1,90),
		(1,2,99),
		(3,1,80),
		(3,2,75),
		(3,3,82);
        
        
        
-- Approach 1



SELECT 
        student_id, 
        course_id, 
        grade 
FROM 
        (
            SELECT 
                    student_id, 
                    course_id, 
                    grade, 
                    ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY grade DESC) AS ranking
            FROM 
                    enrollments
        ) temp_enrollments
WHERE 
        ranking = 1
order by 
        student_id;
        
        
        
-- Approach 2



WITH temp_enrollments AS 
			(
				SELECT 
						student_id, 
						course_id, 
						grade, 
						ROW_NUMBER() OVER(PARTITION BY student_id ORDER BY grade DESC) AS ranking
				FROM 
						enrollments
			)
            
SELECT 
        student_id, 
        course_id, 
        grade 
FROM 
		temp_enrollments
WHERE 
        ranking = 1
order by 
        student_id;



-- Q.50 Write an SQL query to find the winner in each group. Return the result table in any order.


CREATE TABLE matches(
		match_id INT,
		first_player INT,
		second_player INT,
		first_player_goals INT,
		second_player_goals INT,
		CONSTRAINT prime_key PRIMARY KEY(match_id)
	);


CREATE TABLE teams(
		player_id INT,
		team_id INT,
		CONSTRAINT prime_key PRIMARY KEY(player_id)
    );


INSERT INTO matches VALUES 
		(1,15,45,3,0),
		(2,30,25,1,2),
		(3,30,15,2,0),
		(4,40,20,5,2),
		(5,35,50,1,1);


INSERT INTO teams VALUES 
		(15,1),
		(25,1),
		(30,1),
		(45,1),
		(10,2),
		(35,2),
		(50,2),
		(20,3),
		(40,3);



SELECT 
		team_id,
		players as player_id
FROM 	(
			SELECT 
					t.team_id, 
					CASE
						WHEN first_player_goals > second_player_goals THEN first_player
						WHEN first_player_goals < second_player_goals THEN second_player
						WHEN first_player_goals = second_player_goals THEN IF(first_player < second_player, first_player, second_player)
						END AS players,
						MAX(IF(first_player_goals > second_player_goals, first_player_goals, second_player_goals)) AS goals,
						ROW_NUMBER() OVER(PARTITION BY team_id ORDER BY MAX(IF(first_player_goals > second_player_goals, first_player_goals, second_player_goals)) DESC) AS ranking
			FROM 
					teams t
			INNER JOIN 
					matches m
			ON 
					m.first_player = t.player_id 
					OR 
					m.second_player = t.player_id
			GROUP BY 
					t.team_id,
					players
		) temp_matches
WHERE 
		ranking = 1;
        
        

-- Q.51 Write an SQL Query to report the name, population, and area of the big countries. 
-- Return the result table in any order . 


CREATE TABLE world(
		name VARCHAR(20) NOT NULL,
		continent VARCHAR(15) NOT NULL,
		area INT NOT NULL,
		population BIGINT NOT NULL,
		gdp BIGINT NOT NULL,
		CONSTRAINT prime_key PRIMARY KEY(name)
	);


INSERT INTO world VALUES 
		('Afghanistan', 'Asia', 652230, 25500100, 203430000000),
        ('Albania', 'Europe', 28748, 2831741, 12960000000),
        ('Algeria', 'Africa', 2381741, 37100000, 188681000000),
        ('Andorra', 'Europe', 468, 78115, 3712000000),
        ('Angola', 'Africa', 1246700, 20609294, 100990000000),
        ('Dominican Republic', 'Caribbean', 48671, 9445281, 58898000000),
        ('China', 'Asia', 652230, 1365370000, 8358400000000),
        ('Colombia', 'South America', 1141748, 47662000, 369813000000),
        ('Comoros', 'Africa', 1862, 743798, 616000000),
        ('Denmark', 'Europe', 43094, 5634437, 314889000000),
        ('Djibouti', 'Africa', 23200, 886000, 1361000000),
        ('Dominica', 'Caribbean', 751, 71293, 499000000),
		('SriLanka', 'Asia', 652230, 25500100, 203430000000);
        
        

SELECT 
        name, 
        population, 
        area 
FROM 
        world 
WHERE 
        area > 3000000 
        OR 
        population > 25000000;



-- Q.52 Write an SQL Query to report the names of the customer that are not referred by the customer with id = 2.
-- Return the result table in any order.


CREATE TABLE customer(
		id INT,
		name VARCHAR(10),
		refree_id INT,
		CONSTRAINT prime_key PRIMARY KEY(id)
	);
    

INSERT INTO customer VALUES 
		(1,'Will',NULL),
		(2,'Jane',NULL),
		(3,'Alex',2),
		(4,'Bill',NULL),
		(5,'Zack',1),
		(6,'Mark',2);



SELECT 
        name 
FROM 
        customer 
WHERE 
        refree_id <> 2
        OR
        refree_id IS NULL;



-- Q.53 Write an SQL Query to report all customers who never order anything. 
-- Return the result table in any order .


CREATE TABLE orders(
        id INT,
        customer_id INT,
        CONSTRAINT prime_key PRIMARY KEY(id)
    );


INSERT INTO orders VALUES 
        (1,3),
        (2,1);


CREATE TABLE customers(
        id INT,
        name VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(id)
    );


INSERT INTO customers VALUES 
        (1,'JOE'),
        (2,'HENRY'),
        (3,'SAM'),
        (4,'MAX');



SELECT 
        name AS customers
FROM 
        customers
WHERE 
        id NOT IN (
					SELECT 
							customer_id 
					FROM 
							orders
				);



-- Q.54 Write an SQL Query to find the team size of each of the employees. 
-- Return result table in any order .


CREATE TABLE employee(
        employee_id INT,
        team_id INT,
        CONSTRAINT prime_key PRIMARY KEY(employee_id)
    );


INSERT INTO employee VALUES 
        (1,8),
        (2,8),
        (3,8),
        (4,7),
        (5,9),
        (6,9);



SELECT 
        employee_id,
        COUNT(employee_id) OVER(PARTITION BY team_id ORDER BY employee_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS team_size
FROM 
        employee
ORDER BY 
        employee_id;



-- Q.55 Write an SQL Query to find the countries where this company can invest .
-- Return the result table in any order .


CREATE TABLE person(
        id INT,
        name VARCHAR(20),
        phone_number VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(id)
    );


CREATE TABLE country(
        name VARCHAR(20),
        country_code VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(country_code)
    );


CREATE TABLE calls(
        caller_id INT,
        callee_id INT,
        duration INT
    );


INSERT INTO person VALUES 
        (3,'JONATHON','051-1234567'),
        (21,'ELVIS','051-7654321'),
        (1,'MONCEF','212-1234567'),
        (2,'MAROUA','212-6523651'),
        (7,'MEIR','972-1234567'),
        (9,'RACHEL','972-0011100');


INSERT INTO calls VALUES 
        (1,9,33),
        (1,2,59),
        (3,12,102),
        (3,12,330),
        (12,3,5),
        (7,9,13),
        (7,1,3),
        (9,7,1),
        (1,7,7),
        (2,9,4);


INSERT INTO country VALUES 
        ('PERU','51'),
        ('ISRAEL','972'),
        ('MOROCCO','212'),
        ('GERMANY','49'),
        ('ETHIOPIA','251');


-- Approach 1


SELECT 
		name AS country
FROM 	(
			SELECT 
					c.name, 
					SUM(ca.duration) AS call_duration, 
					COUNT(c.country_code) AS number_of_calls
			FROM (
					SELECT 
							id, 
							name,
							CASE
							WHEN LEFT(SUBSTR(phone_number, 1,3),1) = '0' THEN RIGHT(SUBSTR(phone_number, 1,3), (LENGTH(SUBSTR(phone_number, 1,3))-1)) 
							ELSE SUBSTR(phone_number, 1,3) END AS country_code 
					FROM 
							person
				 ) temp_person
			JOIN 
					country c
			ON 
					temp_person.country_code = c.country_code
			JOIN 
					calls ca
			ON 
					temp_person.id = caller_id
			GROUP BY 
					c.name

UNION ALL

SELECT 
		c.name,
        SUM(ca.duration) AS call_duration, 
        COUNT(c.country_code) AS number_of_calls
FROM 	(
			SELECT 
					id, 
					name,
					CASE
						WHEN LEFT(SUBSTR(phone_number, 1,3),1) = '0' THEN RIGHT(SUBSTR(phone_number, 1,3), (length(SUBSTR(phone_number, 1,3))-1)) 
						ELSE SUBSTR(phone_number, 1,3) END AS country_code 
			FROM 
					person
		) 	temp_person
JOIN 
		country c
ON 
		temp_person.country_code = c.country_code
JOIN 
		calls ca
ON 
		temp_person.id = ca.callee_id
GROUP BY 
		c.name 
        
		) temp
GROUP BY 
		name 
HAVING 
		SUM(call_duration)/SUM(number_of_calls) >  (SELECT AVG(duration) FROM calls);



-- Approach 2


 WITH temp_person AS (
						SELECT 
								id, 
								name,
								CASE
									WHEN LEFT(SUBSTR(phone_number, 1,3),1) = '0' THEN RIGHT(SUBSTR(phone_number, 1,3), (LENGTH(SUBSTR(phone_number, 1,3))-1)) 
									ELSE SUBSTR(phone_number, 1,3) END AS country_code 
						FROM 
								person
				 ) 
						
        
SELECT 
		name AS country
FROM 	(
		SELECT 
				c.name, 
				SUM(ca.duration) AS call_duration, 
				COUNT(c.country_code) AS number_of_calls
		FROM 
				temp_person
		JOIN 
				country c
		ON 
				temp_person.country_code = c.country_code
		JOIN 
				calls ca
		ON 
				temp_person.id = ca.caller_id
		GROUP BY 
				c.name

UNION ALL

		SELECT 
				c.name,
				SUM(ca.duration) AS call_duration, 
				COUNT(c.country_code) AS number_of_calls
		FROM 	
				temp_person
		JOIN 
				country c
		ON 
				temp_person.country_code = c.country_code
		JOIN 
				calls ca
		ON 
				temp_person.id = ca.callee_id
		GROUP BY 
				c.name 
        
		)temp
GROUP BY 
		name 
HAVING 
		SUM(call_duration)/SUM(number_of_calls) >  (SELECT AVG(duration) FROM calls);



-- Q.56 Write an SQL Query to report the device that is first logged in for each player. 
-- Return the result table in any order.


CREATE TABLE activity(
        player_id INT,
        device_id INT,
        event_date DATE,
        games_played INT,
        CONSTRAINT prime_key PRIMARY KEY(player_id, event_date)
	);


INSERT INTO activity VALUES 
        (1,2,'2016-03-01',5),
        (1,2,'2016-03-02',6),
        (2,3,'2017-06-25',1),
        (3,1,'2016-03-02',0),
        (3,4,'2018-07-03',5);
        
        
        
SELECT 
        player_id,
        device_id 
FROM 
        (
            SELECT 
                    player_id, 
                    device_id, 
                    event_date, 
                    ROW_number() OVER(PARTITION BY player_id ORDER BY event_date) ranking 
            FROM 
                    activity
        ) temp_activity
WHERE 
        ranking = 1;



-- Q.57 Write an SQL Query to find the customer_number for the customer who has placed the largest number of orders.


CREATE TABLE orders(
        order_number INT,
        customer_number INT,
        CONSTRAINT prime_key PRIMARY KEY(order_number)
    );


INSERT INTO orders VALUES
        (1,1),
        (2,2),
        (3,3),
        (4,3);



WITH temp_orders AS (
						SELECT 
								DISTINCT customer_number, 
								DENSE_RANK() OVER(ORDER BY total_orders DESC) AS ranking 
						FROM ( 
								SELECT  
										customer_number, 
										COUNT(order_number) OVER(PARTITION BY customer_number) total_orders
								FROM 
										orders
							)   temp_cust_details
					)

SELECT  
		customer_number
FROM 
        temp_orders
WHERE 
        ranking = 1;



-- Q.58 Write an SQL Query to report all the consecutive available seats in the cinema.
-- Return the result table ordered by seat_id in ascending order.


CREATE TABLE cinema(
        seat_id INT AUTO_INCREMENT,
        free BOOLEAN,
        CONSTRAINT prime_key PRIMARY KEY(seat_id)
    );


INSERT INTO cinema (free) VALUES 
        (1),(0),(1),(1),(1),(1),(0),(1),
        (1),(0),(1),(1),(1),(0),(1),(1);



SELECT 
        DISTINCT c1.seat_id 
FROM 
        cinema c1
INNER JOIN 
        cinema c2
ON 
        ABS(c1.seat_id - c2.seat_id) = 1
        AND 
        (c1.free = 1 AND c2.free = 1)
ORDER BY 
        c1.seat_id;



-- Q.59 Write an SQL Query to report the names of all the salespersons who did not have any 
-- orders related to the company with the name "RED".


CREATE TABLE sales_person(
        sales_id INT,
        name VARCHAR(20),
        salary INT,
        commission_rate INT,
        hire_date VARCHAR(25),
        CONSTRAINT prime_key PRIMARY KEY(sales_id)
    );


INSERT INTO sales_person VALUES
        (1,'JOHN',100000,6,'4/1/2006'),
        (2,'AMY',12000,5,'5/1/2010'),
        (3,'MARK',65000,12,'12/25/2008'),
        (4,'PAM',25000,25,'1/1/2005'),
        (5,'ALEX',5000,10,'2/3/2007');


CREATE TABLE company(
        company_id INT,
        name VARCHAR(20),
        city VARCHAR(10),
        CONSTRAINT prime_key PRIMARY KEY(company_id)
    );


INSERT INTO company VALUES
        (1,'RED','BOSTON'),
        (2,'ORANGE','NEW YORK'),
        (3,'YELLOW','BOSTON'),
        (4,'GREEN','AUSTIN');


CREATE TABLE orders(
        order_id INT,
        order_date VARCHAR(30),
        company_id INT,
        sales_id INT,
        amount INT,
        CONSTRAINT prime_key PRIMARY KEY(order_id),
        CONSTRAINT company_foreign_key FOREIGN KEY (company_id) REFERENCES company(company_id),
        CONSTRAINT sales_foreign_key FOREIGN KEY (sales_id) REFERENCES sales_person(sales_id)
    );


INSERT INTO orders VALUES
        (1,'1/1/2014',3,4,10000),
        (2,'2/1/2014',4,5,5000),
        (3,'3/1/2014',1,1,50000),
        (4,'4/1/2014',1,4,25000);



SELECT 
        name 
FROM 
        sales_person
WHERE 
        sales_id NOT IN (
                            SELECT 
                                    o.sales_id
                            FROM 
                                    orders o
                            INNER JOIN 
                                    company c 
                            ON 
                                    c.company_id = o.company_id
                            WHERE 
                                    c.name = 'RED'
                        );



-- Q.60 Write an SQL Query to report for every three line segments whether they can form a triangle. 
-- Return the result table in any order.


CREATE TABLE triangle(
        x INT,
        y INT,
        z INT,
        CONSTRAINT prime_key PRIMARY KEY(x,y,z)
    );


INSERT INTO triangle VALUES
        (13,15,30),
        (10,20,15);



SELECT 
        x,
        y,
        z, 
        IF(x+y>z AND x+z>y AND y+z>x, 'YES','NO') AS is_triangle
FROM 
        triangle;



-- Q.61 Write an SQL Query to report the shortest distance between any two points from the Point table.


CREATE TABLE point(
        x INT,
        CONSTRAINT prime_key PRIMARY KEY(x)
    );


INSERT INTO point VALUES
        (-1),
        (0),
        (2);



SELECT 
        MIN(ABS(c1.x - c2.x)) AS shortest_distance
FROM 
        point c1
INNER JOIN 
        point c2
WHERE 
        c1.x!=c2.x;



-- Q.62 Write a SQL Query for a report that provides the pairs (actor_id, director_id) where the actor has 
-- cooperated with the director at least three times. Return the result table in any order.


CREATE TABLE actor_director(
        actor_id INT,
        director_id INT,
        timestamp INT,
        CONSTRAINT prime_key PRIMARY KEY(timestamp)
    );


INSERT INTO actor_director VALUES 
        (1,1,0),
        (1,1,1),
        (1,1,2),
        (1,2,3),
        (1,2,4),
        (2,1,5),
        (2,1,6);



WITH temp_actor_director AS (
							SELECT 
									DISTINCT actor_id, 
									director_id, 
									DENSE_RANK() OVER(ORDER BY total_movies DESC) AS ranking 
							FROM ( 
									SELECT  
											actor_id, 
											director_id, 
											COUNT(actor_id) OVER(PARTITION BY  actor_id, director_id) AS total_movies
									FROM 
											actor_director                       
								) temp
						)

SELECT 
        actor_id, 
        director_id 
FROM 
        temp_actor_director
WHERE 
        ranking = 1;



-- Q.63 Write an SQL Query that reports the product_name, year, and price for each sale_id in
-- the sales table. Return the resulting table in any order.


CREATE TABLE sales(
        sale_id INT,
        product_id INT,
        year INT,
        Quantity INT,
        price INT,
        CONSTRAINT prime_key PRIMARY KEY(sale_id, year)
    );


CREATE TABLE product(
        product_id INT,
        product_name VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(product_id)
    );


INSERT INTO sales VALUES 
        (1,100,2008,10,5000),
        (2,100,2009,12,5000),
        (7,200,2011,15,9000);


INSERT INTO product VALUES
        (100,'NOKIA'),
        (200,'APPLE'),
        (300,'SAMSUNG');



SELECT 
        p.product_name,
        s.year,
        s.price
FROM 
        sales s
INNER JOIN 
        product p
ON 
        p.product_id = s.product_id;



-- Q.64 Write an SQL Query that reports the average experience years of all the employees for each project, 
-- rounded to 2 digits. Return the result table in any order.


CREATE TABLE project(
        project_id INT,
        employee_id INT,
        CONSTRAINT prime_key PRIMARY KEY(project_id, employee_id)
    );


INSERT INTO project VALUES 
        (1,1),
        (1,2),
        (1,3),
        (2,1),
        (2,4);


CREATE TABLE employee(
        employee_id INT,
        name VARCHAR(20),
        experience_years INT,
        CONSTRAINT prime_key PRIMARY KEY(employee_id)
    );


INSERT INTO employee VALUES 
        (1,'KHALED',3),
        (2,'ALI',2),
        (3,'JOHN',1),
        (4,'DOE',2);


-- Approach 1


SELECT 
        p.project_id, 
        ROUND(AVG(experience_years), 2) AS average_years
FROM 
        employee e
INNER JOIN 
        project p
ON 
        p.employee_id = e.employee_id
GROUP BY 
        project_id;



-- Approach 2


SELECT 
        DISTINCT p.project_id, 
        ROUND(AVG(experience_years) OVER(PARTITION BY project_id), 2) AS average_years
FROM 
        employee e
INNER JOIN 
        project p 
ON 
        p.employee_id = e.employee_id;



-- Q.65 Write an SQL Query that reports the best seller by total sales price, If there is a tie, 
-- report them all. Return the result table in any order.


CREATE TABLE product(
        product_id INT,
        product_name VARCHAR(20),
        unit_price INT,
        CONSTRAINT prime_key PRIMARY KEY(product_id)
    );


INSERT INTO product VALUES 
        (1,'S8',1000),
        (2,'G4',800),
        (3,'Iphone',1400);


CREATE TABLE sales(
        seller_id INT,
        product_id INT,
        buyer_id INT,
        sale_date DATE,
        quantity INT,
        price INT,
        CONSTRAINT FOREIGN_KEY FOREIGN KEY(product_id) REFERENCES product(product_id)
    );


INSERT INTO sales VALUES 
        (1,1,1,'2019-01-21',2,2000),
        (1,2,2,'2019-01-21',1,800),
        (2,2,3,'2019-01-21',1,800),
        (3,3,4,'2019-01-21',2,2800);



WITH temp_sales AS (
                SELECT 
                        seller_id, 
                        total_price, 
                        DENSE_RANK() OVER (ORDER BY total_price DESC) ranking
                FROM
                    (
                        SELECT 
                                s.seller_id, 
                                SUM(s.quantity*p.unit_price) AS total_price
                        FROM 
                                sales s
                        INNER JOIN 
                                product p
                        ON 
                            p.product_id = s.product_id
                        GROUP BY 
                                seller_id
                    ) temp
             )


SELECT 
        seller_id 
FROM 
        temp_sales 
WHERE 
        ranking = 1;



-- Q.66 Write an SQL Query that reports the buyers who have bought S8 but not iphone. Note that S8 and iphone 
-- are products present in the product table. Return the result table in any order.


-- Same input table as for previous question i.e. 65



SELECT 
        s.buyer_id
FROM 
		sales s
INNER JOIN 
		product p
ON
		p.product_id = s.product_id
WHERE 
		p.product_name = 'S8' 
        AND 
        s.buyer_id NOT IN (
                            SELECT 
									s.buyer_id 
                            FROM 
									sales S 
                            INNER JOIN 
									product P 
							ON 
									s.product_id = p.product_id 
                            WHERE 
									p.product_name = 'Iphone'
							);



-- Q.67 Write an SQL Query to compute the moving average of how much the customer paid in a seven days window 
-- (i.e., current day + 6 days before). average_amount should be rounded to two decimal places. 
-- Return result table ordered by visited_on in ascending order.


CREATE TABLE customer(
		customer_id INT,
		name VARCHAR(20),
		visited_on DATE,
		amount INT,
		CONSTRAINT PRIMARY_KEY PRIMARY KEY(customer_id,visited_on)
	);


INSERT INTO customer VALUES 
		(1,'JOHN','2019-01-01',100),
		(2,'DANIEL','2019-01-02',110),
		(3,'JADE','2019-01-03',120),
		(4,'KHALED','2019-01-04',130),
		(5,'WINSTON','2019-01-05',110),
		(6,'ELVIS','2019-01-06',140),
		(7,'ANNA','2019-01-07',150),
		(8,'MARIA','2019-01-08',80),
		(9,'JAZE','2019-01-09',110),
		(1,'JOHN','2019-01-10',130),
		(3,'JADE','2019-01-10',150);



WITH temp_customer AS (
						SELECT 
								visited_on, 
								SUM(amount) AS amount
						FROM 
								customer
						GROUP BY 
								visited_on
					),

    temp_customer2 AS (
						SELECT 
								visited_on, 
								sum(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6  PRECEDING AND CURRENT ROW) AS weekly_amount, 
								ROUND(AVG(amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
								DENSE_RANK() OVER(ORDER BY visited_on) as ranking
						FROM 
								temp_customer
					)

SELECT 
        visited_on, 
        weekly_amount, 
        average_amount 
FROM 
        temp_customer2
WHERE 
        ranking > 6;



-- Q.68 Write an SQL Query to find the total score for each gender on each day.
-- Return the result table ordered by gender and day in ascending order.


CREATE TABLE scores(
        player_name VARCHAR(20),
        gender VARCHAR(20),
        day DATE,
        score_points INT,
        CONSTRAINT prime_key PRIMARY KEY(gender,day)
    );


INSERT INTO scores VALUES
        ('ARON','F','2020-01-01',17),
        ('ALICE','F','2020-01-07',23),
        ('BAJRANG','M','2020-01-07',7),
        ('KHALI','M','2019-12-25',11),
        ('SLAMAN','M','2019-12-30',13),
        ('JOE','M','2019-12-31',3),
        ('JOSE','M','2019-12-18',2),
        ('PRIYA','F','2019-12-31',23),
        ('PRIYANKA','F','2019-12-30',17);



SELECT 
        gender, 
        day, 
        SUM(score_points) OVER(PARTITION BY gender ORDER BY day 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_points 
FROM 
        scores
order by 
		gender,
        day;



-- Q.69 Write an SQL Query to find the start and end number of continuous ranges in the table logs. 
--  Return the result table ordered by start_id.


CREATE TABLE logs(
        log_id INT,
        CONSTRAINT prime_key PRIMARY KEY(log_id)
    );


INSERT INTO logs VALUES
        (1),
        (2),
        (3),
        (7),
        (8),
        (10);



SELECT 
		MIN(log_id) AS start_id, 
		MAX(log_id) AS end_id 
FROM 
		(
            SELECT 
                    log_id, 
                    DENSE_RANK() OVER(ORDER BY log_id - RN) AS ranking
            FROM 
                    (
                        SELECT 
                                log_id,
                                ROW_number() OVER(ORDER BY log_id) AS RN
                        FROM 
                                logs
                    )	temp_log
        ) temp_log2
GROUP BY 
		ranking
ORDER BY
		start_id;



-- Q.70 Write an SQL Query to find the number of times each student attended each exam. 
-- Return the result table ordered by student_id and subject_name.


CREATE TABLE students(
        student_id INT,
        student_name VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(student_id)
    );


CREATE TABLE subjects(
        subject_name VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(subject_name)
    );


CREATE TABLE exams(
        student_id INT,
        subject_name VARCHAR(20)
    );


INSERT INTO students VALUES
        (1,'ALICE'),
        (2,'BOB'),
        (13,'JOHN'),
        (6,'ALEX');


INSERT INTO subjects VALUES
        ('MATHS'),
        ('PHYSICS'),
        ('PROGRAMMING');


INSERT INTO exams VALUES    
        (1,'MATHS'),
        (1,'PHYSICS'),
        (1,'PROGRAMMING'),
        (2,'PROGRAMMING'),
        (1,'PHYSICS'),
        (1,'MATHS'),
        (13,'MATHS'),
        (13,'PROGRAMMING'),
        (13,'PHYSICS'),
        (2,'MATHS'),
        (1,'MATHS');
    


WITH temp_student AS (
						SELECT 
								student_id, 
								student_name, 
								subject_name  
						FROM 
								students, 
								subjects
					),

    temp_student2 AS (
						SELECT 
								student_id, 
								subject_name, 
								COUNT(*) AS times_attended_each_exam 
						FROM 
								exams
						GROUP BY 
								student_id, 
								subject_name
					)

SELECT 
        t.student_id,
        t.student_name, 
        t.subject_name, 
        COALESCE(times_attended_each_exam,0) AS attended_exams
FROM 
        temp_student t
LEFT JOIN 
        temp_student2 t2
ON 
        t.student_id = t2.student_id 
        AND 
        t.subject_name = t2.subject_name
ORDER BY 
        t.student_id, 
        t.subject_name;



-- Q.71 Write an SQL Query to find employee_id of all employees that directly or indirectly 
-- report their work to the head of the company. The indirect relation between managers will not exceed 
-- three managers as the company is small. Return the result table in any order.


CREATE TABLE employees(
        employee_id INT,
        employee_name VARCHAR(20),
        manager_id INT,
        CONSTRAINT prime_key PRIMARY KEY(employee_id)
    );


INSERT INTO employees VALUES    
        (1,'BOSS',1),
        (3,'ALICE',3),
        (2,'BOB',1),
        (4,'DANIEL',2),
        (7,'LUIS',4),
        (8,'JHON',3),
        (9,'ANGELA',8),
        (77,'ROBERT',1);



with recursive managers as (
							SELECT 
                                    employee_id, 
                                    manager_id 
                            FROM 
                                    employees 
                            WHERE 
                                    employee_id = 1
                                    
							UNION

							SELECT
                                    e.employee_id, 
                                    m.manager_id 
                            FROM 
                                    managers m
							INNER JOIN  
                                    employees e
							ON 
                                    e.manager_id = m.employee_id
						)
                        
SELECT 
        employee_id 
FROM 
        managers 
WHERE 
        employee_id <> manager_id;



-- Q.72 Write an SQL Query to find for each month and country, the number of transactions and their total amount, 
-- the number of approved transactions and their total amount. Return the result table in any order.


CREATE TABLE transactions(
        id INT,
        country VARCHAR(20),
        state ENUM ('APPROVED','DECLINED'),
        amount INT,
        trans_date DATE,
        CONSTRAINT prime_key PRIMARY KEY(id)
    );


INSERT INTO transactions VALUES 
        (121,'US','APPROVED',1000,'2018-12-18'),
        (122,'US','DECLINED',2000,'2018-12-19'),
        (123,'US','APPROVED',2000,'2019-01-01'),
        (124,'DE','APPROVED',2000,'2019-01-07');

   
   
WITH temp_transactions AS (
							SELECT 
									concat(YEAR(trans_date), '-',MONTH(trans_date)) AS transaction_date, 
									country, 
									state,
									count(*) OVER (PARTITION BY concat(YEAR(trans_date), '-',MONTH(trans_date)), country) AS total_transactions,
									sum(amount) OVER (PARTITION BY concat(YEAR(trans_date), '-',MONTH(trans_date)), country) AS total_transactions_amount,
									sum(amount) OVER (PARTITION BY concat(YEAR(trans_date), '-',MONTH(trans_date)), country, state) AS amount
									
							FROM
									transactions
						)
        
SELECT 
        transaction_date,
		country,
        total_transactions,
        count(*) OVER(PARTITION BY transaction_date, country, state) AS approved_transactions,
        total_transactions_amount,
        amount AS approved_amount
        
FROM 
        temp_transactions
WHERE 
        state = 'Approved';



-- Q.73 Write an SQL Query to find the average daily percentage of posts that got 
-- removed after being reported as spam, rounded to 2 decimal places.


CREATE TABLE actions(
        user_id INT,
        post_id INT,
        action_date DATE,
        action ENUM ('VIEW','LIKE','REACTION','COMMENT','REPORT','SHARE'),
        extra VARCHAR(20)
    );


CREATE TABLE removals(
        post_id INT,
        remove_date DATE,
        CONSTRAINT prime_key PRIMARY KEY(post_id)
    );


INSERT INTO actions VALUES
        (1,1,'2019-07-01','VIEW','NULL'),
        (1,1,'2019-07-01','LIKE','NULL'),
        (1,1,'2019-07-01','SHARE','NULL'),
        (2,2,'2019-07-04','VIEW','NULL'),
        (2,2,'2019-07-04','REPORT','SPAM'),
        (3,4,'2019-07-04','VIEW','NULL'),
        (3,4,'2019-07-04','REPORT','SPAM'),
        (4,3,'2019-07-02','VIEW','NULL'),
        (4,3,'2019-07-02','REPORT','SPAM'),
        (5,2,'2019-07-03','VIEW','NULL'),
        (5,2,'2019-07-03','REPORT','RACISM'),
        (5,5,'2019-07-03','VIEW','NULL'),
        (5,5,'2019-07-03','REPORT','RACISM');


INSERT INTO removals VALUES
        (2,'2019-07-20'),
        (3,'2019-07-18');



WITH temp_action AS (
						SELECT 
								action_date, 
								post_id, 
								COUNT(EXTRA) OVER(PARTITION BY action_date) num_post_reported_spam
						FROM 
								actions
						WHERE 
								extra = 'SPAM'
					)

SELECT 
        ROUND(AVG(percentage), 2) AS avg_daily_percent 
FROM 
        (
            SELECT 
                    action_date, 
                    ROUND((COUNT(post_id)/num_post_reported_spam) * 100, 2) AS percentage
            FROM 
                    temp_action
            WHERE 
                    post_id IN (
                                    SELECT 
                                            post_id 
                                    FROM 
                                            removals
								)
            GROUP BY 
                    action_date
        ) temp;



 -- Q.74 SAME AS Q.43 




 -- Q.75 SAME AS Q.43



 -- Q.76 Write an SQL Query to find the salaries of the employees after applying taxes. 
 -- Round the salary to the nearest integer.


 CREATE TABLE salaries(
        company_id INT,
        employee_id INT,
        employee_name VARCHAR(20),
        salary INT,
        CONSTRAINT prime_key PRIMARY KEY(company_id, employee_id)
    );


INSERT INTO salaries VALUES    
        (1,1,'TONY',2000),
        (1,2,'PRONUB',21300),
        (1,3,'TYRROX',10800),
        (2,1,'PAM',300),
        (2,7,'BASSEM',450),
        (2,9,'HERMIONE',700),
        (3,7,'BOCABEN',100),
        (3,2,'OGNJEN',2200),
        (3,13,'NYAN CAT',3300),
        (3,15,'MORNING CAT',7777);



WITH temp_salaries AS (
						SELECT 
								company_id, 
								employee_id, 
								employee_name, 
								salary,
								MAX(salary) OVER(PARTITION BY company_id) max_sal_per_company
						FROM 
								salaries
					)

SELECT 
		company_id, 
		employee_id, 
		employee_name, 
		salary, 
        ROUND(
                CASE
                    WHEN max_sal_per_company > 10000 THEN salary - (salary * 0.49)
                    WHEN max_sal_per_company BETWEEN 1000 AND 10000 THEN salary - (salary * 0.24)
                    ELSE salary 
			        END, 0) AS sal_after_tax_deduction
FROM 
        temp_salaries;



-- Q.77 Write an SQL Query to evaluate the boolean expressions in Expressions table. 
-- Return the result table in any order.


CREATE TABLE variables(
        name VARCHAR(2),
        value INT,
        CONSTRAINT prime_key PRIMARY KEY(name)
    );


INSERT INTO variables VALUES    
        ('x',66),
        ('y',77);
       
       
CREATE TABLE expressions(
        left_operand VARCHAR(2),
        operator ENUM('<','=','>'),
        right_operand VARCHAR(2),
        CONSTRAINT prime_key PRIMARY KEY(left_operand, operator, right_operand)
    );


INSERT INTO expressions VALUES    
        ('x','>','y'),
        ('x','<','y'),
        ('x','=','y'),
        ('y','>','x'),
        ('y','<','x'),
        ('x','=','x');



SELECT 
		e.left_operand, 
        e.operator, 
        e.right_operand,
		CASE
			WHEN e.operator = '<' THEN IF(l.value < r.value, 'TRUE', 'FALSE')
			WHEN e.operator = '>' THEN IF(l.value > r.value, 'TRUE', 'FALSE')
            ELSE IF(l.value = r.value, 'TRUE', 'FALSE')
			END AS result
FROM 
		expressions e
JOIN 
		variables l
ON 		
		e.left_operand = l.name
JOIN 
		variables r
ON
        e.right_operand = r.name;



-- Q.78 SAME AS Q.55



-- Q.79 Write a Query that prints a list of employee names (i.e.: the name attribute) 
-- from the employee table in alphabetical order.


CREATE TABLE employee(
        employee_id INT,
        name VARCHAR(20),
        months INT,
        salary INT
    );


INSERT INTO employee VALUES
        (12228,'ROSE',15,1968),
        (33645,'ANGELA',1,3443),
        (45692,'FRANK',17,1608),
        (56118,'PATRIK',7,1345),
        (74197,'KINBERLY',16,4372),
        (78454,'BONNIE',8,1771),
        (83565,'MICHAEL',6,2017),
        (98607,'TODD',5,3396),
        (99989,'JOE',9,3573);


SELECT 
        name 
FROM 
        employee 
ORDER BY 
        name;





-- Q.80 Write a Query to obtain the year-on-year growth rate for the total spend of each product for each year.


CREATE TABLE user_transactions(
        transaction_id INT,
        product_id INT,
        spend FLOAT,
        transaction_date VARCHAR(30)
    );


INSERT INTO user_transactions VALUES
        (1341,123424,1500.60,'12/31/2019 12:00:00'),
        (1423,123424,1000.20,'12/31/2020 12:00:00'),
        (1623,123424,1246.44,'12/31/2021 12:00:00'),
        (1322,123424,2145.32,'12/31/2022 12:00:00');
    
    
-- Approach 1


WITH temp_transactions AS (
							SELECT 
									product_id,
									transaction_date,
									spend AS curr_year_spend, 
									LAG(spend,1,0) OVER w AS prev_year_spend,
									IFNULL(spend - LAG(spend,1) OVER w, 0) AS prev_curr_spend_diff
							FROM 
									user_transactions
							WINDOW 
									w AS (PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))
						)
 
SELECT 
        product_id,
        curr_year_spend, 
        ROUND(prev_year_spend, 2),
        IFNULL(ROUND((prev_curr_spend_diff * 100)/prev_year_spend,2),0) AS YOY 
FROM 
        temp_transactions;
        
        
        
-- Approach 2


WITH temp_transactions AS (
							SELECT 
									YEAR(STR_TO_date(transaction_date, '%m/%d/%Y')) AS YEAR_id,
									product_id,
									transaction_date,
									spend AS curr_year_spend, 
									LAG(spend,1) OVER w AS prev_year_spend,
									spend - LAG(spend,1) OVER w AS prev_curr_spend_diff
							FROM 
									user_transactions
							WINDOW 
									w AS (PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))
						)
 
SELECT 
        year_id,
        product_id,
        curr_year_spend, 
        ROUND(prev_year_spend, 2),
        ROUND((prev_curr_spend_diff * 100)/prev_year_spend,2) AS YOY 
FROM 
        temp_transactions;
 

-- Approach 3


SELECT 
        product_id,
        YEAR(STR_TO_date(transaction_date, '%m/%d/%Y')) AS YEAR_id,
        spend AS curr_year_spend, 
        ROUND(LAG(spend,1,0) OVER w ,2) AS prev_year_spend,
        ROUND((spend - LAG(spend,1) OVER w ) * 100 /
                    LAG(spend,1) OVER w, 2)  AS YOY
FROM 
        user_transactions
WINDOW 
		w AS (PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date));



-- Q.81 Write a SQL Query to find the number of prime and non-prime items that can be stored 
-- in the 500,000 square feet warehouse. Output the item type and number of items to be stocked.


CREATE TABLE inventory(
        item_id INT,
        item_type VARCHAR(20),
        item_category VARCHAR(20),
        square_foot FLOAT
    );


INSERT INTO inventory VALUES
        (1374,'PRIME_ELIGIBLE','MINI FRidGE',68.00),
        (4245,'NOT_PRIME','STANDING LAMP',26.40),
        (2452,'PRIME_ELIGIBLE','TELEVISION',85.00),
        (3255,'NOT_PRIME','SidE TABLE',22.60),
        (1672,'PRIME_ELIGIBLE','LAPTOP',8.50);



-- Approach 1

WITH temp_inventory AS (
						SELECT 
								item_type, 
								SUM(square_foot) AS square_foot_per_category, 
								COUNT(*) AS count_of_items
						FROM 
								inventory
						GROUP BY 
								item_type
					),
                    
    temp_inventory2 AS (
						SELECT 
								(500000 - SUM(square_foot_per_category)*FLOOR(500000/SUM(square_foot_per_category))) AS area_left 
						FROM 
								temp_inventory 
						WHERE 
								item_type = 'PRIME_ELIGIBLE'
					),
                    
    temp_inventory3 AS (
						SELECT 
								item_type,
								CASE 
									WHEN item_type = 'PRIME_ELIGIBLE' 
										THEN FLOOR(500000/square_foot_per_category) * count_of_items
                                                
									WHEN item_type = 'NOT_PRIME' 
										THEN FLOOR((SELECT area_left FROM temp_inventory2) / square_foot_per_category) * count_of_items
                                        
									END AS item_count
						FROM 
								temp_inventory
					)
             
SELECT 
        item_type,
        item_count
 FROM 
        temp_inventory3;



-- Approach 2


WITH temp_inventory AS (
						SELECT 
								item_type, 
								SUM(square_foot) AS square_foot_per_category, 
								COUNT(*) AS count_of_items,
								CASE 
									WHEN item_type = 'PRIME_ELIGIBLE' THEN FLOOR(500000/SUM(square_foot)) * COUNT(*)
									END AS prime_items_count
						FROM 
								inventory
						GROUP BY 
								item_type
					),
                    
    temp_inventory2 AS (
						SELECT 
								(500000 - SUM(square_foot_per_category)*FLOOR(500000/SUM(square_foot_per_category))) AS area_left 
                        FROM 
								temp_inventory 
						WHERE 
								item_type = 'PRIME_ELIGIBLE'
					),
                    
    temp_inventory3 AS (
						SELECT 
								item_type, 
								CASE 
									WHEN item_type = 'PRIME_ELIGIBLE' THEN prime_items_count
									WHEN item_type = 'NOT_PRIME' THEN FLOOR((SELECT area_left FROM temp_inventory2) / square_foot_per_category) * count_of_items
									END AS item_count
						FROM 
								temp_inventory
					)
             
SELECT 
        item_type,
        item_count
FROM 
        temp_inventory3;



-- Approach 3


WITH temp_inventory AS (
						SELECT 
								item_type, 
								SUM(square_foot) AS square_foot_per_category, 
								COUNT(*) AS count_of_items,
								CASE 
									WHEN item_type = 'PRIME_ELIGIBLE' THEN FLOOR(500000/SUM(square_foot)) * COUNT(*)
									END AS prime_items_count
						FROM 
								inventory
						GROUP BY 
								item_type
					),
                    
    temp_inventory2 AS (
						SELECT 
								item_type, 
								CASE 
									WHEN item_type = 'PRIME_ELIGIBLE' THEN prime_items_count
									WHEN item_type = 'NOT_PRIME' THEN FLOOR((500000 -   (SELECT 
																								SUM(square_foot_per_category) 
																						FROM 
																								temp_inventory 
																						WHERE 
																								item_type = 'PRIME_ELIGIBLE') * FLOOR(500000 / 
																						(SELECT 
																								SUM(square_foot_per_category) 
																						FROM 
																								temp_inventory 
																						WHERE 
																								item_type = 'PRIME_ELIGIBLE'
																			))) / square_foot_per_category) * count_of_items
									END AS item_count
						FROM 
								temp_inventory
				)
             
SELECT 
        item_type, 
        item_count 
FROM 
        temp_inventory2;



-- Q.82 Write a Query to obtain the active user retention in July 2022. 
-- Output the month (in numerical format 1, 2, 3) and the number of monthly active users (MAUs).


CREATE TABLE user_actions(
        user_id INT,
        event_id INT,
        event_type ENUM('SIGN-IN','LIKE','COMMENT'),
        event_date DATETIME
    );


INSERT INTO user_actions VALUES
        (445,7765,'SIGN-IN','2022-05-31 12:00:00'),
        (742,6458,'SIGN-IN','2022-06-03 12:00:00'),
        (445,3634,'LIKE','2022-06-05 12:00:00'),
        (742,1374,'COMMENT','2022-06-05 12:00:00'),
        (648,3124,'LIKE','2022-06-18 12:00:00');


-- Approach 1


WITH temp_actions AS (
						SELECT 
								user_id,
								event_date,
								event_type,
								SUBSTR(event_date, 6, 2) - lag(SUBSTR(event_date, 6, 2)) OVER w AS difference
						FROM 
								user_actions
						WINDOW 
								w as (PARTITION BY user_id ORDER BY event_date)
				),

	temp_actions2 AS (
						SELECT 
								SUBSTR(event_date, 6, 2) AS months,
								COUNT(user_id) AS monthly_active_users
						FROM 	
								temp_actions
						WHERE 
								difference = 1 AND event_type IN ('LIKE', 'COMMENT', 'SIGN-IN')
						GROUP BY 
								months
				)
   
SELECT 
		months,
        monthly_active_users
FROM 
        temp_actions2;



-- Approach 2


 WITH temp_actions AS (
						SELECT 
								user_id,
								event_date,
								event_type,
								SUBSTR(event_date, 6, 2) - lag(SUBSTR(event_date, 6, 2)) OVER w AS difference
						FROM 
								user_actions
						WINDOW 
								w as (PARTITION BY user_id ORDER BY event_date)
					)
   
   
SELECT  
		SUBSTR(event_date, 6, 2) AS months,
		COUNT(DISTINCT user_id) AS active_users
FROM 	
		temp_actions
WHERE 
		difference = 1 
        AND 
        event_type IN ('LIKE', 'COMMENT', 'SIGN-IN')
GROUP BY 
		months;



-- Q.83 Write a Query to report the median of searches made by a user. 
-- Round the median to one decimal point.


CREATE TABLE search_frequency(
        searches INT,
        num_users INT
    );


INSERT INTO search_frequency VALUES
        (1,2),
        (2,2),
        (3,3),
        (4,1);


 WITH temp_search_freq AS (
							SELECT 
									searches,
									num_users,
									ROW_NUMBER() OVER(ORDER BY searches) row_num,
									COUNT(*) OVER(ORDER BY searches ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) total_records
							FROM
									search_frequency
					),
        
    temp_search_freq2 as (
							SELECT 
									searches,
									num_users,
									CASE
							WHEN total_records % 2 <>  0 THEN (
														SELECT 
																DISTINCT ROUND(SUM(searches) OVER w /
																COUNT(*) OVER w,1)
														FROM 
																temp_search_freq 
														WHERE 
																row_num = ROUND((total_records + 1) / 2, 0)
														WINDOW 
																w AS (ORDER BY searches ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
														
													)
													
							WHEN total_records % 2 = 0 THEN (
														SELECT 
																DISTINCT ROUND(SUM(searches) OVER w /
																COUNT(*) OVER w,1)
														FROM
																temp_search_freq 
														WHERE 
																row_num IN (total_records/2,(total_records/2)+1)
														WINDOW 
																w AS (ORDER BY searches ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
												)
							END AS median
							FROM 
                        temp_search_freq
            )
            

SELECT 
        DISTINCT median 
FROM 
        temp_search_freq2;



-- Q.84 Write a Query to update the Facebook advertisers status using the daily_pay table. 
-- Advertiser is a two-column table containing the user id and their payment status based 
-- on the last payment and daily_pay table has current information about their payment. 
-- Only advertisers who paid will show up in this table.
-- Output the user id and current payment status sorted by the user id.


CREATE TABLE advertiser(
        user_id VARCHAR(20),
        status ENUM('NEW','EXISTING','CHURN','RESURRECT')
    );


CREATE TABLE daily_pay(
        user_id VARCHAR(20),
        paid DECIMAL
    );


INSERT INTO advertiser VALUES
        ('BING','NEW'),
        ('YAHOO','NEW'),
        ('ALIBABA','EXISTING');


INSERT INTO daily_pay VALUES
        ('YAHOO',45.00),
        ('ALIBABA',100.00),
        ('TARGET',13.00);



SELECT 
        user_id, 
        CASE
            WHEN user_id IN (SELECT user_id FROM daily_pay) THEN 'EXISTING'
            ELSE 'CHURN'
            END AS new_status
FROM 
        advertiser
ORDER BY
		user_id;



-- Q.85 Write a SQL Query that calculates the total time that the fleet of 
-- servers was running. The output should be in units of full days.


CREATE TABLE server_utilization(
        server_id INT,
        session_status VARCHAR(20),
        status_time VARCHAR(25)
    );


INSERT INTO server_utilization VALUES
        (1,'start', '08/02/2022 10:00:00'),
        (1,	'stop',	'08/04/2022 10:00:00'),
        (2,	'stop',	'08/24/2022 10:00:00'),
        (2,	'start','08/17/2022 10:00:00');


-- Approach 1


SELECT 
		stop_time - start_time AS total_up_time
FROM
		(
			SELECT
					SUM(
						CASE
							WHEN session_status = 'start' then EXTRACT(DAY from STR_TO_DATE(status_time, '%m/%d/%y'))
							END
						) AS start_time,
					SUM(
						CASE
							WHEN session_status = 'stop' then EXTRACT(DAY from STR_TO_DATE(status_time, '%m/%d/%y'))
							END
						) AS stop_time
			FROM
					server_utilization
        ) temp_server_utilization;




-- Approach 2 (Works only in PostgreSQL)

WITH temp_server_utilization AS (
								SELECT
										server_id,
										status_time AS start_time,
										session_status,
										lead(status_time) OVER(ORDER BY server_id,status_time) AS end_time
								FROM
										server_utilization
)

SELECT 
        EXTRACT(DAY FROM justify_hours(SUM(end_time - start_time))) as total_time
FROM 
        temp_server_utilization 
WHERE 
        session_status = 'start';



-- Q.86 Sometimes, payment transactions are repeated by accident; it could be due to user error, 
-- API failure or a retry error that causes a credit card to be charged twice.
-- Using the transactions table, identify any payments made at the same merchant with the 
-- same credit card for the same amount within 10 minutes of each other. Count such repeated payments.


CREATE TABLE transactions(
        transaction_id INT,
        merchant_id INT,
        credit_card_id INT,
        amount INT,
        transaction_timestamp DATETIME
    );


INSERT INTO transactions VALUES
        (1,101,1,100,'2022-09-25 12:00:00'),
        (2,101,1,100,'2022-09-25 12:08:00'),
        (3,101,1,100,'2022-09-25 12:28:00'),
        (4,102,2,300,'2022-09-25 12:00:00'),
        (5,102,2,400,'2022-09-25 14:00:00');



WITH temp_transactions AS (
							SELECT 
									merchant_id, 
									credit_card_id, 
									amount, 
									transaction_timestamp,
									LAG(transaction_timestamp) OVER w AS prev_tran_timestamp,
									timestampdiff(MINUTE,LAG(transaction_timestamp) OVER w, transaction_timestamp) AS difference
							FROM 
									transactions
							WINDOW
									w as (PARTITION BY credit_card_id ORDER BY  transaction_timestamp)
            )
 
 SELECT 
        COUNT(DISTINCT merchant_id) AS payment_count
FROM 
        temp_transactions
 WHERE 
        difference <= 10;



-- Approach 2 (Works only in PostgreSQL)


WITH temp_transactions AS (
							SELECT 
									merchant_id, 
									credit_card_id, 
									amount, 
									transaction_timestamp,
									LAG(transaction_timestamp) OVER w AS prev_tran_timestamp,
									EXTRACT(EPOCH FROM LAG(transaction_timestamp) OVER w -  transaction_timestamp) AS difference
							FROM 
									transactions
							WINDOW
									w as (PARTITION BY credit_card_id ORDER BY  transaction_timestamp)
					)
 
 SELECT 
        COUNT(DISTINCT merchant_id) AS payment_count
FROM 
        temp_transactions
 WHERE 
        difference < 10;
        


-- Q.87 Write a SQL Query to find the bad experience rate in the first 14 days for new users who signed 
-- up in June 2022. Output the percentage of bad experience rounded to 2 decimal places.


CREATE TABLE orders(
        order_id INT,
        customer_id INT,
        trip_id INT,
        status ENUM('COMPLETED SUCCESSFULLY','COMPLETED INCORRECTLY','NEVER_RECEIVED'),
        order_timestamp VARCHAR(30)
    );


INSERT INTO orders VALUES  
        (727424,8472,100463,'COMPLETED SUCCESSFULLY','06/05/2022 09:12:00'),
        (242513,2341,100482,'COMPLETED INCORRECTLY','06/05/2022 14:40:00'),
        (141367,1314,100362,'COMPLETED INCORRECTLY','06/07/2022 15:03:00'),
        (582193,5421,100657,'NEVER_RECEIVED','07/07/2022 15:22:00'),
        (253613,1314,100213,'COMPLETED SUCCESSFULLY','06/12/2022 13:43:00');


CREATE TABLE trips(
        dasher_id INT,
        trip_id INT,
        estimated_delivery_timestamp VARCHAR(25),
        actual_delivery_timestamp VARCHAR(25)
    );


INSERT INTO TRIPS VALUES 
        (101,100463,'06/05/2022 09:42:00','06/05/2022 09:38:00'),
        (102,100482,'06/05/2022 15:10:00','06/05/2022 15:46:00'),
        (101,100362,'06/07/2022 15:33:00','06/07/2022 16:45:00'),
        (102,100657,'07/07/2022 15:52:00',NULL),
        (103,100213,'06/12/2022 14:13:00','06/12/2022 14:10:00');


CREATE TABLE customers(
        customer_id INT,
        signup_timestamp VARCHAR(30)
    );


INSERT INTO customers VALUES    
        (8472,'05/30/2022 00:00:00'),
        (2341,'06/01/2022 00:00:00'),
        (1314,'06/03/2022 00:00:00'),
        (1435,'06/05/2022 00:00:00'),
        (5421,'06/07/2022 00:00:00');



SELECT 
        ROUND(
            SUM(
                CASE
                    WHEN status !='completed successfully'  THEN 1 ELSE 0
                    END 
                )*100.0/count(*),2)  AS bad_experience_pct
FROM 
        customers C
INNER JOIN 
        orders O 
ON 
        o.customer_id = c.customer_id
WHERE 
        o.order_timestamp < date_add(STR_TO_date(signup_timestamp, '%m/%d/%Y'), INTERVAL 14 DAY) 
        AND 
        MONTH(STR_TO_date(signup_timestamp, '%m/%d/%Y')) = 06 
        AND 
        YEAR(STR_TO_date(signup_timestamp, '%m/%d/%Y')) = 2022;




-- Q.88 SAME AS 68



-- Q.89 SAME AS 55



-- Q.90 Write an SQL Query to report the median of all the numbers in the database 
-- after decompressing the numbers table. Round the median to one decimal point.


CREATE TABLE numbers(
        num INT,
        frequency INT
    );


INSERT INTO numbers VALUES  
        (0,7),
        (1,1),
        (2,3),
        (3,1);



WITH RECURSIVE num_frequency (num,frequency, i) AS 
					(
						SELECT  num,
								frequency,1
						FROM   
								numbers
						UNION ALL
						SELECT   num,
								frequency,
								i+1
						FROM    
								num_frequency
						WHERE   
								num_frequency.i < num_frequency.frequency
				),
        
	num_frequency2 AS (
						SELECT 
								num, 
								frequency, 
								row_number() OVER(ORDER BY num, frequency) AS row_num,
								COUNT(*) OVER(ORDER BY  num, frequency ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS total_records
						FROM    
								num_frequency
				)


SELECT	
		DISTINCT CASE
					WHEN total_records % 2 <>  0 THEN (
                                                SELECT 
                                                        DISTINCT ROUND(SUM(num) OVER w /
                                                        COUNT(*) OVER  w, 1)
						                        FROM 
                                                        num_frequency2 
                                                WHERE 
                                                        row_num = ROUND((total_records + 1) / 2, 0)
												WINDOW
														w as (ORDER BY  num, frequency ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
                        
                    WHEN total_records % 2 = 0 THEN (
                                                SELECT 
                                                        DISTINCT ROUND(SUM(num) OVER w /
                                                        COUNT(*) OVER w, 1)
						                        FROM 
                                                        num_frequency2 
                                                WHERE 
                                                        row_num IN (total_records/2,(total_records/2)+1)
												WINDOW
														w as (ORDER BY  num, frequency ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))       
                    END AS median
FROM 
        num_frequency2;



-- Q.91 Write an SQL Query to report the comparison result (higher/lower/same) of the average salary of 
-- employees in a department to the companys average salary. Return the result table in any order.


CREATE TABLE salary(
        id INT,
        employee_id INT,
        amount INT,
        paydate DATE,
        CONSTRAINT prime_key PRIMARY KEY(id)
    );


CREATE TABLE employee(
        employee_id INT,
        department_id INT,
        CONSTRAINT prime_key PRIMARY KEY(employee_id)
    );


INSERT INTO salary VALUES
        (1,1,9000,'2017/03/31'),
        (2,2,6000,'2017/03/31'),
        (3,3,10000,'2017/03/31'),
        (4,1,7000,'2017/02/28'),
        (5,2,6000,'2017/02/28'),
        (6,3,8000,'2017/02/28');


INSERT INTO employee VALUES
        (1,1),
        (2,2),
        (3,2);
        




WITH temp_comparison AS (
						SELECT 
								s.employee_id, 
								e.department_id,
								s.amount, 
								s.paydate,
								avg(amount) OVER (PARTITION BY MONTH(paydate) ORDER BY month(paydate), employee_id 
													ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) company_avg_salary,
								avg(amount) OVER (PARTITION BY MONTH(paydate), department_id order by month(paydate) 
													ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) department_avg 
						FROM
								salary s
						INNER JOIN 
								employee e
						ON 
								e.employee_id = s.employee_id
            )
 
 SELECT 
        DISTINCT DATE_FORMAT(paydate, '%Y-%m') AS pay_month, 
        department_id,
        CASE
            WHEN company_avg_salary = department_avg THEN 'same'
            WHEN company_avg_salary > department_avg THEN 'lower'
            WHEN company_avg_salary < department_avg THEN 'higher'
            END AS comparison
 FROM 
        temp_comparison;



-- Q.92 Write an SQL Query to report for each install date, the number of players 
-- that installed the game on that day, and the day one retention.


CREATE TABLE activity(
        player_id INT,
        device_id INT,
        event_date DATE,
        games_played INT,
        CONSTRAINT prime_key PRIMARY KEY(player_id, event_date)
    );


INSERT INTO activity VALUES 
        (1,2,'2016-03-01',5),
        (1,2,'2016-03-02',6),
        (2,3,'2017-06-25',1),
        (3,1,'2016-03-01',0),
        (3,4,'2018-07-03',5);


-- Approach 1


SELECT 
        a.event_date AS install_date, 
        COUNT(a.player_id) AS installs, 
        ROUND(COUNT(b.player_id) / COUNT(a.player_id), 2) AS day1_retention
FROM
        (
            SELECT 
                    player_id, 
                    MIN(event_date) AS event_date
            FROM 
                    activity 
            GROUP BY 
                    player_id
		) a
LEFT JOIN 
        activity b
ON 
        a.player_id = b.player_id 
        AND 
        a.event_date + 1 = b.event_date
GROUP BY 
        a.event_date;


-- Approach 2


SELECT 
        a1.event_date AS install_dt, 
        COUNT(a1.player_id) AS installs, 
        ROUND(COUNT(a3.player_id) / COUNT(a1.player_id), 2) AS day1_retention
FROM 
        activity a1 
LEFT JOIN 
        activity a2
ON 
        a1.player_id = a2.player_id 
        AND 
        a1.event_date > a2.event_date
LEFT JOIN 
        activity a3
ON 
        a1.player_id = a3.player_id 
        AND 
        DATEDIFF(a3.event_date, a1.event_date) = 1
WHERE 
        a2.event_date IS NULL
GROUP BY 
        a1.event_date;



-- Q.93 SAME AS 50



-- Q.94 Write an SQL Query to report the students (student_id, student_name) being -- Quiet in all exams. 
-- Do not return the student who has never taken any exam.


CREATE TABLE student(
        student_id INT,
        student_name VARCHAR(20),
        CONSTRAINT prime_key PRIMARY KEY(student_id)
    );


CREATE TABLE exam(
        exam_id INT,
        student_id INT,
        score INT,
        CONSTRAINT prime_key PRIMARY KEY(exam_id,student_id)
    );


INSERT INTO student VALUES 
        (1,'DANIEL'),
        (2,'JADE'),
        (3,'STELLA'),
        (4,'JONATHAN'),
        (5,'WILL');


INSERT INTO exam VALUES
        (10,1,70),
        (10,2,80),
        (10,3,90),
        (20,1,80),
        (30,1,70),
        (30,3,80),
        (30,4,90),
        (40,1,60),
        (40,2,70),
        (40,4,80);


-- Approach 1

WITH temp_examination AS (
							SELECT 
									exam_id,
									student_id,
									score,
									max(score) OVER w AS highest,
									min(score) OVER w AS lowest
							FROM
									exam
									WINDOW w AS (PARTITION BY exam_id)
					),
    
		temp_examination1 AS (
								SELECT 
										DISTINCT student_id 
								FROM 
										temp_examination 
								WHERE 
										score IN (lowest, highest)
						)

    SELECT 
            DISTINCT s.student_id,
            s.student_name
    FROM 
            temp_examination 
    INNER JOIN 
            student s 
    ON 
            s.student_id = temp_examination.student_id
    WHERE 
            s.student_id NOT IN (SELECT student_id FROM temp_examination1);



-- Approach 2


WITH temp_examination AS (
							SELECT 
									student_id, 
							CASE
								WHEN score < max(score) OVER(PARTITION BY exam_id) AND score >min(score) OVER(PARTITION BY exam_id) THEN 0
								ELSE 1
								END AS category
							FROM
									exam 
							ORDER BY 
									student_id
            ),
    
    temp_examination1 AS (
							SELECT 
									student_id, 
									SUM(category) AS high_low_count
							FROM 
									temp_examination
							GROUP BY 
									student_id
            )
        

        
    SELECT 
            s.student_id,
            s.student_name
    FROM 
            student s  
    INNER JOIN 
            temp_examination1
    ON 
            s.student_id = temp_examination1.student_id
	WHERE 
			high_low_count = 0
    ORDER BY 
            temp_examination1.student_id;



-- Q.95 SAME AS 94



-- Q.96 Write a query to output the user id, song id, and cumulative count of song plays as of 4 August 2022 
-- sorted in descending order.


CREATE TABLE songs_history(
		history_id INT,
		user_id INT,
		song_id INT,
		song_plays INT
	);


INSERT INTO songs_history VALUES
		(10011,777,1238,11),
		(12452,695,4520,1);


CREATE TABLE songs_weekly(
		user_id INT,
		song_id INT,
		listen_time VARCHAR(25)
	);


INSERT INTO songs_weekly VALUES
		(777,1238,'08/01/2022 12:00:00'),
		(695,4520,'08/04/2022 08:00:00'),
		(125,9630,'08/04/2022 16:00:00'),
		(695,9852,'08/07/2022 12:00:00');



WITH streaming AS (
                    SELECT 
                            user_id, 
                            song_id, 
                            song_plays
                    FROM 
                            songs_history

                    UNION ALL

                    SELECT 
                            user_id, 
                            song_id, 
                            count(*) AS song_plays
                    FROM 
                            songs_weekly
                    WHERE 
							listen_time <= '08/04/2022 23:59:59'
                    GROUP by 
                            user_id, 
                            song_id
                )

SELECT 
        user_id, 
        song_id, 
        SUM(song_plays) as song_plays
FROM 
        streaming
GROUP BY 
        user_id, 
        song_id
ORDER BY 
        song_plays DESC;



-- Q.97 Write a query to find the confirmation rate of users who confirmed their signups with text messages. 
-- Round the result to 2 decimal places.


CREATE TABLE emails(
		email_id INT,
		user_id INT,
		signup_date DATETIME
	);


INSERT INTO emails VALUES
		(125,7771,'2022-06-14 00:00:00'),
		(236,6950,'2022-07-01 00:00:00'),
		(433,1052,'2022-07-09 00:00:00');


CREATE TABLE texts(
		text_id INT,
		email_id INT,
		signup_action VARCHAR(20)
	);


INSERT INTO texts VALUES
		(6878,125,'CONFIRMED'),
		(6920,236,'NOT CONFIRMED'),
		(6994,236,'CONFIRMED');



WITH temp_confirmation AS (
							SELECT 
									e.email_id,
									CASE
										WHEN signup_action = 'Confirmed' THEN 1
										END 
										AS confirmed_users
							FROM 
									emails e
							LEFT JOIN 
									texts t
							ON 
									e.email_id = t.email_id 
									AND 
									t.signup_action = 'Confirmed'
					)


SELECT 
        ROUND(SUM(confirmed_users)/COUNT(email_id),2) AS confirm_rate
FROM 
        temp_confirmation;



-- Q.98 Calculate the 3-day rolling average of tweets published by each user for each date 
-- that a tweet was posted. Output the user id, tweet date, and rolling averages rounded to 2 decimal places.


CREATE TABLE tweets(
		tweet_id INT,
		user_id INT,
		tweet_date DATETIME
	);


INSERT INTO TWEETS VALUES
		(214252,111,'2022-06-01 12:00:00'),
		(739252,111,'2022-06-01 12:00:00'),
		(846402,111,'2022-06-02 12:00:00'),
		(241425,254,'2022-06-02 12:00:00'),
		(137374,111,'2022-06-04 12:00:00');


WITH temp_tweets AS (
                SELECT 
                        user_id, 
                        tweet_date, 
                        COUNT(tweet_id) AS tweets_count
                FROM 
                        tweets
                GROUP BY 
                        user_id, 
                        tweet_date
                ORDER BY 
                        user_id, 
                        tweet_date
            )

SELECT 
        user_id, 
        tweet_date,
        ROUND(avg(tweets_count) 
        OVER(PARTITION BY user_id ORDER BY tweet_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS rolling_avg_3days
FROM
        temp_tweets;



-- Q.99 Write a query to obtain a breakdown of the time spent sending vs. opening snaps 
-- (as a percentage of total time spent on these activities) for each age group.


CREATE TABLE activities(
		activity_id INT,
		user_id INT,
		activity_type ENUM('SEND','OPEN','CHAT'),
		time_spent FLOAT,
		activity_date varchar(25)
	);


INSERT INTO activities VALUES
		(7274,123,'OPEN',4.50,'06/22/2022 12:00:00'),
		(2425,123,'SEND',3.50,'06/22/2022 12:00:00'),
		(1413,456,'SEND',5.67,'06/23/2022 12:00:00'),
		(1414,789,'CHAT',11.00,'06/25/2022 12:00:00'),
		(2536,456,'OPEN',3.00,'06/25/2022 12:00:00');
        

CREATE TABLE age_breakdown(
		user_id INT,
		age_bucket ENUM('21-25','26-30','31-35')
		);


INSERT INTO age_breakdown VALUES
		(123,'31-35'),
		(456,'26-30'),
		(789,'21-25');
        
        
        
WITH temp_activities AS (
							SELECT 
									user_id, 
									activity_type,
									sum(time_spent) time_spent,
									CASE
										WHEN activity_type = 'open' THEN sum(time_spent)
										ELSE 0
										END opening_snap,
									CASE
										WHEN activity_type = 'send' THEN sum(time_spent)
										ELSE 0
										END sending_snap
							FROM 
									activities
							WHERE 
									activity_type in ('open','send')
							GROUP BY 
									user_id, 
									activity_type
							ORDER BY 
									user_id
					),

    temp_activities2 AS (
							SELECT 
									user_id, 
									SUM(opening_snap) time_sending,
									SUM(sending_snap) time_opening
							FROM 
									temp_activities
							GROUP BY 
									user_id
					)

SELECT 
        ab.age_bucket, 
        ROUND(time_opening * 100.0 /(time_sending+time_opening), 2) AS send_perc,
        ROUND(time_sending * 100.0 /(time_sending+time_opening), 2) AS open_perc
FROM 
        temp_activities2
INNER JOIN 
        age_breakdown ab 
ON 
        ab.user_id = temp_activities2.user_id
ORDER BY 
        ab.age_bucket;



-- Q.100 Write a query to return the IDs of these LinkedIn power creators in ascending order.


CREATE TABLE personal_profiles(
		profile_id INT,
		name VARCHAR(20),
		followers INT
	);


INSERT INTO personal_profiles VALUES
		(1,'NICK SINGH',92000),
		(2,'ZACH WILSON',199000),
		(3,'DALIANA LIU',171000),
		(4,'RAVIT JAIN',107000),
		(5,'VIN VASHISHTA',139000),
		(6,'SUSAN WOJCICKI',39000);


CREATE TABLE employee_company(
		personal_profile_id INT,
		company_id INT
	);


INSERT INTO employee_company VALUES
		(1,4),
		(1,9),
		(2,2),
		(3,1),
		(4,3),
		(5,6),
		(6,5);


CREATE TABLE company_pages(
		company_id INT,
		name VARCHAR(30),
		followers INT
	);


INSERT INTO company_pages VALUES
		(1,'THE DATA SCIENCE PODCAST',8000),
		(2,'AIRBNB',700000),
		(3,'THE RAVIT SHOW',6000),
		(4,'DATA LEMUR',200),
		(5,'YOUTUBE',16000000),
		(6,'DATASCIENCE.VIN',4500),
		(9,'ACE THE DATA SCIENCE INTERVIEW',4479);



SELECT 
        DISTINCT p.profile_id 
FROM 
        personal_profiles p 
INNER JOIN 
		employee_company ec
ON
		p.profile_id = ec.personal_profile_id
INNER JOIN 
        company_pages c 
ON 
        ec.company_id = c.company_id
WHERE 
        p.followers > c.followers
ORDER BY 
        p.profile_id;



-- Q.101 Write an SQL query to show the second most recent activity of each user.
-- If the user only hAS one activity, return that one. A user cannot perform more than one activity at the same time.
-- Return the result table in any order.


CREATE TABLE user_activity(
		username VARCHAR(20),
		activity VARCHAR(20),
		start_date DATE,
		end_date DATE
	);


INSERT INTO user_activity VALUES
		('ALICE','TRAVEL','2020-02-12','2020-02-20'),
		('ALICE','DANCING','2020-02-21','2020-02-23'),
		('ALICE','TRAVEL','2020-02-24','2020-02-28'),
		('BOB','TRAVEL','2020-02-11','2020-02-18'); 


        
WITH temp_activity AS (
                        SELECT 
                                username, 
                                activity, 
                                start_date, 
                                end_date,
                                ROW_NUMBER() OVER(PARTITION BY username ORDER BY start_date, end_date) row_num,
                                COUNT(*) OVER(PARTITION BY username ORDER BY start_date, end_date
                                                rows between unbounded preceding and unbounded following) total_activities
                        FROM 
                                user_activity
            ),
    temp_activity2 AS (
                        SELECT 
                                username, 
                                activity, 
                                start_date, 
                                end_date,
                                IF(total_activities = 1 and row_num = 1, 2, row_num) AS ranking
                        FROM 
                                temp_activity
            )
 
SELECT 
        username, 
        activity, 
        start_date, 
        end_date 
FROM 
        temp_activity2
WHERE 
        ranking = 2;



-- Q.102 SAME AS 101


-- Q.103 Query the name of any student in students who scored higher than 75 Marks. Order your output 
-- by the last three characters of each name. If two or more students both have names ending in the same 
-- last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending id.


CREATE TABLE students(
		id INT,
		name VARCHAR(20),
		marks INT
	);


INSERT INTO students VALUES
		(1,'ASHLEY',81),
		(2,'SAMANTHA',75),
		(3,'JULIA',76),
		(4,'BELVET',84);



SELECT 
        name 
FROM 
        students 
WHERE 
        marks > 75 
ORDER BY 
        RIGHT(name,3),
        id;


-- Q.104 Write a Query that prints a list of employee names (i.e.: the name attribute) 
-- for employees in employee HAVING a salary greater than $2000 per month who have 
-- been employees for less than 10 months. Sort your result by ascending employee_id.


CREATE TABLE employee(
		employee_id INT,
		name VARCHAR(20),
		month INT,
		salary INT
	);


INSERT INTO employee VALUES
		(12228,'ROSE',15,1968),
		(33645,'ANGELA',1,3443),
		(45692,'FRANK',17,1608),
		(56118,'PATRICK',7,1345),
		(59725,'LISA',11,2330),
		(74197,'KIMBERLY',16,4372),
		(78454,'BONNIE',8,1771),
		(83565,'MICHAEL',6,2017),
		(98607,"TODD",5,3396),
		(99989,'JOE',9,3573);



SELECT 
        name 
FROM 
        employee 
WHERE 
        salary > 2000 
        AND 
        months < 10 
ORDER BY 
        employee_id;



-- Q.105 Write a Query identifying the type of each record in the TRIANGLES table using its three side lengths.


CREATE TABLE triangles(
		a INT,
		b INT,
		c INT
	);


INSERT INTO triangles VALUES
		(20,20,23),
		(20,20,20),
		(20,21,22),
		(13,14,30);



SELECT 
		a,
		b,
        c, 
        CASE
			WHEN a + b <= c OR b + c <= a OR a + c <= b THEN 'NOT A TRIANGLE'
			WHEN a = b AND b = c THEN 'EQUILATERAL' 
			WHEN a = b OR b = c OR c = a THEN 'ISSOCELES' 
            WHEN a <> b AND b <> c THEN 'SCALEAN'
            END AS type_of_triangle
FROM 
		triangles;



-- Q.106 Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), 
-- and round it up to the next integer.


CREATE TABLE employees(
		id INT,
		name VARCHAR(20),
		salary INT
	);

INSERT INTO employees VALUES
		(1,'KRISTEEN',1420),
		(2,'ASHLEY',2006),
		(3,'JULIA',2210),
		(4,'MARIA',3000);


SELECT 
        ceil(avg(salary) - avg(replace(salary, '0', ''))) AS error
FROM 
        employees;


-- Q.107 Write a query to find the maximum total earnings for all employees as
-- well as the total number of employees who have maximum total earnings. 
-- Then print these values as 2 space-separated integers.


CREATE TABLE employee(
		employee_id INT,
		name VARCHAR(20),
		months INT,
		salary INT
	);


INSERT INTO employee VALUES
		(12228,'ROSE',15,1968),
		(33645,'ANGELA',1,3443),
		(45692,'FRANK',17,1608),
		(56118,'PATRICK',7,1345),
		(59725,'LISA',11,2330),
		(74197,'KIMBERLY',16,4372),
		(78454,'BONNIE',8,1771),
		(83565,'MICHAEL',6,2017),
		(98607,"TODD",5,3396),
		(99989,'JOE',9,3573);



SELECT 
        MAX(salary*months) as total_earnings,
        COUNT(*) 
FROM 
        employee
WHERE 
        (salary*months) in (
                            SELECT 
                                    MAX(months * salary) 
                            FROM 
                                    employee
                            );



-- Q.108 a. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed 
-- by the first letter of each profession AS a parenthetical (i.e.: enclosed in parentheses). 


-- b. WHERE [occupation_COUNT] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] 
-- is the lowerCASE occupation name. If more than one Occupation hAS the same [occupation_COUNT], 
-- they should be ordered alphabetically.


CREATE TABLE occupations(
		name VARCHAR(20),
		occupation VARCHAR(20)
	);


INSERT INTO occupations VALUES
		('SAMNATHA','DOCTOR'),
		('JULIA','ACTOR'),
		('MARIA','ACTOR'),
		('MEERA','SINGER'),
		('ASHLEY','PROFESSOR'),
		('KETTY','PROFESSOR'),
		('CHRISTEEN','PROFESSOR'),
		('JANE','ACTOR'),
		('JENNY','DOCTOR'),
		('PRIYA','SINGER');



-- a. 

SELECT 
        CONCAT(name, '(',substring(occupation, 1, 1),')') as `name(occupation)`
FROM 
        occupations 
ORDER BY 
        name;



-- b. 

SELECT 
        CONCAT("There are a total of ", 
        COUNT(*),' ', lower(occupation), 's.')  AS info
FROM 
        occupations 
GROUP BY 
        occupation 
ORDER BY 
        COUNT(occupation), 
        occupation;



-- Q.109 Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically 
-- and displayed underneath its corresponding Occupation. The output column headers should be 
-- Doctor, Professor, Singer, and Actor, respectively.


CREATE TABLE occupations(
		name VARCHAR(20),
		occupation VARCHAR(20)
	);


INSERT INTO occupations VALUES
		('SAMNATHA','DOCTOR'),
		('JULIA','ACTOR'),
		('MARIA','ACTOR'),
		('MEERA','SINGER'),
		('ASHLEY','PROFESSOR'),
		('KETTY','PROFESSOR'),
		('CHRISTEEN','PROFESSOR'),
		('JANE','ACTOR'),
		('JENNY','DOCTOR'),
		('PRIYA','SINGER');



SELECT 
        MAX(CASE WHEN occupation = 'Doctor' then name END) AS Doctor,
        MAX(CASE WHEN occupation = 'Professor' then name END) AS Professor,
        MAX(CASE WHEN occupation = 'Singer' then name END) AS Singer,
        MAX(CASE WHEN occupation = 'Actor' then name END) AS Actor
FROM 
        (
            SELECT 
                    name,
                    occupation,
                    row_number() over(partition by occupation order by name) AS row_num 
            FROM 
                    occupations
        ) AS base 
GROUP BY 
        row_num;



-- Q.110 Write a query to find the node type of Binary Tree ordered by the value of the node. 
-- Output one of the following for each node:
-- ● Root: If node is root node.
-- ● Leaf: If node is leaf node.
-- ● Inner: If node is neither root nor leaf node.


CREATE TABLE bst(
		n INT,
		p INT
	);


INSERT INTO bst VALUES
		(1,2),
		(3,2),
		(6,8),
		(9,8),
		(2,5),
		(8,5),
		(5,NULL);



SELECT 
        n, 
        CASE 
            WHEN n NOT IN (SELECT DISTINCT p FROM bst WHERE p IS NOT NULL)  THEN 'Leaf'
            WHEN p IS NULL THEN 'Root'
            ELSE 'Inner'
            END AS type
FROM 
        bst
ORDER BY
         n;



-- Q.111 Given the table schemas below, write a query to print the company_code, 
-- founder name, total number of lead managers, total number of senior managers, 
-- total number of managers, and total number of employees. Order your output by 
-- ascending company_code.


CREATE TABLE company(
		company_code VARCHAR(20),
		founder VARCHAR(20)
	);


CREATE TABLE lead_manager(
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


CREATE TABLE senior_manager(
		senior_manager_code VARCHAR(20),
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


CREATE TABLE manager(
		manager_code VARCHAR(20),
		senior_manager_code VARCHAR(20),
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


CREATE TABLE employee(
		employee_code VARCHAR(20),
		manager_code VARCHAR(20),
		senior_manager_code VARCHAR(20),
		lead_manager_code VARCHAR(20),
		company_code VARCHAR(20)
	);


INSERT INTO company VALUES
		('C1','MONIKA'),
		('C2','SAMANTHA');


INSERT INTO lead_manager VALUES
		('LM1','C1'),
		('LM2','C2');


INSERT INTO senior_manager VALUES
		('SM1','LM1','C1'),
		('SM2','LM1','C1'),
		('SM3','LM2','C2');    


INSERT INTO manager VALUES
		('M1','SM1','LM1','C1'),
		('M2','SM3','LM2','C2'),
		('M3','SM3','LM2','C2');  


INSERT INTO employee VALUES
		('E1','M1','SM1','LM1','C1'),
		('E2','M1','SM1','LM1','C1'),
		('E3','M2','SM3','LM2','C2'),
		('E4','M3','SM3','LM2','C2');



SELECT 
        c.company_code, 
        c.founder, 
        COUNT(DISTINCT lm.lead_manager_code), 
        COUNT(DISTINCT sm.senior_manager_code),
        COUNT(DISTINCT m.manager_code),
        COUNT(DISTINCT e.employee_code)
FROM 
        company c
INNER JOIN 
        lead_manager lm
ON 
        c.company_code = lm.company_code
INNER JOIN 
        senior_manager sm
ON 
        sm.lead_manager_code = lm.lead_manager_code
INNER JOIN  
        manager m
ON 
        m.senior_manager_code = sm.senior_manager_code
INNER JOIN  
        employee e
ON 
        e.manager_code = m.manager_code
GROUP BY 
        c.company_code, c.founder
ORDER BY 
        c.company_code;



-- Q.112 Write a query to print all prime numbers less than or equal to 1000. 
-- Print your result on a single line, and use the ampersand () character as 
-- your separator (instead of a space).


WITH RECURSIVE number_generation AS (
                                        SELECT 
                                                1 num

                                        UNION ALL

                                        SELECT 
                                                num + 1 
                                        FROM 
                                                number_generation 
                                        WHERE 
                                                num<1000
                    ),
                number_generation2 AS (
                                        SELECT 
                                                n1.num AS numm 
                                        FROM 
                                                number_generation n1
                                        INNER JOIN 
                                                number_generation n2
                                        WHERE 
                                                n1.num % n2.num = 0
                                        GROUP BY 
                                                n1.num
                                        HAVING 
                                                COUNT(n1.num) = 2
                    )


SELECT 
        group_concat(numm ORDER BY numm SEPARATOR '&') AS prime_numbers 
FROM 
        number_generation2;



-- Q.113 Write a query to print the pattern P(20).



WITH RECURSIVE generate_numbers AS   
                                    (
                                        SELECT 
                                                1 AS n

                                        UNION 

                                        SELECT 
                                                n+1 
                                        FROM 
                                                generate_numbers 
                                        WHERE 
                                                n<20
                                    ) 

SELECT 
        repeat('*',n) 
FROM 
        generate_numbers;



-- Q.114 Write a query to print the pattern P(20).



WITH RECURSIVE generate_numbers AS   
                                    (
                                        SELECT 
                                                20 AS n

                                        UNION 

                                        SELECT 
                                                n-1 
                                        FROM 
                                                generate_numbers 
                                        WHERE 
                                                n>1
                                    ) 

SELECT 
        repeat('*',n) 
FROM 
        generate_numbers;



-- Q.115 SAME AS Q.103



-- Q.116 SAME AS Q.79



-- Q.117 SAME AS Q.104



-- Q.118 SAME AS Q.105



-- Q.119 SAME AS Q.80



-- Q.120 SAME AS Q.81



-- Q.121 SAME AS Q.82



-- Q.122 SAME AS Q.83



-- Q.123 SAME AS Q.84



-- Q.124 SAME AS Q.85



-- Q.125 SAME AS Q.86



-- Q.126 SAME AS Q.87



-- Q.127 SAME AS Q.68



-- Q.128 SAME AS Q.55



-- Q.129 SAME AS Q.90



-- Q.130 SAME AS Q.91



-- Q.131 SAME AS Q.92



-- Q.132 SAME AS Q.50



-- Q.133 SAME AS Q.94



-- Q.134 SAME AS Q.94



-- Q.135 SAME AS Q.101



-- Q.136 SAME AS Q.101



-- Q.137 SAME AS Q.106



-- Q.138 SAME AS Q.105



-- Q.139 SAME AS Q.105



-- Q.140 SAME AS Q.105



-- Q.141 SAME AS Q.110



-- Q.142 SAME AS Q.111



-- Q.143 Write a query to output all such symmetric pairs in ascENDing order by the value of X. 
-- List the rows such that X1 ≤ Y1.


CREATE TABLE functions(
		x INT,
		y INT
	);


INSERT INTO functions VALUES
		(20,20),
		(20,20),
		(20,21),
		(23,22),
		(22,23),
		(21,20);



WITH temp_functions AS (
                        SELECT 
                                x,
                                y, 
                                ROW_NUMBER() OVER (ORDER BY x, y) AS row_num
                        FROM 
                                functions
                )

SELECT 
        DISTINCT f1.x, 
        f1.y
FROM 
        temp_functions f1
INNER JOIN 
        temp_functions f2 
ON 
        f1.x = f2.y 
AND 
        f1.y = f2.x 
AND 
        f1.row_num <> f2.row_num
WHERE 
        f1.x <= f1.y
ORDER BY 
        f1.x;



-- Q.144 Write a query to output the names of those students whose best friENDs got offered a higher 
-- salary than them. Names must be ordered by the salary amount offered to the best friENDs. 
-- It is guaranteed that no two students get the same salary offer.


CREATE TABLE students(
		id INT,
		name VARCHAR(20)
	);


CREATE TABLE friends(
		id INT,
		friend_id INT
	);


CREATE TABLE packages(
		id INT,
		salary FLOAT
	);


INSERT INTO students VALUES
		(1,'ASHLEY'),
		(2,'SAMANTHA'),
		(3,'JULIA'),
		(4,'SCARLET');


INSERT INTO friends VALUES
		(1,2),
		(2,3),
		(3,4),
		(4,1);


INSERT INTO packages VALUES
		(1,15.20),
		(2,10.06),
		(3,11.55),
		(4,12.12);



SELECT 
        s1.name 
FROM 
        friends f1
INNER JOIN 
        students s1
ON 
        f1.id = s1.id
INNER JOIN 
        students s2
ON 
        f1.friend_id = s2.id
INNER JOIN 
        packages p1
ON 
        f1.id = p1.id
INNER JOIN 
        packages p2
ON 
        f1.friend_id = p2.id
WHERE 
        p1.salary < p2.salary
ORDER BY 
        p2.salary;



-- Q.145 Write a query to print the respective hacker_id and name of hackers who achieved full scores for 
-- more than one challenge. Order your output in descENDing order by the total number of challenges in 
-- which the hacker earned a full score. If more than one hacker received full scores in the same number 
-- of challenges, then sort them by ascending hacker_id.


CREATE TABLE hackers(
		hacker_id INT,
		name VARCHAR(20)
	);


CREATE TABLE difficulty(
		difficulty_level INT,
		score INT
	);


CREATE TABLE challenges(
		challenge_id INT,
		hacker_id INT,
		difficulty_level INT
	);


CREATE TABLE submissions(
		submission_id INT,
		hacker_id INT,
		challenge_id INT,
		score INT
	);


INSERT INTO hackers VALUES
		(5580,'ROSE'),
		(8439,'ANGELA'),
		(27205,'FRANK'),
		(52243,'PATRICK'),
		(52348,'LISA'),
		(57645,'KIMBERLY'),
		(77726,'BONNIE'),
		(83082,'MICHAEL'),
		(86870,'TODD'),
		(90411,'JOE');


INSERT INTO difficulty VALUES
		(1,20),
		(2,30),
		(3,40),
		(4,60),
		(5,80),
		(6,100),
		(7,120);


INSERT INTO challenges VALUES
		(4810,77726,4),
		(21089,27205,1),
		(26566,5580,7),
		(66730,52243,6),
		(71055,52243,2);
 


SELECT 
        h.hacker_id, 
        h.name 
FROM 
        hackers h
INNER JOIN  
        submissions s
ON 
        h.hacker_id = s.hacker_id
INNER JOIN 
        challenges c
ON 
        s.challenge_id = c.challenge_id
INNER JOIN 
        difficulty d
ON 
        c.difficulty_level = d.difficulty_level
WHERE 
        s.score = d.score
GROUP BY 
        h.name, h.hacker_id
HAVING 
        COUNT(s.score) > 1
ORDER BY 
        COUNT(s.challenge_id) desc,
        h.hacker_id;



-- Q.146 Write a query to output the start and END dates of projects listed by the number of days it took 
-- to complete the project in ascending order. If there is more than one project that have the same number 
-- of completion days, then order by the start date of the project.



CREATE TABLE projects(
		task_id INT,
		start_date DATE,
		end_date DATE
	);


INSERT INTO projects VALUES
		(1,'2015-10-01','2015-10-02'),
		(2,'2015-10-02','2015-10-03'),
		(3,'2015-10-03','2015-10-04'),
		(4,'2015-10-13','2015-10-14'),
		(5,'2015-10-14','2015-10-15'),
		(6,'2015-10-28','2015-10-29'),
		(7,'2015-10-30','2015-10-31');



-- Approach 1


WITH project_start AS 
                    (
                        SELECT 
                                start_date, 
                                ROW_NUMBER() OVER() AS ps_rownum
                        FROM 
                                projects
                        WHERE start_date not in (
                                                    SELECT 
                                                            end_date 
                                                    FROM 
                                                            projects
                                                )
                    ),
    project_end AS 
                 (
                        SELECT 
                                end_date, 
                                ROW_NUMBER() OVER() AS pe_rownum
                        FROM 
                                projects
                        WHERE 
                                END_date not in (
                                                    SELECT 
                                                            start_date 
                                                    FROM 
                                                            projects
                                                )
                )

SELECT 
        project_start.start_date, 
        project_end.end_date
FROM 
        project_start
INNER JOIN 
        project_end
on 
        project_end.pe_rownum = project_start.ps_rownum
ORDER BY 
        DATEDIFF(project_start.start_date, project_end.end_date) desc, 
        project_start.start_date;



-- Approach 2



WITH temp_project AS (
                    SELECT 
                            temp.start_date, 
                            temp.end_date,
                            SUM(
                                CASE
                                    WHEN previous_end_date IS NULL THEN 0
                                    WHEN DAY(end_date) - DAY(previous_end_date) = 1 THEN 0
                                    ELSE 1
                                END
                                ) OVER(ORDER BY start_date) AS project_num
                    FROM (
                            SELECT 
                                    start_date, 
                                    end_date,
                                    LAG(end_date) OVER (ORDER BY start_date) AS previous_end_date
                            FROM 
                                    projects
                    ) temp
)

SELECT 
        MIN(start_date) AS project_start_date, 
        MAX(end_date) as project_end_date
FROM 
        temp_project
GROUP BY 
        project_num
ORDER BY 
        DAY(MAX(end_date))-DAY(MIN(start_date));



-- Approach 3



WITH temp_project AS (
                        SELECT 
                                temp.start_date, 
                                temp.end_date,
                                SUM(
                                    CASE
                                    WHEN previous_end_date IS NULL THEN 0
                                    WHEN DAY(end_date) - DAY(previous_end_date) = 1 THEN 0
                                    ELSE 1
                                    END
                                    )  over(order by start_date range between unbounded preceding and current row) AS project_num
                        FROM (
                                SELECT 
                                        start_date, 
                                        end_date,
                                        LAG(end_date) OVER (ORDER BY start_date) AS previous_end_date
                                FROM 
                                        projects
                ) temp
            )

SELECT 
        MIN(start_date) AS project_start_date,
        MAX(end_date) AS project_end_date
FROM 
        temp_project
GROUP BY 
        project_num
ORDER BY 
        DAY(MAX(end_date))-DAY(MIN(start_date));




-- Q.147 In an effort to identify high-value customers, Amazon asked for your help to obtain data 
-- about users who go on shopping sprees. A shopping spree occurs when a user makes purchASes on 3 
-- or more consecutive days. List the user IDs who have gone on at leASt 1 shopping spree in ascending order.


CREATE TABLE transactions(
		user_id INT,
		amount FLOAT,
		transaction_date DATETIME
	);


INSERT INTO transactions VALUES
		(1,9.99,'08/01/2022 10:00:00'),
		(1,55,'08/17/2022 10:00:00'),
		(2,149.5,'08/05/2022 10:00:00'),
		(2,4.89,'08/06/2022 10:00:00'),
		(2,34,'08/07/2022 10:00:00');



SELECT 
        DISTINCT user_id 
FROM 
    (
        SELECT 
                user_id, 
                transaction_date,
                rn,
                transaction_date :: date - rn::integer,
                COUNT(transaction_date :: date - rn::integer) OVER(PARTITION BY user_id) AS cn
        FROM
                (
                    SELECT 
                            user_id, 
                            transaction_date,
                            ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rn
                    FROM 
                            transactions
                ) temp
    )temp1

WHERE cn >=3;


-- SOLVED IN POSTGRESQL



-- Q.148 You are given a table of PayPal payments showing the payer, the recipient, and the amount paid. 
-- A two-way unique relationship is established WHEN two people sEND money back and forth. Write a query 
-- to find the number of two-way unique relationships in this data.


CREATE TABLE payments(
		payer_id INT,
		recipient_id INT,
		amount INT
	);


INSERT INTO payments VALUES
		(101,201,30),
		(201,101,10),
		(101,301,20),
		(301,101,80),
		(201,301,70);


WITH temp_payments AS (
                        SELECT 
                                DISTINCT p1.payer_id, 
                                p1.recipient_id
                        FROM 
                                payments p1 
                        INNER JOIN 
                                payments p2
                        ON 
                                p1.payer_id = p2.recipient_id
                        AND 
                                p2.payer_id = p1.recipient_id
                        AND 
                                p1.payer_id < p2.payer_id
        )

SELECT 
        COUNT(*) unique_relationships
FROM 
        temp_payments;



-- Q.149 Write a query to obtain the list of customers whose first transaction was valued at $50 or more.
-- Output the number of users.


CREATE TABLE user_transactions(
		transaction_id INT,
		user_id INT,
		spend FLOAT,
		transaction_date VARCHAR(30)
	);


INSERT INTO user_transactions VALUES
		(759274,111,49.50,'02/03/2022 00:00:00'),
		(850371,111,51.00,'03/15/2022 00:00:00'),
		(615348,145,36.30,'03/22/2022 00:00:00'),
		(137424,156,151.00,'04/04/2022 00:00:00'),
		(248475,156,87.00,'04/16/2022 00:00:00');



WITH temp_transactions AS (
                            SELECT 
                                    user_id, 
                                    transaction_date, 
                                    spend,
                                    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) row_num 
                            FROM 
                                    user_transactions
                    )

SELECT 
        COUNT(DISTINCT user_id) as users
FROM 
        temp_transactions
WHERE 
        row_num = 1 
        and 
        spend >= 50;



-- Q.150 Write a query to obtain the SUM of the odd-numbered and even-numbered meASurements on a particular day, 
-- in two different columns.


CREATE TABLE measurments(
		measurment_id INT,
		measurment_value FLOAT,
		measurment_time DATETIME
	);


INSERT INTO measurments VALUES
		(131233,1109.51,'07/10/2022 09:00:00'),
		(135211,1662.74,'07/10/2022 11:00:00'),
		(523542,1246.24,'07/10/2022 13:15:00'),
		(143562,1124.50,'07/11/2022 15:00:00'),
		(346462,1234.14,'07/11/2022 16:45:00');



WITH temp_measurments AS (
                            SELECT
                                    measurement_value,
                                    measurement_time,
                                    ROW_NUMBER() OVER(PARTITION BY measurement_time::DATE ORDER BY measurement_time) row_num
                            FROM 
                                    measurments
                )

SELECT 
        measurement_time::DATE,,
        ROUND(SUM(
            CASE
                WHEN row_num % 2 <> 0 THEN measurment_value
                END),2) AS odd_value,
        ROUND(SUM(
            CASE
                WHEN row_num % 2 = 0 THEN measurment_value
                END),2) AS even_value
FROM 
        temp_measurments
GROUP BY 
        measurement_time::DATE,
ORDER BY 
        measurement_time;


-- SOLVED IN POSTGRESQL


-- Q.151 SAME AS Q.147



-- Q.152 The Airbnb Booking RecommENDations team is trying to understand the "substitutability" of two rentals 
-- and whether one rental is a good substitute for another. They want you to write a query to find the unique 
-- combination of two Airbnb rentals WITH the same exact amenities offered. Output the COUNT of the unique 
-- combination of Airbnb rentals.


CREATE TABLE rental_amenities(
		rental_id INT,
		amenity VARCHAR(20)
	);


INSERT INTO rental_amenities VALUES
		(123,'POOL'),
		(123,'KITCHEN'),
		(234,'HOT TUB'),
		(234,'FIREPLACE'),
		(345,'KITCHEN'),
		(345,'POOL'),
		(456,'POOL');



WITH temp_amenities AS (
                        SELECT 
                                rental_id, 
                                amenity, 
                                COUNT(amenity) over(partition by rental_id) AS no_of_amenities 
                        FROM 
                                rental_amenities
            ),

temp_amenities2 AS (
                        SELECT 
                                COUNT(*) 
                        FROM 
                                temp_amenities a
                        inner join 
                                temp_amenities b 
                        on 
                                a.no_of_amenities = b.no_of_amenities
                        AND 
                                a.amenity = b.amenity
                        AND 
                                a.rental_id<>b.rental_id
                        GROUP BY 
                                a.rental_id,
                                b.rental_id, 
                                a.no_of_amenities
                        HAVING 
                                COUNT(*) = a.no_of_amenities
            )


SELECT 
        CEIL(COUNT(*)/2) as matching_airbnb
FROM 
        temp_amenities2;




-- Q.153 Write a query to calculate the return on ad spend (ROAS) for each advertiser 
-- across all ad campaigns. Round your answer to 2 decimal places, and order your 
-- output by the advertiser_id.


CREATE TABLE ad_campaigns(
		campaign_id INT,
		spend INT,
		revenue FLOAT,
		advertiser_id INT
	);


INSERT INTO ad_campaigns VALUES
		(1,5000,7500,3),
		(2,1000,900,1),
		(3,3000,12000,2),
		(4,500,200,4),
		(5,100,400,4);


SELECT 
        advertiser_id, 
        CAST(SUM(revenue) / SUM(spend) AS Decimal(8,2)) AS ROAS
FROM 
        ad_campaigns
GROUP BY 
        advertiser_id
ORDER BY 
        advertiser_id;



-- Q.154 Write a query that shows the following data for each compensation outlier: 
-- employee ID, salary, and whether they are potentially overpaid or potentially underpaid


CREATE TABLE employee_pay(
		employee_id INT,
		salary INT,
		title VARCHAR(20)
	);


INSERT INTO employee_pay VALUES
		(101,80000,'DATA ANALYST'),
		(102,90000,'DATA ANALYST'),
		(103,100000,'DATA ANALYST'),
		(104,30000,'DATA ANALYST'),
		(105,120000,'DATA SCIENTIST'),
		(106,100000,'DATA SCIENTIST'),
		(107,80000,'DATA SCIENTIST'),
		(108,310000,'DATA SCIENTIST');


WITH temp_compensation AS (
                            SELECT 
                                    employee_id,
                                    salary,
                                    title,
                                    ROUND(AVG(salary) over(PARTITION BY title),2) AS avg_salary 
                            FROM 
                                    employee_pay
                ),
    temp_compensation2 AS (
                            SELECT
                                    employee_id, 
                                    salary,
                                    CASE
                                        WHEN salary > 2 * avg_salary THEN 'Overpaid'
                                        WHEN salary < avg_salary/2 THEN 'Underpaid'
                                        END AS status
                            FROM 
                                    temp_compensation
                )

SELECT 
        employee_id, 
		salary, 
		status
FROM 
        temp_compensation2 
WHERE 
        status is not null;



-- Q.155 SAME AS 148



-- Q.156 Assume you are given the table below containing information on user
-- purchASes. Write a query to obtain the number of users who purchASed the 
-- same product on two or more different days. Output the number of unique users.


CREATE TABLE purchases(
		user_id INT,
		product_id INT,
		quantity INT,
		purchase_date DATETIME
	);


INSERT INTO purchases VALUES
		(536,3223,6,'2022-01-11 12:33:44'),
		(827,3585,35,'2022-02-20 14:05:26'),
		(536,3223,5,'2022-03-02 09:33:28'),
		(536,1435,10,'2022-03-02 08:40:00'),
		(827,2452,45,'2022-04-09 00:00:00');


SELECT 
        COUNT(DISTINCT user_id) AS repeat_purchasers
FROM (
        SELECT 
                user_id 
        FROM 
                purchases
        GROUP BY 
                user_id, 
                product_id
        HAVING 
                COUNT(DISTINCT purchase_date) > 1
    ) temp;



-- Q.157 Say you have access to all the transactions for a given merchant acCOUNT. 
-- Write a query to print the cumulative balance of the merchant acCOUNT at the END 
-- of each day, WITH the total balance reset back to zero at the END of the month. 
-- Output the transaction date and cumulative balance.


CREATE TABLE transactions(
		transaction_id INT,
		type ENUM('DEPOSIT','WITHDRAWL'),
		amount FLOAT,
		transaction_date DATETIME
	);


INSERT INTO transactions VALUES
		(19153,'DEPOSIT',65.90,'07/10/2022 10:00:00'),
		(53151,'DEPOSIT',178.55,'07/08/2022 10:00:00'),
		(29776,'WITHDRAWL',25.90,'07/08/2022 10:00:00'),
		(16461,'WITHDRAWL',45.99,'07/08/2022 10:00:00'),
		(77134,'DEPOSIT',32.60,'07/10/2022 10:00:00');



SELECT 
        DISTINCT date(transaction_date),
        SUM(
            CASE 
                WHEN type = 'deposit' THEN amount
                ELSE -amount
                END
            ) OVER(PARTITION BY EXTRACT(MONTH FROM transaction_date) ORDER BY DATE(transaction_date)) AS balance
FROM 
        transactions;


-- SOLVED IN POSTGRESQL



-- Q.158 Assume you are given the table below containing information on 
-- Amazon customers and their spend on products belonging to various 
-- categories. Identify the top two highest-grossing products within each 
-- category in 2022. Output the category, product, and total spend.


CREATE TABLE product_spend(
		category VARCHAR(20),
		product VARCHAR(20),
		user_id INT,
		spend FLOAT,
		transaction_date DATETIME
	);


INSERT INTO product_spend VALUES
		('APPLIANCE','REFRIGERATOR',165,246.00,'12/26/2021 12:00:00'),
		('APPLIANCE','REFRIGERATOR',123,299.99,'03/02/2022 12:00:00'),
		('APPLIANCE','WASHING MACHINE',123,219.80,'03/02/2022 12:00:00'),
		('ELECTRONICS','VACUUM',178,152.00,'04/05/2022 12:00:00'),
		('ELECTRONICS','WIRELESS HEADSET',156,249.90,'07/08/2022 12:00:00'),
		('ELECTRONICS','REFRIGERATOR',145,189.00,'07/15/2022 12:00:00');


WITH temp_product_details AS (
                                SELECT 
                                        category, 
                                        product,
                                        spend,
                                        SUM(spend) OVER(PARTITION BY category, product) total_spend
                                FROM 
                                        product_spend
                                WHERE 
                                        EXTRACT(YEAR FROM transaction_date) = 2022
                 ),

    temp_product_details1 AS (
                                SELECT 
                                        DISTINCT category, 
                                        product, 
                                        total_spend ,
                                        DENSE_RANK() OVER(PARTITION BY category order by total_spend desc) row_num
                                FROM 
                                        temp_product_details
               )


SELECT 
        DISTINCT category, 
        product, 
        total_spend 
FROM 
        temp_product_details1 
WHERE 
        row_num <=2
ORDER BY 
        category, 
        total_spend DESC;


-- SOLVED IN POSTGRESQL


-- Q.159 Facebook is analysing its user signup data for June 2022. 
-- Write a query to generate the churn rate by week in June 2022. 
-- Output the week number (1, 2, 3, 4, ...) and the corresponding 
-- churn rate rounded to 2 decimal places.


CREATE TABLE users(
		user_id INT,
		signup_date DATETIME,
		last_login DATETIME
	);


INSERT INTO users VALUES
		(1001,'2022-06-01 12:00:00','2022-07-05 12:00:00'),
		(1002,'2022-06-03 12:00:00','2022-06-15 12:00:00'),
		(1004,'2022-06-02 12:00:00','2022-06-15 12:00:00'),
		(1006,'2022-06-15 12:00:00','2022-06-27 12:00:00'),
		(1012,'2022-06-16 12:00:00','2022-07-22 12:00:00');



-- Approach 1



WITH temp_churn_rate AS (
                        SELECT 
                                user_id, 
                                signup_date, 
                                last_login,
                                DATEDIFF(last_login, signup_date) diff, 
                                EXTRACT(WEEK FROM signup_date) AS week_no,
                                WEEK(signup_date,5) -  WEEK(DATE_SUB(signup_date, INTERVAL DAYOFMONTH(signup_date)-1 DAY),5)+1 AS ranking
                        FROM 
                                users
                        WHERE 
                                EXTRACT(MONTH FROM signup_date) = 6 
                                AND
                                EXTRACT(YEAR FROM signup_date) = 2022
),
temp_churn_rate2 AS (
                        SELECT 
                                ranking, 
                                COUNT(ranking) AS total_users,
                                COUNT(
                                CASE 
                                    WHEN diff <= 28 THEN 1
                                    END 
                                    ) AS total_churns 
                        FROM 
                                temp_churn_rate
                        GROUP BY 
                                ranking
)

SELECT 
        ranking AS week, 
        ROUND((total_churns/total_users) * 100 ,2) AS churn_rate
FROM 
        temp_churn_rate2
ORDER BY 
        ranking;
       
