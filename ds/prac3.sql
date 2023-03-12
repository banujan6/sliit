DROP TABLE clients;
DROP TYPE investments_table;
DROP TYPE type_address;
DROP TYPE type_investment;

CREATE TYPE type_address AS OBJECT (
    street_no NUMBER(10),
    street_name VARCHAR(10),
    suburb VARCHAR(10),
    state VARCHAR(3),
    pin NUMBER(4)
);
/

CREATE TYPE type_investment AS OBJECT (
    company VARCHAR(10),
    purchase_price NUMBER(4,2),
    datee DATE,
    qty NUMBER(4)
);
/

CREATE TYPE investments_table IS TABLE OF type_investment;
/

CREATE TABLE clients (
	name  VARCHAR(20),
	address type_address,
	investments investments_table
)

NESTED TABLE investments STORE AS client_investments;
/

INSERT INTO clients VALUES (
    'John Smith', type_address(3, 'East Av', 'Bentley', 'WA', 6102),
    investments_table(
    	type_investment('BHP', 12.00, '02-OCT-01', 1000),
    	type_investment('BHP', 10.50, '08-JUN-02', 2000),
    	type_investment('IBM', 58.00, '12-FEB-00', 500),
    	type_investment('IBM', 65.00, '10-APR-01', 1200),
    	type_investment('INFOSYS', 64.00, '11-AUG-01', 1000)
    )
);

SELECT c.name, c.address.pin FROM clients c;
