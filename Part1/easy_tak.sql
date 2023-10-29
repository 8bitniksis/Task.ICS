-- ЗАЛЕСОВ НИКИТА

/* 
    Вывести коды и периоды отпусков сотрудников, которые были в отпуске одновременно в 2020 году
    Одновременный отпуск - когда хотя бы 1 день отпусков у двух сотрудников совпадает
    Дополнение:
    - в случае декретного отпуска сотрудник мог уйти в отпуск в 2019-ом году, а вернуться в 2021-ом
    На выходе:
    - таблица со столбцами (КодСотрудника1, НачалоОтпуска, КонецОтпуска, КодСотрудника2, НачалоОтпуска, КонецОтпуска)
    - должна вернуться одна строка с парой "E01 - E03". При этом "E03 - E01" - это дубль, которого не должно быть в итоговом результате
    Ограничения:
    - правильными считаются решения без использования конструкций "group by", "distinct"
    - нет дублирования кода
    - решение должно быть без использования вспомогательных функций greatest(), least()
    - засчитываются решения БЕЗ использования OR, CASE, CTE
*/

-- Справочник сотрудников
CREATE TABLE Employee (
  ID INT NOT NULL PRIMARY KEY,
  Code VARCHAR(10) NOT NULL UNIQUE,
  Name VARCHAR(255)
);
 
INSERT INTO Employee (ID, Code, Name)
VALUES (1, 'E01', 'Ivanov Ivan Ivanovich'),
  (2, 'E02', 'Petrov Petr Petrovich'),
  (3, 'E03', 'Sidorov Sidr Sidorovich'),
  (4, 'E04', 'Semenov Semen Semenovich'),
  -- Полный тёзка сотрудника E02
  (5, 'E05', 'Petrov Petr Petrovich');
 
-- Отпуска сотрудников
CREATE TABLE Vacation (
  ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ID_Employee INT NOT NULL REFERENCES Employee(ID),
  DateBegin DATE NOT NULL,
  DateEnd DATE NOT NULL
);
 
INSERT INTO Vacation (ID_Employee, DateBegin, DateEnd)
VALUES (1, '2019-08-10', '2019-09-01')
  ,(2, '2019-05-01', '2019-05-15')
  ,(1, '2019-12-29', '2020-01-14')
  ,(3, '2020-01-14', '2020-01-14')
  ,(4, '2021-02-01', '2021-02-14');

-- Проверка пересечения отпусков и вывод дат отпусков и id работников у которых они перескаются
SELECT v1.ID_Employee, v1.DateBegin, v1.DateEnd, v2.ID_Employee, v2.DateBegin, v2.DateEnd
FROM Vacation v1 LEFT JOIN Vacation v2 ON v1.ID_Employee <> v2.ID_Employee
WHERE v1.DateBegin <= v2.DateBegin AND v2.DateBegin <= v1.DateEnd;

-- Проверка декретного отпуска
SELECT * FROM Vacation
WHERE EXTRACT( YEAR FROM DateBegin) = '2019' AND EXTRACT( YEAR FROM DateEnd) = '2021';