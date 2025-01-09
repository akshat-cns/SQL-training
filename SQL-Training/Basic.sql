show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+

CREATE database practice;
Query OK, 1 row affected (0.00 sec)

use practice;
Database changed;

CREATE TABLE Books(
     BookID INT PRIMARY KEY,
     Title VARCHAR(100),
     Author VARCHAR(100),
     Price INT);
Query OK, 0 rows affected (0.01 sec)

ALTER TABLE Books ADD Type VARCHAR(50);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

INSERT INTO Books(BookID,Title,Author,Price) VALUES
     (1,'The Secret','Rhonda Byrne',500),
     (2,'The Alchemist','Paulo Coelho',900),
     (3,'Beloved','Toni Morrison',400);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

select * from Books;
+--------+---------------+---------------+-------+------+
| BookID | Title         | Author        | Price | Type |
+--------+---------------+---------------+-------+------+
|      1 | The Secret    | Rhonda Byrne  |   500 | NULL |
|      2 | The Alchemist | Paulo Coelho  |   900 | NULL |
|      3 | Beloved       | Toni Morrison |   400 | NULL |
+--------+---------------+---------------+-------+------+

Update Books SET Price=850 WHERE BookID=2;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

Select * from Books;
+--------+---------------+---------------+-------+------+
| BookID | Title         | Author        | Price | Type |
+--------+---------------+---------------+-------+------+
|      1 | The Secret    | Rhonda Byrne  |   500 | NULL |
|      2 | The Alchemist | Paulo Coelho  |   850 | NULL |
|      3 | Beloved       | Toni Morrison |   400 | NULL |
+--------+---------------+---------------+-------+------+

Delete from Books WHERE BookID=1;
Query OK, 1 row affected (0.00 sec)

CREATE USER 'user1'@'localhost' IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.01 sec)

GRANT SELECT,INSERT ON practice.* TO 'user1'@'localhost';
Query OK, 0 rows affected (0.01 sec)

REVOKE INSERT ON practice.* from 'user1'@'localhost';
Query OK, 0 rows affected (0.00 sec)

BEGIN;
Query OK, 0 rows affected (0.01 sec)

DELETE FROM Books WHERE BookID=1;
Query OK, 0 rows affected (0.00 sec)

ROLLBACK;
Query OK, 0 rows affected (0.00 sec)

BEGIN;
Query OK, 0 rows affected (0.00 sec)

DELETE FROM Books WHERE BookID=2;
Query OK, 1 row affected (0.00 sec)

COMMIT;
Query OK, 0 rows affected (0.00 sec)

Select * from Books;
+--------+---------+---------------+-------+------+
| BookID | Title   | Author        | Price | Type |
+--------+---------+---------------+-------+------+
|      3 | Beloved | Toni Morrison |   400 | NULL |
+--------+---------+---------------+-------+------+
1 row in set (0.00 sec)

insert into Books(BookID,Title,Author,Price) values (1,'The secret','Rhonda Byrne',500), (2,'The Alchemist','Paulo Coelho',850);
Query OK, 2 rows affected (0.01 sec)
Records: 2  Duplicates: 0  Warnings: 0

Create table Issued(
     IssueID INT PRIMARY KEY,
     BookID INT,
     Member VARCHAR(50),
     IssueDate DATE,
     ReturnDate DATE,
     FOREIGN KEY (BookID) REFERENCES Books(BookID)
     );
Query OK, 0 rows affected (0.01 sec)

INSERT INTO Issued VALUES 
     (1,1,'Akshat','2025-01-01','2025-01-10'),
     (2,3,'Dev','2025-01-02',NULL),
     (3,2,'Daksh','2025-01-03',NULL);
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0
