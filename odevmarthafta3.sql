CREATE DATABASE librarys;
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);
CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    publish_year DATE,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);
CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
CREATE TABLE borrows (
    borrow_id SERIAL PRIMARY KEY,
    borrow_date DATE NOT NULL,
    return_date DATE,
    student_id INT NOT NULL,
    book_id INT NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
INSERT INTO students (first_name, last_name) VALUES
('Ayşe', 'Bayrak'),
('Ali', 'Dokuma'),
('Ege', 'Usta'),
('Mert', 'Kapıcı'),
('Yıldıray', 'tutmaz');
INSERT INTO authors (name) VALUES
('Shakespeare '),
('Lev Tolstoy '),
('Victor Hugo'),
('Yaşar Kemal'),
('Fyodor Dostoyevski');
INSERT INTO books (title, category, publish_year, author_id) VALUES
('Hamlet', 'trajedi', '2000-01-10', 1),
('Romeo ve Juliet', 'romantik ', '1999-01-11', 1),
('Anna Karenina', 'romantik', '2001-01-12', 2),
('sefiller ', 'suç', '2002-01-13', 3),
('İnce Memed', ' toplumsal gerçekçi', '2003-01-14', 4),
('Suç ve Ceza', 'psikolojik', '2004-01-15', 5);
INSERT INTO borrows (borrow_date, return_date, student_id, book_id) VALUES
('2025-03-01', '2025-01-01', 1, 1),
('2025-03-05', '2025-01-02', 2, 3),
('2025-03-10', 2025-01-03, 3, 4),
('2025-03-12', 2025-01-04, 4, 2),
('2025-03-15', NULL, 5, 5);
INSERT INTO borrows (borrow_date, return_date, student_id, book_id) VALUES
('2025-02-01', '2025-02-04', 1, 4),
('2025-02-02', 2025-02-05, 1, 1),
('2025-02-03', '2025-02-06', 1, 2),

('2025-03-01', '2025-03-03', 2, 5),
('2025-03-02', 2025-03-04, 2, 6),

('2025-04-01', 2025-03-04, 3, 2),
('2025-04-02', 2025-03-05, 3, 1),

('2025-04-01', Null, 4, 2),

('2025-05-01', '2025-05-02', 5, 2);

SELECT * FROM books;

SELECT * FROM books WHERE category = 'Bilgisayar Bilimleri';

SELECT * FROM books WHERE publish_year >= '2020-01-01';

SELECT title, category FROM books;

SELECT students.first_name, students.last_name, books.title 
FROM borrows
JOIN students ON borrows.student_id = students.student_id
JOIN books ON borrows.book_id = books.book_id;

SELECT books.title, authors.name AS author_name, books.publish_year
FROM books
JOIN authors ON books.author_id = authors.author_id;

SELECT students.first_name, students.last_name, books.title, borrows.borrow_date
FROM borrows
JOIN students ON borrows.student_id = students.student_id
JOIN books ON borrows.book_id = books.book_id;

SELECT students.first_name, students.last_name, books.title, borrows.borrow_date
FROM borrows
JOIN students ON borrows.student_id = students.student_id
JOIN books ON borrows.book_id = books.book_id
WHERE borrows.return_date IS NULL;

SELECT category, COUNT(*) AS book_count
FROM books
GROUP BY category;

SELECT students.first_name, students.last_name, COUNT(borrows.borrow_id) AS borrow_count
FROM borrows
JOIN students ON borrows.student_id = students.student_id
GROUP BY students.student_id
ORDER BY borrow_count DESC;

ALTER TABLE books ADD COLUMN price NUMERIC(8, 2);
ALTER TABLE books ALTER COLUMN category TYPE VARCHAR(149);

UPDATE books  SET category = 'Psikolojik' WHERE book_id = 1;
DELETE FROM books WHERE book_id = 1;

SELECT*FROM books

SELECT books.title, authors.name FROM books INNER JOIN authors ON books.author_id = authors.author_id;
SELECT books.title, borrows.return_date FROM borrows LEFT JOIN books ON borrows.book_id=books.book_id;
SELECT books.title, borrows.return_date FROM books RIGHT JOIN borrows ON books.book_id = borrows.book_id;
SELECT books.title, borrows.return_date FROM books FULL JOIN borrows ON books.book_id = borrows.book_id;

SELECT category, COUNT(*) AS book_count FROM books GROUP BY category HAVING COUNT(*) >= 1;

SELECT * FROM books LIMIT 3;
SELECT * FROM books LIMIT 3 OFFSET 1;

SELECT * FROM books WHERE book_id IN (SELECT book_id FROM borrows);
SELECT title  FROM books  WHERE author_id IN (SELECT author_id FROM authors WHERE name = 'Shakespeare');

SELECT * FROM books WHERE category = 'Bilgisayar Bilimleri' AND publish_year >= '2020-01-01';
SELECT * FROM books WHERE category = 'Bilgisayar Bilimleri' OR category = 'Romantik';

SELECT * FROM books WHERE publish_year BETWEEN '2020-01-01' AND '2022-01-01';

SELECT * FROM books WHERE category IN ('Bilgisayar Bilimleri', 'Romantik', 'Psikolojik');
