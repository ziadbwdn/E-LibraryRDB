# E-LibraryRDB
E-Library Designing Relational Database 


![SQL Exercise 4](https://github.com/ziadbwdn/E-LibraryRDB/assets/158177170/13ef45b3-5c01-4f95-9e7a-876ec0c42d5e)

medium link: https://mesinketikrusak.medium.com/e-library-database-designing-in-a-nutshell-2a1ff77ff0b6

In this current digital age, digital libraries are increasingly popular, especially among the younger generation, due to their ease of access and flexibility. Now, we can get various information, books, and learning materials without needing to visit a physical library. Ever heard of e-book or things alike?
So, the purpose of this article is to help us understanding how do we design a database system for digital libraries to enhance efficiency and ensure a well-organized structure. It's like Ohara library but in digital version.
In designing the database, the first step is to determine the mission statement. The mission statement for this project are:
Users can explore the titles available in the libraries.
Users can search for books based on category or type.
Users can know how many quantity the libraries have of a title.
Users can borrow and place holds on books they want to read
Users can check the availability of each books 

But still, this project have some caveats, such as:
The default loan period is 2 weeks, but customers can return books earlier and books will be automatically returned when they exceed more than the loan period.
Customers can loan only 2 books at the same time.
Customers can place holds on books that are currently unavailable, but they can hold only 2 books at the same time.

And then, we can create tables for the e-library system and establish their relationships by defining primary  and foreign keys. The picture below is the ERD (Entity Relationship Diagram) I have created, with a description of each table. There are 10 table 
image by authorfigure of relational types between tables in relational database (source:https://templatedbc.web.app/)Libraries table
 - This table containing information about libraries, including library_id of each library, its name, and its address
Categories table
 - This table containing information about categories, including id of each categories and its name
Authors table
 - This table containing information about authors, including id of the author and their name
Publishers table
 - This table containing information about publisher, including id of each publisher and their name
Books table
 - This table containing information about books, including id of the book as main key, titles, id of authors, id of categories, id of publisher, and type of books
Library Collections table
 - This table containing information about books which collected in certain library, including id of certain collections, id of certain library, id of certain library, and its available quantity
Members table
 - This table containing information about members, including id of certain member as main key, their name, their address, and their email
Users table
 - This table containing information about users, including id of certain user as main key, id of member, its password, and their phone number
Borrows table
 - This table containing information about the book's borrowed in this e-library. It has an id on each borrowing case as main key. It also have id of user who borrows it, id of library collection that get borrowed, borrow_date for information of the time when books is borrowed, due_date for time the books is get its borrow date expired, and return_date for time the books is returned, and return_status is a boolean indicating whether the book has been returned or not.
Holds table
 - This table containing information about the collection that being hold in this e-library. It has an id on each hold case. It also have id of user who holds it, id of library_collection that get hold, hold_start for information of the time when books is started to get hold, hold_end for time the books is get its hold date expired.

---

Design Implementation
The next step, we can start implementing the design of the database or ERD using PostgreSQL. We can use Data Definition Language (DDL) syntax to generate the table and define the relationship. And, for the steps in implementing the database design:
Connect to PostgreSQL Database
Create database

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
the example above is for the case of making library collections table set, which have foreign key as its constraint, each of foreign key referred to their own original table where each keys is the primary key on the table they referred to.
Generating the Database
For retrieving data from the database, data in the form of tables is required. In this case, I use dummy data obtained by combining data from manually create on the table  and the Python library Faker. Here is an example of the code, by the former script using can be looked at below and the latter which using faker on the next script:
# Define Libraries Table
def create_libraries(library_name, library_address):
    """
    create a DataFrame for libraries.

    Parameters:
    - library_names (list): list of library names, it has 8 names.
    - library_address (list): list of library address, it has 8 address.

    Returns:
    - pd.DataFrame: DataFrame containing library information such as library_id and library_name.
    """
    
    libraries = {
        "library_id": [i + 1 for i in range(len(library_name))],
        "library_name": library_name,
        "library_address": library_address
    }

    libraries_df = pd.DataFrame(libraries)
    return libraries_df

library_name = ["Wakanda Library", 
                "Pustaka Konoha", 
                "Pohon Pengetahuan Pulau Ohara",
                "Microlibrary Warak Kayu",
                "C2O Library",
                "Kineruku Library",
                "Baca Di Tebet",
                "Taman Baca Amin Perpustakaan Kontainer",
                ]
    
library_address = ["Jl Margomulyo Permai 6-8 Kav 2 D-G Surabaya Jawa Timur", 
                   "Jl Cimandiri 34-38 Bandung Jawa Barat",
                   "Jl Pulo Gebang Raya 25 Jakarta DKI Jakarta",
                   "Jl Cirebon 83 Medan Sumatera Utara",
                   "Jl Manyar Jaya 18-20 Surabaya Jawa Timur",
                   "Jl Batutulis Raya 26 Jakarta DKI Jakarta",
                   "Jl Terogong Raya 16 Jakarta DKI Jakarta",
                   "Jl Ir H Juanda 377 Bandung Jawa Barat"
                  ]
libraries_table = create_libraries(library_name, library_address)
libraries_table
# Define Authors Table
def create_authors(n_authors):
    """
    create a DataFrame for authors and make a mapping between author_name and author_id.

    Parameters:
    - n_authors (int): number of authors information to create.

    Returns:
    - pd.DataFrame: DataFrame containing author information such as author id and author name.
    """
    authors = []
    for a in range(n_authors):
        authors.append({
            'author_id': fake.unique.random_int(min=1, max=9999),
            'author_name': fake.name()
        })
    
    authors_df = pd.DataFrame(authors)
    return authors_df
    
#create authors DataFrame and Mapping
authors_table = create_authors(800)
authors_table
The first step is to import the libraries that will be used, such as:
pandas: Used for data manipulation and analysis in Python.
Faker: A library used for generating fake data.
random: Used to generate random values.
timedelta: Used to calculate time.

Next, set the instance localization to Indonesia to obtain fake data such as names, addresses, and emails.
# 2nd step: set localization into Indonesia or English
fake = Faker('id_ID' or 'en_EN')
After that, we can execute the data required to get our dummy data ready before we import it in PostgreSQL. for saving our successfully made table dataframe, we have to save it into csv at first
# Save to CSV
authors_table.to_csv('authors.csv', index=False)

# Save to CSV
library_collections_table.to_csv('library_collections.csv', index=False)
The full code can be seen on this page

If we now have all data required for the importing process, we can continue in SQL Query Tool, for example:
COPY authors(author_id, author_name)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\authors.csv'
DELIMITER ','
CSV HEADER

COPY library_collections(library_collection_id, library_id, books_id, quantity_available)
FROM 'C:\Program Files\PostgreSQL\16\pgAdmin 4\SQL Exercise 4\library_collections.csv'
DELIMITER ','
CSV HEADER
Before we do this, it is important to make sure the data we created at first in DDL syntax and our csv output from python match each other and fully passed our designed requirements, like we see the ERD diagram at the first.
