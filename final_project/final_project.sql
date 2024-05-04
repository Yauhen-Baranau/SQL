DROP DATABASE IF EXISTS school_db;
CREATE DATABASE IF NOT EXISTS school_db;

USE school_db;

-- Спискок классов школы
CREATE TABLE classes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    class CHAR(3) NOT NULL
);

INSERT classes (class) VALUES ("1A");
INSERT classes (class) VALUES ("2A");
INSERT classes (class) VALUES ("3A");
INSERT classes (class) VALUES ("4A");
INSERT classes (class) VALUES ("5A");

-- Список аудитоиий
CREATE TABLE audience  (
     id INT PRIMARY KEY AUTO_INCREMENT,
     audience_num INT NOT NULL UNIQUE
);

INSERT audience (audience_num) VALUES (100);
INSERT audience (audience_num) VALUES (102);
INSERT audience (audience_num) VALUES (103);
INSERT audience (audience_num) VALUES (104);
INSERT audience (audience_num) VALUES (105);

-- Список учителей работающих в школе
    CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL
);

INSERT teachers (first_name, last_name) VALUES ("ТАТЬЯНА", "СЕМЕНЕНКО");
INSERT teachers (first_name, last_name) VALUES ("ТАМАРА", "ПЕРЦОВСКАЯ");
INSERT teachers (first_name, last_name) VALUES ("ГАНУС", "ГАЛИНА");
INSERT teachers (first_name, last_name) VALUES ("КУЛЬЧИК", "ОЛЬГА");
INSERT teachers (first_name, last_name) VALUES ("АЛЕКСЕЙ", "БОРОДА");


-- Список предметов в школе
CREATE TABLE activities (
  id INT PRIMARY KEY AUTO_INCREMENT,
  activity_name VARCHAR(30) NOT NULL
);

INSERT activities (activity_name) VALUES ("Математика");
INSERT activities (activity_name) VALUES ("История");
INSERT activities (activity_name) VALUES ("Бел яз");
INSERT activities (activity_name) VALUES ("Англ яз");
INSERT activities (activity_name) VALUES ("Информатика");


-- Список учащихся школы
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    birth_date DATE NOT NULL
);

-- Создан индекс для оптимизации поиска в таблице учеников по фамилии
CREATE INDEX idx_last_name ON students(last_name);

-- Таблица логов, скорее для кадров, когда учащийся был зачислен
CREATE TABLE students_log (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (student_id) REFERENCES students (id)
);


-- Создаем триггер. При добвлении учащегося в таблицу students, добавляем запись в students_log
CREATE TRIGGER students_add_trigger
AFTER INSERT ON students
FOR EACH ROW
INSERT students_log (student_id) VALUES (NEW.id);

INSERT students (first_name, last_name, birth_date) VALUES ("Евгений", "Баранов", "1990-04-02");
INSERT students (first_name, last_name, birth_date) VALUES ("Артем", "Мосько", "1990-05-17");
INSERT students (first_name, last_name, birth_date) VALUES ("Марина", "Монит", "1990-04-17");

INSERT students (first_name, last_name, birth_date) VALUES ("Влад", "Стефанович", "1991-04-17");
INSERT students (first_name, last_name, birth_date) VALUES ("Дмитрий", "Воробей", "1991-06-12");
INSERT students (first_name, last_name, birth_date) VALUES ("Игорь", "Кодьман", "1991-06-12");

INSERT students (first_name, last_name, birth_date) VALUES ("Давид", "Бадалян", "1992-12-22");
INSERT students (first_name, last_name, birth_date) VALUES ("Оля", "Самусева", "1992-12-23");
INSERT students (first_name, last_name, birth_date) VALUES ("Дима", "Прокофьев", "1992-12-21");

INSERT students (first_name, last_name, birth_date) VALUES ("Вика", "Баранова", "1993-11-26");
INSERT students (first_name, last_name, birth_date) VALUES ("Кристина", "Самойлова", "1993-12-22");
INSERT students (first_name, last_name, birth_date) VALUES ("Рита", "Погасай", "1993-05-12");

