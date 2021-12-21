# Advent_of_Code_2021

Some Ada source-code proposals for the puzzles of the [Advent of Code, year 2021](https://adventofcode.com/2021) contest 😎

### See link in calendar

|MON|TUE|WED|THU|FRI|SAT|SUN|
|--|--|--|--|--|--|--|
|-|-|[01](./puzzle_01)|[02](./puzzle_02)|[03](./puzzle_03)|[04](./puzzle_04)|[05](./puzzle_05)|
|[06](./puzzle_06)|[07](./puzzle_07)|08|09|10|11|12|
|13|14|15|16|17|18|19|
|20|21|22|23|24|25|-|

## Goal

Aiming as a show-case of some best(?) Ada 2012/202x coding practices.\

1. **Readability**
1. **Modular** & **Object Oriented** software design
1. Only using the libraries defined and shipped with the language
1. Use **multi-tasking** desing when appropriate
1. Execution time (performance) is not final goal (back to 1. & 2.)

## Comments are welcome !!

Other seasoned or just plain beginner developer have published their Ada code on github (or elsewhere...)

## Ada 202X

I used the forth comming [Ada 202x syntax and language-libraries](http://www.ada-auth.org/standards/ada2x.html)

## Tools used

* Pretty Printer: [GNAT pretty-printer](https://docs.adahttps://docs.adacore.com/gnat_ugn-docs/html/gnat_ugn/gnat_ugn/gnat_utility_programs.html#the-gnat-pretty-printer-gnatpp)
* Compiler: [GNAT CE 2021](https://www.adacore.com/community)
  * GNAT from [GCC 10](https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gnat_ugn/) should also be OK
* Build: [GNAT gprbuild](https://docs.adacore.com/gprbuild-docs/html/gprbuild_ug.html)
* Package-Library manager: [Alire](https://blog.adacore.com/first-beta-release-of-alire-the-package-manager-for-ada-spark)

## How to build & run

```bash
git clone https://github.com/AdaForge/Advent_of_Code_2021.git
cd Advent_of_Code_2021/puzzle_01
alr build
bin/Puzzle_02_A data/Puzzle_01.txt
```

Note: you can also use `gprbuild puzzle_01.gpr` in place of `alr build`

## License & disclaimers

Just plain open-source: [CC0 Universal Public Domain dedication](https://creativecommons.org/publicdomain/zero/1.0/deed.fr)'s
_Free Cultural Work_
