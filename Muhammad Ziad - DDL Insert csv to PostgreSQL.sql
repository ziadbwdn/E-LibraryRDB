COPY libraries(library_id, library_name, library_address)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\libraries.csv'
DELIMITER ','
CSV HEADER

COPY categories(category_id, category_name)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\categories.csv'
DELIMITER ','
CSV HEADER

COPY authors(author_id, author_name)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\authors.csv'
DELIMITER ','
CSV HEADER

COPY publishers(publisher_id, publisher_name)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\publishers.csv'
DELIMITER ','
CSV HEADER

COPY books(books_id, category_id, book_title, author_id, publisher_id, book_language, book_type)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\books.csv'
DELIMITER ','
CSV HEADER

COPY members(member_id, member_name, member_address, email)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\members.csv'
DELIMITER ','
CSV HEADER

COPY users(user_id, user_password, member_id, phone_number)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\users.csv'
DELIMITER ','
CSV HEADER

COPY library_collections(library_collection_id, library_id, books_id, quantity_available)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\library_collections.csv'
DELIMITER ','
CSV HEADER

COPY borrows(borrow_id, user_id, library_collection_id, borrow_date, due_date, return_date, return_status)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\borrows.csv'
DELIMITER ','
CSV HEADER

COPY holds(hold_id, user_id, library_collection_id, hold_start, hold_end)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\holds.csv'
DELIMITER ','
CSV HEADER

/* DROP TABLE borrows */
