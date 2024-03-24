DROP DATABASE IF EXISTS school_db;
CREATE DATABASE IF NOT EXISTS school_db;

USE school_db;

CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    class_num TINYINT,
    class_name TINYTEXT
);

ALTER TABLE classes ADD COLUMN class_teacher_id INT DEFAULT 0; -- Таблица классных руководителей еще на стадии анализа))

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
    ALTER TABLE students ADD COLUMN age TINYINT NOT NULL CHECK(age >= 6 AND age <=17);

INSERT students ( first_name, last_name, phone, age) VALUES ( "Евгений", "Баранов", "+375293333333", 6);
INSERT students (class_id, first_name, last_name, phone, age) VALUES (1, "Кристина", "Абражевич", "+375296112322", 6);
INSERT students (class_id, first_name, last_name, phone, age) VALUES (1, "Ева", "Баранова", "+375293334433", 6);
INSERT students (class_id, first_name, last_name, phone, age) VALUES (2, "Андрей", "Бобенко", "+375291234598", 7);
INSERT students (class_id, first_name, last_name, phone, age) VALUES (2, "Алексей", "Адамский", "+375291098274", 7);
INSERT students (class_id, first_name, last_name, phone, age) VALUES (3, "Мария", "Савченко", "+37533112233", 7);
INSERT students (class_id, first_name, last_name, phone, age) VALUES (3, "Юля", "Гурская", "+375251112233", 9);

UPDATE students SET class_id = 4 WHERE first_name = "Юля";

-- Домашнее 3

SELECT * FROM classes;
SELECT first_name, last_name FROM students;
SELECT * FROM classes WHERE class_teacher_id=0;
SELECT * FROM students WHERE age=7;
SELECT * FROM students ORDER BY last_name;
SELECT * FROM students WHERE class_id IN (1);
SELECT * FROM students WHERE class_id NOT IN (1);
SELECT * FROM students LIMIT 3;
SELECT COUNT(*) from students;
SELECT class_id, COUNT(id) FROM students GROUP BY class_id HAVING COUNT(id) >= 2; -- группировка количества учеников в классах и фильтр сгруп. данных где кол-во учеников >= 2

DROP TABLE classes, students;
DROP DATABASE school_db;