INSERT students (first_name, last_name, birth_date) VALUES ("Алена", "Белая", "1994-05-12");
INSERT students (first_name, last_name, birth_date) VALUES ("Алиса", "Яковенко", "1994-03-12");
INSERT students (first_name, last_name, birth_date) VALUES ("Рита", "Демиденко", "1994-03-16");


-- Таблица, хранящая информацию в каком классе учатся учащиеся
CREATE TABLE students_state (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  class_id INT NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students (id),
  FOREIGN KEY (class_id) REFERENCES classes (id)
);

INSERT students_state (student_id, class_id) VALUES (1, 1);
INSERT students_state (student_id, class_id) VALUES (2, 1);
INSERT students_state (student_id, class_id) VALUES (3, 1);

INSERT students_state (student_id, class_id) VALUES (4, 2);
INSERT students_state (student_id, class_id) VALUES (5, 2);
INSERT students_state (student_id, class_id) VALUES (6, 2);

INSERT students_state (student_id, class_id) VALUES (7, 3);
INSERT students_state (student_id, class_id) VALUES (8, 3);
INSERT students_state (student_id, class_id) VALUES (9, 3);

INSERT students_state (student_id, class_id) VALUES (10, 4);
INSERT students_state (student_id, class_id) VALUES (11, 4);
INSERT students_state (student_id, class_id) VALUES (12, 4);

INSERT students_state (student_id, class_id) VALUES (13, 5);
INSERT students_state (student_id, class_id) VALUES (14, 5);
INSERT students_state (student_id, class_id) VALUES (15, 5);


-- Расписание занятий в школе
CREATE TABLE schedule_activities (
   id INT PRIMARY KEY AUTO_INCREMENT,
   starts_at DATETIME NOT NULL,
   finish_at DATETIME NOT NULL,
   activity_name_id INT NOT NULL,
   class_id INT NOT NULL,
   teacher_id INT NOT NULL,
   audience_id INT,
   FOREIGN KEY (activity_name_id) REFERENCES activities (id),
   FOREIGN KEY (class_id) REFERENCES classes (id),
   FOREIGN KEY (teacher_id) REFERENCES teachers (id),
   FOREIGN KEY (audience_id) REFERENCES audience (id)
   );

INSERT schedule_activities (starts_at, finish_at, activity_name_id, class_id, teacher_id, audience_id) VALUES ("2024-05-03 08:00:00", "2024-05-03 08:45:00", 1, 1, 1, 1);
INSERT schedule_activities (starts_at, finish_at, activity_name_id, class_id, teacher_id, audience_id) VALUES ("2024-05-03 08:00:00", "2024-05-03 08:45:00", 2, 2, 2, 2);
INSERT schedule_activities (starts_at, finish_at, activity_name_id, class_id, teacher_id, audience_id) VALUES ("2024-05-03 08:00:00", "2024-05-03 08:45:00", 3, 3, 3, 3);
INSERT schedule_activities (starts_at, finish_at, activity_name_id, class_id, teacher_id, audience_id) VALUES ("2024-05-03 08:00:00", "2024-05-03 08:45:00", 4, 4, 4, 4);
INSERT schedule_activities (starts_at, finish_at, activity_name_id, class_id, teacher_id, audience_id) VALUES ("2024-05-03 08:00:00", "2024-05-03 08:45:00", 5, 5, 5, 5);


-- Создано предстваление на получение итогов: Каждому ученику у которого занятие начинаетс в "2024-05-03 08:00:00", показать в каком он классе, кто руководитель предмета, в какой аудитории занятие, сам предмет.
CREATE VIEW students_lessons_totals AS
SELECT CONCAT(students.first_name, " ", students.last_name) AS student, classes.class,  CONCAT(teachers.first_name, " ", teachers.last_name) AS teacher, audience.audience_num AS aud, activities.activity_name, schedule_activities.starts_at
FROM students
LEFT JOIN students_state ON students.id = students_state.student_id
JOIN classes ON students_state.class_id = classes.id
JOIN schedule_activities ON schedule_activities.class_id = classes.id
JOIN teachers ON schedule_activities.teacher_id = teachers.id
JOIN audience ON schedule_activities.audience_id = audience.id
JOIN activities ON schedule_activities.activity_name_id = activities.id
WHERE schedule_activities.starts_at = "2024-05-03 08:00:00";
