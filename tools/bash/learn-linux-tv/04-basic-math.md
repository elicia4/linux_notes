# Basic Math

   [***go back to contents***](01-contents.md)

1. expr - evaluate expressions command

    ```
	expr 30 + 30
    ```
	>60  

   You can add, substract, and divide with `+`, `-` and `/`.  
   You can't multiply with `*` because its reserved in bash (it's a wildcard,
   you can read more on them elsewhere, there are many good youtube guides on
   them).

   You can multiply with `\*`, for example:

   ```
   expr 30 \* 2
   ```
   >60

2. You can create variables and use them as arguments in your expressions:

    ```
	num1=100
	num2=2
	expr $num1 / $num2
    ```
    >50

   [***Go to Next Note***](05-if.md)
