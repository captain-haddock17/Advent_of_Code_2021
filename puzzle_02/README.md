# Design

## Loading of the data file
* code with some I/O are organized in packages with name suffix `_IO`
* The (text) Data structured file is read through Ada's standard [Ada.Text_IO](http://www.ada-auth.org/standards/12rm/html/RM-A-10-1.html#I6319) features  with use of the generic `Enumeration_IO` and `Integer_IO` packages. 😎
* This permits to convert *straigt* the (string) data values `FORWARD`, `DOWN`, `UP` to the internal values of the defined enumeration type *XYZ_Direction*  😍
```
type XYZ_Direction is
       (FORWARD,
        DOWN,
        UP);
```` 
