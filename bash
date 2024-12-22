# https://www.baeldung.com/linux/bash-single-vs-double-brackets
[ ] vs. [[ ]]

=== Single Brackets ===

- POSIX-compliant
- More portable

- Accepts default comparison operators: -eq, -ne, -gt, -lt, -ge, -le 
- Accepts comparison operators with char escaping: =, ==, !=, >, \<

- Accepts default boolean operators: -a, -o
- Doesn't accept boolean operators: &&, ||

- Accepts expression grouping with char escaping and spaces: \( \)
- Doesn't accept pattern matching with wildcard: *
- Doesn't accept regular expressions: =~
- Accepts variables with enclosing double quotes to prevent word splitting: "$variable"
# Related to IFS variable: https://www.baeldung.com/linux/ifs-shell-variable


type [
# [ is a shell builtin

[ 3 -eq 3 ] && echo "Numbers are equal"
# Numbers are equal
test 3 -eq 3 && echo "Numbers are equal"
# Numbers are equal

- Bash treats the < operator as a file redirection operator
[ 1 < 2 ] && echo "1 is less than 2"
# bash: 2: No such file or directory

[ 1 \< 2 ] && echo "1 is less than 2"
# 1 is less than 2

[ 3 -eq 3 -a 4 -eq 4 ] && echo "Numbers are equal"
# Numbers are equal
  
[ 3 -eq 3 -o 4 -eq 5 ] && echo "At least two are equal"
# At least two are equal

[ 3 -eq 3 -a (2 -eq 2 -a 1 -eq 1) ] && echo "Parentheses can be used"
# bash: syntax error near unexpected token '('

[ 3 -eq 3 -a \( 2 -eq 2 -a 1 -eq 1 \) ] && echo "Parentheses can be used"
# Parentheses can be used

name="Alice"
[ $name = *c* ] && echo "Name includes c"
# bash: [: too many arguments

name="Alice"
[ $name =~ ^Ali ] && echo "Regular expressions can be used"
# bash: [: =~: binary operator expected

filename="nonexistent file"
[ ! -e $filename ] && echo "File doesn't exist"
# bash: [: nonexistent: binary operator expected

filename="nonexistent file"
[ ! -e "$filename" ] && echo "File doesn't exist"
# File doesn't exist

=== Double Brackets ===

- Not POSIX-compliant
- POSIX reserved keyword
- More convenient

- Accepts default comparison operators: -eq, -ne, -gt, -lt, -ge, -le 
- Accepts comparison operators: =, ==, !=, >, <

- Doesn't accept default boolean operators: -a, -o
- Accepts boolean operators: &&, ||

- Accepts expression grouping: ()
- Accepts pattern matching with wildcard: *
- Accepts regular expressions: =~
- Accepts variables directly without word splitting: $variable

type [[
# [[ is a shell keyword

[[ 1 < 2 ]] && echo "1 is less than 2"
# 1 is less than 2

[[ 3 -eq 3 && 4 -eq 4 ]] && echo "Numbers are equal"
# Numbers are equal

[[ 3 == 3 || 4 == 5 ]] && echo "At least two are equal"
# At least two are equal

[[ 3 = 3 && (2 = 2 && 1 = 1) ]] && echo "Parentheses can be used"
# Parentheses can be used

name="abcd"
[[ $name = *c* ]] && echo "Name includes c"
# Name includes c

name="abcd"
[[ $name =~ ^ab ]] && echo "Regular expressions can be used"
# Regular expressions can be used

filename="nonexistent file"
[[ ! -e $filename ]] && echo "File doesn't exist"
# File doesn't exist
