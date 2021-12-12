# Design

## Loading of the data file
- code with some I/O are  organized in packages with name suffix `_IO`
- using Streams `Ada.Text_IO.Bounded_IO`

## Data storage
1. Data are *first* stored in `array`s, so it can be manipulated easily
2. each `board` will create a `Set`of data (one per per, one per column). Data comes from the former `array`s.
3. To be memory friendly, I use `Ada.Containers.Bounded_Ordered_Sets.Set`, wich is ... bounded to the max of 100 elements, and has nice features as `Union` and `Difference`.

## Multi-tasking
* **Each board will have his own thread** (`task`)
  - for *loading data* in the 5+5 `Set`s
  - for *searching after* a winning `Set` on a series of given `Called Numbers`
  - for *computing* the end results


* There is also a *Jury* thread (`task`)
  - *accepting* a Winning Board/Set
  - *ruling for victoy* (First winning board / Last winning board ) and `Game Over`

- **`Protected` ressources**, avoiding races betwean threads
  - *Game Status*
  - *Board of called Numbers*


