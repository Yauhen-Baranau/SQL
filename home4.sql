DROP DATABASE IF EXISTS school_db;
CREATE DATABASE IF NOT EXISTS school_db;

USE school_db;

CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    class_num TINYINT,
    class_name TINYTEXT
);

INSERT classes (class_num, class_name) VALUES (1, "A");
INSERT classes (class_num, class_name) VALUES (2, "A");
INSERT classes (class_num, class_name) VALUES (3, "A");
INSERT classes (class_num, class_name) VALUES (4, "A");
INSERT classes (class_num, class_name) VALUES (5, "A");
INSERT classes (class_num, class_name) VALUES (6, "A");
INSERT classes (class_num, class_name) VALUES (7, "A");
INSERT classes (class_num, class_name) VALUES (8, "A");
INSERT classes (class_num, class_name) VALUES (9, "A");
INSERT classes (class_num, class_name) VALUES (10, "A");
INSERT classes (class_num, class_name) VALUES (11, "Б");

UPDATE classes SET class_name = 'A'WHERE class_num = 11;

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    class_id INT DEFAULT 1,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone VARCHAR(13) UNIQUE CHECK(phone !=''),
    FOREIGN KEY (class_id) REFERENCES classes (id)
);
    ALTER TABLE students ADD COLUMN birth_date DATE NOT NULL;

INSERT students ( first_name, last_name, phone, birth_date) VALUES ( "Евгений", "Баранов", "+375293333333", "1990-04-02");
INSERT students (class_id, first_name, last_name, phone, birth_date) VALUES (1, "Кристина", "Абражевич", "+375296112322", "1990-04-02");
INSERT students (class_id, first_name, last_name, phone, birth_date) VALUES (2, "Ева", "Баранова", "+375293334433", "1992-04-02");
INSERT students (class_id, first_name, last_name, phone, birth_date) VALUES (2, "Андрей", "Бобенко", "+375291234598", "1992-04-02");
INSERT students (class_id, first_name, last_name, phone, birth_date) VALUES (2, "Алексей", "Адамский", "+375291098274", "1993-04-02");
INSERT students (class_id, first_name, last_name, phone, birth_date) VALUES (3, "Мария", "Савченко", "+37533112233", "1993-04-02");
INSERT students (class_id, first_name, last_name, phone, birth_date) VALUES (3, "Юля", "Гурская", "+375251112233", "1990-04-02");

UPDATE students SET class_id = 4 WHERE first_name = "Юля";

    CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    fio VARCHAR(200) NOT NULL,
    lead_class_id INT NULL,
	FOREIGN KEY (lead_class_id) REFERENCES classes (id)
);

INSERT teachers (fio, lead_class_id ) VALUES("Семененко Татьяна Николаевна", 1);
INSERT teachers (fio, lead_class_id ) VALUES("Ганус Галина Николаевна", 2);
INSERT teachers (fio, lead_class_id ) VALUES("Клейн Александр Исаакович", 3);
INSERT teachers (fio ) VALUES("Перцовский Александр Исаакович");


-- Домашнее 4
SELECT birth_date, COUNT(*) FROM students GROUP BY birth_date;
SELECT * FROM students WHERE birth_date > "1992-04-02" ;
SELECT * FROM students WHERE first_name LIKE("Е%");
SELECT * FROM students WHERE first_name NOT LIKE("Е%");
SELECT first_name as fn,
	   last_name as ln,
       CASE
       WHEN YEAR(birth_date) = 1990 THEN "YES"
       ELSE "NO" END
       AS birth_year
       FROM students
       WHERE birth_date <= "1992-04-02" AND first_name LIKE("Е%");











































