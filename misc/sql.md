# Introduction to SQL

[***Table of Contents***](/README.md)  

SQL (Structured Query Language) is a domain-specific language designed for
managing data in databases. It's primary use is to talk to databases. You can
create, read, update, delete (CRUD) data in databases.

A database is an organized collection of data. A relational database has
columns (or fields) and rows (records). Databases are designed to store large
amounts of data. A piece of software used to interact with databases is called
a database management system (or DBMS). A DBMS based on the relational model is
called a RDBMS. Examples of RDBMS:

- MySQL
- MariaDB, a FOSS fork of MySQL
- PostgreSQL
- Oracle
- Microsoft SQL Server

They all use SQL to manage their databases.

To install mySQL on Ubuntu:

```bash
sudo apt update && sudo apt dist-upgrade
sudo apt install mysql-server
```

Ubuntu should start the `mysql` service by itself:

```bash
systemctl status mysql
```

If it hasn't started, to start and enable it at the same time:

```bash
sudo systemctl enable --now mysql
systemctl status mysql
```

To launch the MySQL command-line tool:

```bash
sudo mysql # won't start w/o sudo first time
```

The command worked because you're connecting to `localhost` and don't have a
password set. To specify options:

```bash
# mysql -u <username> -h <host> -P <port> -p
mysql -u suser -h host.com -P 3306 -p
```

- `-u` specifies the user
- `-h` specifies the hostname
- `-P` specifies the port number
- `-p` prompts for a password

### SQL commands

To show existing databases (comments start with `--`):

```sql
show databases; -- end every statement with a semicolon ';'
```

To create a database:

```sql
create database shop;
```

To switch to managing a particular database:

```sql
use shop;
```

To show tables of your database:

```sql
show tables;
```

To create a table:

```sql
create table vegetables ( 
          id int,
          name varchar(255),
          region varchar(255),
          freshness int
          );
```

`int` is an integer, `varchar` is a string of length `n`. Check out your tables
again:

```sql
show tables;
```

To see the columns of your table:

```sql
describe vegetables;
```

Defining the columns and fields is a part of defining a schema, the way your
databases are arranged or organized.

To insert a row into your table:

```sql
insert into vegetables values (1, "cucumber", "Mexico", "5");
insert into vegetables values (1, "avocado", "Mexico", "2");
insert into vegetables values (1, "banana", "Ecuador", "4");
```

To show the data inside a table:

```sql
select * from vegetables;
```

You selected every (`*`) column from the table `vegetables`.

To select a specific column:

```sql
select name from vegetables;
```

To choose specific rows based on a specific criterion:

```sql
select * from vegetables where region = "Mexico";
```

You selected all columns from the table `vegetables` where the column origin is
"Mexico". To choose multiple criteria:

```sql
select * from vegetables where region = "Mexico" or region = "Brazil";
```

You can filter things in many different ways.

To remove a record:

```sql
delete from vegetables where name = "cucumber";
```

To change an entry in your table:

```sql
update vegetables set freshness = 4 where name = "cucumber";
```

To see your table sorted in a particular order:

```sql
select * from vegetables order by freshness asc;
```

This sorts by "freshness" in the ascending order. In the descending order:

```sql
select * from vegetables order by freshness desc;
```

To add a field (column):

```sql 
alter table vegetables add expensive boolean;
```

To set a boolean value to true:

```sql
update vegetables set expensive = True where first_name = "avocado";
```

To delete a table:

```sql
# drop table table_name;
drop table vegetables;
```
