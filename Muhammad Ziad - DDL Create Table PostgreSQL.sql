CREATE TABLE libraries
(
    library_id SERIAL PRIMARY KEY,
    library_name VARCHAR(100) NOT NULL UNIQUE,
    library_address VARCHAR(200) NOT NULL
);

CREATE TABLE categories
(
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(200)
);

CREATE TABLE authors
(
    author_id SERIAL PRIMARY KEY,
    author_name VARCHAR(50)
);

CREATE TABLE publishers
(
    publisher_id SERIAL PRIMARY KEY,
    publisher_name VARCHAR(200)
);

CREATE TABLE books
(
    books_id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL,
    book_title VARCHAR(250) NOT NULL,
    author_id INTEGER NOT NULL,
    publisher_id INTEGER NOT NULL,
    book_language VARCHAR(30),
    book_type VARCHAR(30) NOT NULL,
    CONSTRAINT fk_books_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),
    CONSTRAINT fk_books_author
        FOREIGN KEY (author_id)
        REFERENCES authors(author_id),
    CONSTRAINT fk_books_publisher
        FOREIGN KEY (publisher_id)
        REFERENCES publishers(publisher_id)
);

CREATE TABLE library_collections
(
    library_collection_id SERIAL PRIMARY KEY,
    library_id INTEGER NOT NULL,
    books_id INTEGER NOT NULL,
    quantity_available INTEGER NOT NULL CHECK(quantity_available >= 0),
    CONSTRAINT fk_library_collections_lib
        FOREIGN KEY(library_id)
        REFERENCES libraries(library_id),
    CONSTRAINT fk_library_collections_bk
        FOREIGN KEY(books_id)
        REFERENCES books(books_id)
);

CREATE TABLE members
(
    member_id SERIAL PRIMARY KEY,
	member_name VARCHAR(200) NOT NULL,
    member_address VARCHAR(200),
	email VARCHAR(200) NOT NULL UNIQUE
);

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
	user_password VARCHAR(50),
    member_id INTEGER NOT NULL,
    phone_number VARCHAR(50) NOT NULL,
    CONSTRAINT fk_users_mb
        FOREIGN KEY(member_id)
        REFERENCES members(member_id)
);

CREATE TABLE borrows
(
    borrow_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    library_collection_id INTEGER NOT NULL,
    borrow_date TIMESTAMP NOT NULL DEFAULT NOW(),
    due_date TIMESTAMP,
    return_date TIMESTAMP,
    return_status BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_borrows_usr
        FOREIGN KEY(user_id)
        REFERENCES users(user_id),
    CONSTRAINT fk_borrows_bcoll
        FOREIGN KEY(library_collection_id)
        REFERENCES library_collections(library_collection_id)
);

CREATE TABLE holds
(
    hold_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    library_collection_id INTEGER NOT NULL,
    hold_start TIMESTAMP NOT NULL DEFAULT NOW(),
    hold_end TIMESTAMP,
    CONSTRAINT fk_holds_usr
        FOREIGN KEY(user_id)
        REFERENCES users(user_id),
    CONSTRAINT fk_holds_libcol
        FOREIGN KEY(library_collection_id)
        REFERENCES library_collections(library_collection_id)
);