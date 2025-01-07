# SQL-training notes for self

## History of Databases
- Early databases were hierarchical and network models.
- The 1970s introduced the Relational Model (proposed by E.F. Codd).
- SQL (Structured Query Language) emerged as the standard for relational databases.


## SQL vs NoSQL
### SQL (Relational Databases):
- Structured data organized in tables (rows and columns).
- Follows ACID properties ensuring data integrity.
- Schema-based with predefined structure (e.g., MySQL, PostgreSQL).

### NoSQL (Non-Relational Databases):
- Designed for unstructured or semi-structured data.
- Schema-less and highly scalable (horizontal scaling).
  
Categories:
Key-Value Stores (e.g., Redis),
Document Stores (e.g., MongoDB),
Column-Family Stores (e.g., Cassandra),
Graph Databases (e.g., Neo4j)

## Denormalization
- Intentional redundancy in database design to improve read performance.
- Often used in OLAP systems where fast data retrieval is critical.
- Techniques include: Precomputing aggregates, Combining tables to avoid joins.
  
Tradeoff: Gains in performance at the cost of storage space and possible update anomalies.

## Window Functions
- Perform calculations across a subset of rows (window) related to the current row.
- Do not group rows, preserving individual rows.

Common uses: Rankings (e.g., ROW_NUMBER, RANK), Aggregates (e.g., SUM, AVG with OVER clause), Navigation (e.g., LAG, LEAD)

#### Components:
- PARTITION BY: Divides rows into subsets.
- ORDER BY: Defines the sequence within the window.

## Common Table Expressions (CTEs)
- Temporary named result sets used within a query.
- Improve query readability and manageability.
- Defined using WITH keyword.
  
#### Two Types:
1) Non-recursive CTEs: Simplifies queries with subqueries.
2) Recursive CTEs: Handles hierarchical or iterative queries.

Advantages:
- Easier debugging and reuse.
- Avoids repetition in query logic.
