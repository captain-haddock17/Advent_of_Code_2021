# Design

# Structure of the source files
- Code with some I/O are organized in packages with name suffix `_IO`
- implementation code (`body') are put in `separate` files to keep the main *package body* files tidy 😎 

## Loading of the data file
- Standard library `Ada.Text_IO.Bounded_IO` is used to get each Data line. 

## Data storage
1. Data are *first* stored in `array`s, so it can be manipulated easily
2. Each `board` will create 10 [Set](http://www.ada-auth.org/standards/12rm/html/RM-A-18-7.html)s of numbers (one per row, one per column). Numbers come from the former `array`s.
3. To be memory friendly, [Ada.Containers.Bounded_Ordered_Sets](http://www.ada-auth.org/standards/12rm/html/RM-A-18-24.html)`.Set` is used, which is ... bounded to the max of `100` elements, and has nice features as `Union` and `Difference`.

## Multi-tasking 😍
#### BOARD
- Each *board* will have his own thread (`task`) delivering:
     - **loading data** in the 5+5 `Set`s
     - **searching after** a winning `Set` on a series of given `Called Numbers`
     - **computing** the end results


#### JURY
* There is also a *Jury* thread (`task`)
  - **accepting** a Winning Board/Set
  - **ruling for victoy** (*First* winning board / *Last* winning board ) and *Game Over*

#### SHARED ACCESS of data
- [Protected ressources](http://www.ada-auth.org/standards/12rm/html/RM-9-4.html), avoiding races between threads
  - *Game Status*
  - *Board of called Numbers*
