
/* Drop Tables */

DROP TABLE comments CASCADE CONSTRAINTS;
DROP TABLE article CASCADE CONSTRAINTS;
DROP TABLE board CASCADE CONSTRAINTS;
DROP TABLE commute CASCADE CONSTRAINTS;
DROP TABLE daily_income CASCADE CONSTRAINTS;
DROP TABLE emp_sal CASCADE CONSTRAINTS;
DROP TABLE emp_salary CASCADE CONSTRAINTS;
DROP TABLE store_order CASCADE CONSTRAINTS;
DROP TABLE employee CASCADE CONSTRAINTS;
DROP TABLE event CASCADE CONSTRAINTS;
DROP TABLE head_order CASCADE CONSTRAINTS;
DROP TABLE store_stock CASCADE CONSTRAINTS;
DROP TABLE transact_detail CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE factory CASCADE CONSTRAINTS;
DROP TABLE monthly_goal CASCADE CONSTRAINTS;
DROP TABLE position CASCADE CONSTRAINTS;
DROP TABLE transact CASCADE CONSTRAINTS;
DROP TABLE stores CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE seq_art_no;
DROP SEQUENCE seq_boa_no;
DROP SEQUENCE seq_com_no;
DROP SEQUENCE seq_event_code;
DROP SEQUENCE seq_factory_code;
DROP SEQUENCE seq_head_order;
DROP SEQUENCE seq_strore_order;
DROP SEQUENCE seq_transact_code;




/* Create Sequences */

CREATE SEQUENCE seq_art_no;
CREATE SEQUENCE seq_boa_no;
CREATE SEQUENCE seq_com_no;
CREATE SEQUENCE seq_event_code;
CREATE SEQUENCE seq_factory_code;
CREATE SEQUENCE seq_head_order;
CREATE SEQUENCE seq_strore_order;
CREATE SEQUENCE seq_transact_code;



/* Create Tables */

CREATE TABLE article
(
	art_no number NOT NULL,
	title varchar2(200) NOT NULL,
	content varchar2(4000) NOT NULL,
	likes number(5) DEFAULT 0 NOT NULL,
	dislikes number(5) DEFAULT 0 NOT NULL,
	reg_date date DEFAULT sysdate NOT NULL,
	readcnt number(5) DEFAULT 0 NOT NULL,
	boa_no number NOT NULL,
	emp_id varchar2(30) NOT NULL,
	PRIMARY KEY (art_no)
);


CREATE TABLE board
(
	boa_no number NOT NULL,
	name varchar2(20) NOT NULL,
	status number(1) DEFAULT 1 NOT NULL,
	PRIMARY KEY (boa_no)
);


CREATE TABLE comments
(
	com_no number NOT NULL,
	content varchar2(1000) NOT NULL,
	regdate date DEFAULT sysdate NOT NULL,
	likes number(5) DEFAULT 0 NOT NULL,
	dislikes number(5) DEFAULT 0 NOT NULL,
	art_no number NOT NULL,
	emp_id varchar2(30) NOT NULL,
	PRIMARY KEY (com_no)
);


CREATE TABLE commute
(
	emp_id varchar2(30) NOT NULL,
	work_date date DEFAULT sysdate NOT NULL,
	-- 
	-- 
	start_time varchar2(20) NOT NULL,
	end_time varchar2(20),
	etc varchar2(3000),
	PRIMARY KEY (emp_id, work_date)
);


CREATE TABLE daily_income
(
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	bs_date date NOT NULL,
	-- long
	total_income number NOT NULL,
	reg_time varchar2(20) NOT NULL,
	remain_cash number NOT NULL,
	closing_id varchar2(30),
	PRIMARY KEY (store_name, bs_date)
);


CREATE TABLE employee
(
	emp_id varchar2(30) NOT NULL,
	emp_password varchar2(300) NOT NULL,
	name varchar2(30) NOT NULL,
	position_code number NOT NULL,
	phone varchar2(50) NOT NULL,
	address varchar2(250) NOT NULL,
	birthday date NOT NULL,
	hire_date date NOT NULL,
	retire_date date,
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	salary number NOT NULL,
	PRIMARY KEY (emp_id)
);


CREATE TABLE emp_sal
(
	emp_id varchar2(30) NOT NULL,
	yearmonth varchar2(20) NOT NULL,
	total_sal number NOT NULL,
	PRIMARY KEY (emp_id, yearmonth)
);


CREATE TABLE emp_salary
(
	emp_id varchar2(30) NOT NULL,
	bs_month varchar2(15) NOT NULL,
	monthly_salary number,
	PRIMARY KEY (emp_id, bs_month)
);


CREATE TABLE event
(
	event_code number NOT NULL,
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	product_code varchar2(50) NOT NULL,
	event_name varchar2(100) NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL,
	discount_rate number(1,5) NOT NULL,
	PRIMARY KEY (event_code, store_name, product_code)
);


CREATE TABLE factory
(
	factory_code number NOT NULL,
	factory_name varchar2(20) NOT NULL,
	supervisor varchar2(30),
	address varchar2(40) NOT NULL,
	phone varchar2(50) NOT NULL,
	PRIMARY KEY (factory_code)
);


CREATE TABLE head_order
(
	head_order_code number NOT NULL,
	product_code varchar2(50) NOT NULL,
	quantity number NOT NULL,
	factory_code number NOT NULL,
	order_date date DEFAULT sysdate NOT NULL,
	receive_yn varchar2(1) DEFAULT 'n' NOT NULL,
	PRIMARY KEY (head_order_code, product_code)
);


