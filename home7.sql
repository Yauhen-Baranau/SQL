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
    class_id INT,
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

 -- Выводим все возможные классы с их классными руководителями.  LEFT
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

SELECT * FROM teachers
    WHERE lead_class_id IS NULL;

    SELECT * FROM teachers
    JOIN classes ON classes.id = teachers.lead_class_id;

    -- Выбераем поля имя и фамилию с использованием метода строк
    SELECT CONCAT(first_name, " ", last_name) as fl_name FROM students;
	SELECT CONCAT_WS(" ", first_name, last_name) as fl_name FROM students;
    -- соеденяем имя и фамилию и выводем а upper case
    SELECT UPPER(CONCAT(first_name, " ", last_name)) as fl_name FROM students;

    -- Пример не о чем, просто вернул для кажого номера класса квадратный корень
    SELECT SQRT(class_num) from classes;

    -- Получаем фамилию, дату рожения ученика и выводим текущую локальную дату, когда получили эти данные.
    SELECT last_name, birth_date, NOW() as receipt_time from students;

    -- Выводим имя и фамилию ученика, подтягиваем таблицу классов через LEFT JOIN, получаем
    -- в каком классе ученик, далее делаем проверку через IF и выводим Первоклашка он и Средняя школа или не определено с IFNULL
    SELECT first_name, last_name,
    IFNULL(classes.class_num, "не определено") as class_num,
    IF (classes.class_num = 1, "Первоклашка", "Средняя школа") as rang
    FROM students
    LEFT JOIN classes
    ON students.class_id = classes.id;


    -- тоже самое что и выше только с COALESCE
	SELECT first_name, last_name,
    COALESCE(classes.class_num, "не определено") as class_num
    FROM students
    LEFT JOIN classes
    ON students.class_id = classes.id;

 -- --------------------------------------------------------------------------------------------------------------
 -- 7я домашняя работа

        CREATE TABLE activities_List (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL
);

INSERT activities_List (name) VALUES ("Математика");
INSERT activities_List (name) VALUES ("Информатика");
INSERT activities_List (name) VALUES ("Английский язык");





    CREATE TABLE grade_book (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    activity_id INT,
    grade INT,
	FOREIGN KEY (student_id) REFERENCES students (id),
	FOREIGN KEY (activity_id) REFERENCES activities_List (id)

);

INSERT grade_book ( student_id, activity_id, grade) VALUES (1, 1, 10);
INSERT grade_book ( student_id, activity_id, grade) VALUES (1, 1, 5);

INSERT grade_book ( student_id, activity_id, grade) VALUES (1, 2, 9);
INSERT grade_book ( student_id, activity_id, grade) VALUES (1, 3, 9);

INSERT grade_book ( student_id, activity_id, grade) VALUES (2, 1, 6);
INSERT grade_book ( student_id, activity_id, grade) VALUES (2, 2, 6);
INSERT grade_book ( student_id, activity_id, grade) VALUES (2, 3, 6);

INSERT grade_book ( student_id, activity_id, grade) VALUES (3, 1, 9);
INSERT grade_book ( student_id, activity_id, grade) VALUES (3, 2, 3);
INSERT grade_book ( student_id, activity_id, grade) VALUES (3, 3, 6);






    -- Выводим id класса и количество учеников этого класса
    SELECT class_id, COUNT(id) AS count FROM students GROUP BY class_id;

    -- Выводим максимальный возраст учащихся
    SELECT MAX( DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birth_date, '%Y')) as max_age from students;

    -- Выводим Минимальный возраст учащихся
    SELECT MIN(DATE_FORMAT(NOW(), '%Y') - DATE_FORMAT(birth_date, '%Y')) as min_age from students;

    -- Выводим количество учащихся в классе с id = 2
    SELECT COUNT(id) FROM students GROUP BY class_id HAVING(class_id = 2);

    -- Показываем все выставленные оценки, какому ученику по какому предмету.
    SELECT students.first_name, students.last_name, activities_List.name as activity_name, grade_book.grade
    FROM grade_book
    JOIN students ON grade_book.student_id = students.id
    JOIN activities_List ON activity_id = activities_List.id;

    -- Выводим среднюю оценку по всем предметам
     SELECT ROUND(AVG(grade)) from grade_book GROUP BY activity_id;


	-- Выводим среднюю оценку по всем предметам где средняя оценка больше 6
    SELECT ROUND(AVG(grade)) from grade_book GROUP BY activity_id HAVING (ROUND(AVG(grade)) > 6);

        -- Показываем все выставленные оценки, какому ученику по какому предмету. + использование CASE
    SELECT students.first_name, students.last_name, activities_List.name as activity_name, grade_book.grade,
    CASE
		WHEN grade > 6 THEN "Учится хорошо"
        WHEN grade <= 6 AND grade >= 4 THEN "Учится средне"
		ELSE "Учится плохо"
        END AS level
    FROM grade_book
    JOIN students ON grade_book.student_id = students.id
    JOIN activities_List ON activity_id = activities_List.id;






































