# Advent of Code 2021

Some Ada source-code proposals for the puzzles of the © [Advent of Code, year 2021](https://adventofcode.com/2021) contest prepared by [Eric Wastl](http://was.tl) 😎

## Follow links in this calendar

|MON|TUE|WED|THU|FRI|SAT|SUN|
|--|--|--|--|--|--|--|
|-|-|[01](./puzzle_01)|[02](./puzzle_02)|[03](./puzzle_03)|[04](./puzzle_04)|[05](./puzzle_05)|
|[06](./puzzle_06)|[07](./puzzle_07)|[08](./puzzle_08)|09|10|11|12|
|13|14|15|16|17|18|19|
|20|21|22|23|24|25|-|

Note: There are still other GitHub repositories (20+) with Ada code proposals.

---

## Goal

Aiming as a show-case of some best(?) Ada 2012/202x coding practices.

1. [Readability](https://www.adaic.org/resources/add_content/docs/95style/html/sec_3/toc.html)
1. [Modular](https://www.adaic.org/resources/add_content/docs/95style/html/sec_4/toc.html) & [Object Oriented](https://www.adaic.org/resources/add_content/docs/95style/html/sec_9/9-1.html) software design
1. Only using the libraries defined by the language, and shipped with any Ada compiler
1. Use [multi-tasking design](https://www.adaic.org/resources/add_content/docs/95style/html/sec_6/) when appropriate
1. Execution time (performance) is not a *first class* goal (back to 1. & 2.)

## Comments are welcome 😃

Other seasoned or just plain beginner developer have published their Ada code on github (or elsewhere...)

---

## Ada 202X

I used the forthcoming [Ada 202x syntax and language-libraries](http://www.ada-auth.org/standards/ada2x.html), essentially:

* `@` as a shorthand syntax, as in `Sum := @ + 1;`

---

## Tools used

* Pretty Printer: [GNAT pretty-printer](https://docs.adahttps://docs.adacore.com/gnat_ugn-docs/html/gnat_ugn/gnat_ugn/gnat_utility_programs.html#the-gnat-pretty-printer-gnatpp)
* Compiler: [GNAT CE 2021](https://www.adacore.com/community) with `-gnat2022` activated
  * GNAT from [GCC 10](https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gnat_ugn/) should also be OK (not tested)
* Build: [GNAT gprbuild](https://docs.adacore.com/gprbuild-docs/html/gprbuild_ug.html)
* Package-Library manager: [Alire](https://blog.adacore.com/first-beta-release-of-alire-the-package-manager-for-ada-spark)

---

## How to Build & Run

Alire (`alr`) needs to be initialized through a first `alr build` command. This completes `~/.config/alire/config.toml` file.

To select the working Ada 2022 compiler:

* `alr toolchain --select`
  * and select `gnat_external=2021.0.0 [Detected at /opt/gnat-ce-2021/bin/gnat]`

One may use plain `gprbuild`.

```shell
git clone https://github.com/AdaForge/Advent_of_Code_2021.git
cd Advent_of_Code_2021/puzzle_08
gprbuild
bin/puzzle_08 data/Puzzle_08.txt
```

---

## License & Disclaimers

Just plain open-source: [CC0 Universal Public Domain dedication](https://creativecommons.org/publicdomain/zero/1.0/deed.fr)'s
_Free Cultural Work_
