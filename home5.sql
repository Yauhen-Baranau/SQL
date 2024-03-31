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

UPDATE classes SET class_name = 'A' WHERE class_num = 11;

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

-- Домашнее 5

SELECT students.first_name, students.last_name, classes.class_num, classes.class_name
    FROM students
    JOIN classes ON students.class_id = classes.id;

-- Узнаем количесвто учащихся в кадом классе
SELECT classes.class_num, classes.class_name, COUNT(students.id) as student_count
FROM classes inner join students ON classes.id = students.class_id
GROUP BY classes.class_name, classes.class_num
-- выводим где кол-во учащихся в классе не = 0
HAVING(COUNT(students.id) != 0);

 -- Вытягиваем имя и фамилию ученика, в каком он классе и ФИО классного руководителя тех учеников, у которых имя начинает на букву Е
SELECT students.first_name AS student_name,
	   students.last_name AS student_last_name,
       CONCAT(classes.class_num, classes.class_name) AS class,
       teachers.fio AS class_lead_teacher_name
    FROM students
    JOIN classes ON students.class_id = classes.id
    JOIN teachers ON teachers.lead_class_id = classes.id
    WHERE students.first_name LIKE("Е%");

 -- Выводим все возможные классы вместе с их классными руководителями.  LEFT
SELECT * FROM classes
    LEFT JOIN teachers ON teachers.lead_class_id = classes.id;

 -- Выводим  классы с их классными руководителями, где руководители есть или установлены.  INNER
SELECT * FROM classes
    JOIN teachers ON teachers.lead_class_id = classes.id;

SELECT * FROM teachers
    WHERE lead_class_id IS NULL;

SELECT * FROM teachers
    JOIN classes ON classes.id = teachers.lead_class_id;

SELECT * FROM teachers
    LEFT JOIN classes ON classes.id = teachers.lead_class_id;

    -- Выводим все классы где классный руководитель не установлен
SELECT * FROM classes
    LEFT JOIN teachers ON classes.id = teachers.lead_class_id
    WHERE teachers.lead_class_id IS NULL;
