CREATE TABLE monthly_goal
(
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	object_month varchar2(30) NOT NULL,
	-- long
	monthly_target number NOT NULL,
	monthly_income number,
	PRIMARY KEY (store_name, object_month)
);


CREATE TABLE position
(
	position_code number NOT NULL,
	name varchar2(50) NOT NULL,
	-- 직급별 최저임금
	-- 
	-- 알바 - 최저시급
	-- 정직원 - 기본급
	min_sal number NOT NULL,
	PRIMARY KEY (position_code)
);


CREATE TABLE product
(
	product_code varchar2(50) NOT NULL,
	product_name varchar2(50) NOT NULL,
	manufact_year number(4) NOT NULL,
	manufact_seas varchar2(2) NOT NULL,
	sex varchar2(1) NOT NULL,
	category1 varchar2(30) NOT NULL,
	category2 varchar2(30) NOT NULL,
	fit varchar2(30) NOT NULL,
	color varchar2(30) NOT NULL,
	sizes varchar2(10) NOT NULL,
	factory_code number NOT NULL,
	reg_date date DEFAULT sysdate NOT NULL,
	season_off varchar2(1) DEFAULT 'n' NOT NULL,
	head_stock_quantity number NOT NULL,
	img_name varchar2(50),
	price number NOT NULL,
	PRIMARY KEY (product_code)
);


CREATE TABLE stores
(
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	supervisor_id varchar2(30) NOT NULL,
	phone varchar2(50) NOT NULL,
	address varchar2(250) NOT NULL,
	location varchar2(5) NOT NULL,
	PRIMARY KEY (store_name)
);


CREATE TABLE store_order
(
	store_order_code number NOT NULL,
	product_code varchar2(50) NOT NULL,
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	quantity number NOT NULL,
	order_date date DEFAULT sysdate NOT NULL,
	receive_yn varchar2(1) DEFAULT 'n' NOT NULL,
	emp_id varchar2(30),
	PRIMARY KEY (store_order_code, product_code)
);


CREATE TABLE store_stock
(
	product_code varchar2(50) NOT NULL,
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	quantity number NOT NULL,
	PRIMARY KEY (product_code, store_name)
);


CREATE TABLE transact
(
	transaction_code varchar2(10) NOT NULL,
	-- 지점명은 무조건 있어야하고, 
	-- 동일한 지점명은 있을 수 없당
	-- 
	store_name varchar2(50) NOT NULL,
	ages varchar2(10),
	sex varchar2(1),
	payment varchar2(30) NOT NULL,
	trans_date varchar2(10) NOT NULL,
	refund_yn varchar2(1) DEFAULT 'n' NOT NULL,
	refund_date varchar2(10),
	total_price number,
	cahser_id varchar2(30),
	PRIMARY KEY (transaction_code)
);


CREATE TABLE transact_detail
(
	transaction_code varchar2(10) NOT NULL,
	product_code varchar2(50),
	quantity number NOT NULL,
	event_code number,
	PRIMARY KEY (transaction_code, product_code)
);



/* Create Foreign Keys */

ALTER TABLE comments
	ADD FOREIGN KEY (art_no)
	REFERENCES article (art_no)
;


ALTER TABLE article
	ADD FOREIGN KEY (boa_no)
	REFERENCES board (boa_no)
;


ALTER TABLE article
	ADD FOREIGN KEY (emp_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE comments
	ADD FOREIGN KEY (emp_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE commute
	ADD FOREIGN KEY (emp_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE daily_income
	ADD FOREIGN KEY (closing_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE emp_sal
	ADD FOREIGN KEY (emp_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE emp_salary
	ADD FOREIGN KEY (emp_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE store_order
	ADD FOREIGN KEY (emp_id)
	REFERENCES employee (emp_id)
;


ALTER TABLE head_order
	ADD FOREIGN KEY (factory_code)
	REFERENCES factory (factory_code)
;


ALTER TABLE product
	ADD FOREIGN KEY (factory_code)
	REFERENCES factory (factory_code)
;


ALTER TABLE employee
	ADD FOREIGN KEY (position_code)
	REFERENCES position (position_code)
;


ALTER TABLE event
	ADD FOREIGN KEY (product_code)
	REFERENCES product (product_code)
;


ALTER TABLE head_order
	ADD FOREIGN KEY (product_code)
	REFERENCES product (product_code)
;


ALTER TABLE store_order
	ADD FOREIGN KEY (product_code)
	REFERENCES product (product_code)
;


ALTER TABLE store_stock
	ADD FOREIGN KEY (product_code)
	REFERENCES product (product_code)
;


ALTER TABLE transact_detail
	ADD FOREIGN KEY (product_code)
	REFERENCES product (product_code)
;


ALTER TABLE daily_income
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE employee
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE event
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE monthly_goal
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE store_order
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE store_stock
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE transact
	ADD FOREIGN KEY (store_name)
	REFERENCES stores (store_name)
;


ALTER TABLE transact_detail
	ADD FOREIGN KEY (transaction_code)
	REFERENCES transact (transaction_code)
;



/* Comments */

COMMENT ON COLUMN commute.start_time IS '
';
COMMENT ON COLUMN daily_income.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN daily_income.total_income IS 'long';
COMMENT ON COLUMN employee.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN event.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN monthly_goal.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN monthly_goal.monthly_target IS 'long';
COMMENT ON COLUMN position.min_sal IS '직급별 최저임금

알바 - 최저시급
정직원 - 기본급';
COMMENT ON COLUMN stores.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN store_order.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN store_stock.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';
COMMENT ON COLUMN transact.store_name IS '지점명은 무조건 있어야하고, 
동일한 지점명은 있을 수 없당
';



