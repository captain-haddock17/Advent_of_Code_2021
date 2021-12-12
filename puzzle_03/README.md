# Design

## Loading of the data file
* use of Ada's representation of scalar or modular types formated as `base#value#` : ex. `2#10110101#` : 
  - just put `2#` in front, and  `#` at the end of the data 😉  to get the full string representation of the scalar value.

<br>

* use of Ada's standard [Language-Defined Attributes](http://www.ada-auth.org/standards/12rm/html/RM-K-2.html) for those *binary* values
  - `'Value`
  - `'Image`