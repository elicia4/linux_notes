# `join`

[***Table of Contents***](/README.md)

`join` is used to join lines of *two* files based on a common field.

Say you had two files, 'dates-distros.txt' with these contents:

```
11/25/2008  Fedora 
10/30/2008  Ubuntu 
06/19/2008  SUSE 
05/13/2008  Fedora 
04/24/2008  Ubuntu 
11/08/2007  Fedora
```

And 'dates-versions.txt' with these:

```
11/25/2008  10 
10/30/2008  8.10 
06/19/2008  11.0 
05/13/2008  9 
04/24/2008  8.04 
11/08/2007  8
```

To join these files based on the same field:

```bash
join dates-distros.txt dates-versions.txt
```

By default, `join` uses whitespace as the input field delimiter and a single
space as the output field delimiter. To specify a tab delimiter for both
input and output, use `-t $'\t'`.

## A More Advanced Explanation

It's used to perform the equivalent of relational SQL join between csv files:

```bash
cat a.txt
# 1 Robert
# 2 John
# 3 Bob
cat b.txt
# 2 Item 2
# 3 Item 3
# 4 Item 4
join a.txt b.txt
# 2 John Item 2
# 3 Bob Item 3
```

Imagine you have a tab-separated list of orders that includes the product name
and the order date:

```bash
cat orders.txt
```

```
Butter  2023-10-27
Butter  2023-10-27
Butter  2023-10-27
Eggs    2023-10-26
Eggs    2023-10-28
Flour   2023-10-28
Milk    2023-10-26
Milk    2023-10-28
Milk    2023-10-28
Rice    2023-10-29
Rice    2023-10-30
```

In another file, you have a list of products that includes each item's price:

```bash
cat products.txt
```

```
Eggs    $4.00
Flour   $2.00
Milk    $3.00
Pasta   $2.00
Pizza   $3.00
Rice    $1.00
Steak   $15.00
```

You can join these two sets of records like so:

```bash
join orders.txt products
```

```
Eggs 2023-10-26 $4.00
Eggs 2023-10-28 $4.00
Flour 2023-10-28 $2.00
Milk 2023-10-26 $3.00
Milk 2023-10-28 $3.00
Milk 2023-10-28 $3.00
Rice 2023-10-29 $1.00
Rice 2023-10-30 $1.00
```

Now the order date and item price are included together for each record.

You can explicitly specify the join column index in each file with the `-1` and
`-2` flags:

```bash
join -1 1 -2 1 orders.txt products.txt
```

`--header` enables support for column headers:

```bash
cat orders.txt
```

```
product order_date
Butter  2023-10-27
Butter  2023-10-27
Butter  2023-10-27
Eggs    2023-10-26
Eggs    2023-10-28
Flour   2023-10-28
Milk    2023-10-26
Milk    2023-10-28
Milk    2023-10-28
Rice    2023-10-29
Rice    2023-10-30
```

```bash
cat products.txt
```

```
product price
Eggs    $4.00
Flour   $2.00
Milk    $3.00
Pasta   $2.00
Pizza   $3.00
Rice    $1.00
Steak   $15.00
```

```bash
join --header orders.txt products.txt
```

`-t` allows you to specify a custom column separator:

```bash
join -t ',' orders.txt products.txt
```

By default, `join` performs an inner join. 

But you can also perform a left join:

```bash
join -a 1 -e NULL -o auto orders.txt products.txt
```

A right join:

```bash
join -a 2 -e NULL -o auto orders.txt products.txt
```

Or a full outer join:

```bash
join -a 1 -a 2 -e NULL -o auto orders.txt products.txt
```

`-o` allows you to specify which columns will be present in the output, just
like the select list in a SQL query:

```bash
join -a 1 -a 2 -e NULL -o 1.2 orders.txt products.txt
```

`join` requires that both input files be sorted. If they're not, the output may
be incorrect:

```bash
join <(sort -k 1 a.txt) <(sort -k 1 b.txt) # all good
join a.txt b.txt # could be not so good
```
