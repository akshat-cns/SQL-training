select * from Issued;
+---------+--------+--------+------------+------------+
| IssueID | BookID | Member | IssueDate  | ReturnDate |
+---------+--------+--------+------------+------------+
|       1 |      1 | Akshat | 2025-01-01 | 2025-01-10 |
|       2 |      3 | Dev    | 2025-01-02 | NULL       |
|       3 |      2 | Daksh  | 2025-01-03 | NULL       |
+---------+--------+--------+------------+------------+
3 rows in set (0.00 sec)

SELECT Books.Title, Issued.Member from Books INNER JOIN Issued using(BookID);
+---------------+--------+
| Title         | Member |
+---------------+--------+
| The secret    | Akshat |
| The Alchemist | Daksh  |
| Beloved       | Dev    |
+---------------+--------+
3 rows in set (0.00 sec)

SELECT Books.Title, Issued.Member, Issued.IssueDate  from Books LEFT JOIN Issued using(BookID);
+---------------+--------+------------+
| Title         | Member | IssueDate  |
+---------------+--------+------------+
| The secret    | Akshat | 2025-01-01 |
| The Alchemist | Daksh  | 2025-01-03 |
| Beloved       | Dev    | 2025-01-02 |
+---------------+--------+------------+
3 rows in set (0.00 sec)

SELECT Books.Title, Issued.Member, Issued.IssueDate  from Books RIGHT JOIN Issued using(BookID);
+---------------+--------+------------+
| Title         | Member | IssueDate  |
+---------------+--------+------------+
| The secret    | Akshat | 2025-01-01 |
| The Alchemist | Daksh  | 2025-01-03 |
| Beloved       | Dev    | 2025-01-02 |
+---------------+--------+------------+
3 rows in set (0.00 sec)

SELECT Books.Title, Issued.Member FROM Books CROSS JOIN Issued;
+---------------+--------+
| Title         | Member |
+---------------+--------+
| Beloved       | Akshat |
| The Alchemist | Akshat |
| The secret    | Akshat |
| Beloved       | Dev    |
| The Alchemist | Dev    |
| The secret    | Dev    |
| Beloved       | Daksh  |
| The Alchemist | Daksh  |
| The secret    | Daksh  |
+---------------+--------+
9 rows in set (0.00 sec)

Select Title,Price FROM Books WHERE Price = (SELECT MAX(Price) FROM Books);
+---------------+-------+
| Title         | Price |
+---------------+-------+
| The Alchemist |   850 |
+---------------+-------+
1 row in set (0.00 sec)

SELECT Title,(SELECT COUNT(*) FROM Issued where Issued.BookID=Books.BookID) AS Borrowcnt FROM Books;
+---------------+-----------+
| Title         | Borrowcnt |
+---------------+-----------+
| The secret    |         1 |
| The Alchemist |         1 |
| Beloved       |         1 |
+---------------+-----------+
3 rows in set (0.00 sec)

Delete FROM Issued where IssueID=1;
Query OK, 1 row affected (0.01 sec)

Select * from Books UNION Select * from Issued;
+--------+---------------+---------------+------------+------+
| BookID | Title         | Author        | Price      | Type |
+--------+---------------+---------------+------------+------+
|      1 | The secret    | Rhonda Byrne  | 500        | NULL |
|      2 | The Alchemist | Paulo Coelho  | 850        | NULL |
|      3 | Beloved       | Toni Morrison | 400        | NULL |
|      2 | 3             | Dev           | 2025-01-02 | NULL |
|      3 | 2             | Daksh         | 2025-01-03 | NULL |
+--------+---------------+---------------+------------+------+
5 rows in set (0.00 sec)

Select * from Books INTERSECT  Select * from Issued;
Empty set (0.00 sec)

Select BookID FROM Books INTERSECT Select BookID FROM Issued;
+--------+
| BookID |
+--------+
|      2 |
|      3 |
+--------+
2 rows in set (0.00 sec)

Select BookID FROM Books EXCEPT Select BookID FROM Issued;
+--------+
| BookID |
+--------+
|      1 |
+--------+
1 row in set (0.00 sec)

select * from Issued;
+---------+--------+--------+------------+------------+
| IssueID | BookID | Member | IssueDate  | ReturnDate |
+---------+--------+--------+------------+------------+
|       2 |      3 | Dev    | 2025-01-02 | NULL       |
|       3 |      2 | Daksh  | 2025-01-03 | NULL       |
+---------+--------+--------+------------+------------+
2 rows in set (0.00 sec)

select IssueID, BookID, Member, IssueDate, ROW_NUMBER() OVER (PARTITION BY BookID) AS row_num from Issued;
+---------+--------+--------+------------+---------+
| IssueID | BookID | Member | IssueDate  | row_num |
+---------+--------+--------+------------+---------+
|       3 |      2 | Daksh  | 2025-01-03 |       1 |
|       2 |      3 | Dev    | 2025-01-02 |       1 |
+---------+--------+--------+------------+---------+
2 rows in set (0.01 sec)

select IssueID, BookID, Member, IssueDate, RANK() OVER (PARTITION BY BookID) from Issued;
+---------+--------+--------+------------+-----------------------------------+
| IssueID | BookID | Member | IssueDate  | RANK() OVER (PARTITION BY BookID) |
+---------+--------+--------+------------+-----------------------------------+
|       3 |      2 | Daksh  | 2025-01-03 |                                 1 |
|       2 |      3 | Dev    | 2025-01-02 |                                 1 |
+---------+--------+--------+------------+-----------------------------------+
2 rows in set (0.01 sec)

select IssueID, BookID, Member, IssueDate, DENSE_RANK() OVER (PARTITION BY BookID) from Issued;
+---------+--------+--------+------------+-----------------------------------------+
| IssueID | BookID | Member | IssueDate  | DENSE_RANK() OVER (PARTITION BY BookID) |
+---------+--------+--------+------------+-----------------------------------------+
|       3 |      2 | Daksh  | 2025-01-03 |                                       1 |
|       2 |      3 | Dev    | 2025-01-02 |                                       1 |
+---------+--------+--------+------------+-----------------------------------------+
2 rows in set (0.00 sec)

SELECT BookID,Title,Author, LEAD(BookID,1) OVER (ORDER BY BookID) from Books;
+--------+---------------+---------------+---------------------------------------+
| BookID | Title         | Author        | LEAD(BookID,1) OVER (ORDER BY BookID) |
+--------+---------------+---------------+---------------------------------------+
|      1 | The secret    | Rhonda Byrne  |                                     2 |
|      2 | The Alchemist | Paulo Coelho  |                                     3 |
|      3 | Beloved       | Toni Morrison |                                  NULL |
+--------+---------------+---------------+---------------------------------------+
3 rows in set (0.00 sec)

SELECT BookID,Title,Author, LAG(BookID,1) OVER (ORDER BY BookID) AS prev_id from Books;
+--------+---------------+---------------+---------+
| BookID | Title         | Author        | prev_id |
+--------+---------------+---------------+---------+
|      1 | The secret    | Rhonda Byrne  |    NULL |
|      2 | The Alchemist | Paulo Coelho  |       1 |
|      3 | Beloved       | Toni Morrison |       2 |
+--------+---------------+---------------+---------+
3 rows in set (0.01 sec)