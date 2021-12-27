# Design

## Domain description

For the fun of it, I have described the digit system using all what Ada is good for readability 😎

* a `Display` of 4 of `Digits`
* each `Digits` may have 10 different values (`0` .. `9`)
* each `Digit` is made of 7 `Segments` noted `A` through `G`, with predefined values.
* Display has a specific connection (squared) matrix

```Ada
-- Ada pseudo code

type Display is array (1 .. 4) of Digit;

subtype Digit_Values is Natural range 0 .. 9;

type Digit is record
    Value : Digit_Values;
    Segments : Segment_array;
    Consumption : Current;
end record;

type Segment_array is array (A .. G) of Status (off, on);
type Segment_IDs is (A, B, C, D, E, F, G);

Digit_0 : constant Digit := (
    Value => 0, 
    Segments => (
        A => ON,
        B => ON,
        C => ON,
        D => OFF,
        E => ON,
        F => ON,
        G => ON
        ),
    Consumption => 6
    );
(...)

type Connection_Matrix is array (Segment_IDs, Segment_IDs) of Boolean;

```

## Loading of the data file

A line will be read in 3 operations:

* 10 `signal patterns` (length based on *actual* length of the combined 10 digits (segments) = 60)
* delimiter  `| `
* the 4 `digit output` values.

### Using some of the best Ada *goodies* ❤️ : `Streams`

Each kind of object will have his own `'Read` procedure. see [§ Stream-Oriented Attributes](http://www.ada-auth.org/standards/12rm/html/RM-13-13-2.html)

To `read` the different `[a-g]+` patterns having different lengths, a specific object `Pattern` is defined in package `SevenSegment.Digit_Device_IO`:

```Ada
type Pattern is record
    Length   : Natural;
    Segments : Segment_array := (others => OFF);
end record;
```

Using Ada standard build-in `Stream` features, and `Stream attributes`, decoding the data file is elegant and readable.

```Ada
procedure Read_Pattern
    (Stream :     not null access Root_Stream_Type'Class;
    Item   : out Pattern);

for Pattern'Read use Read_Pattern;


procedure Read_Segment_ID_With_Delimiter
    (Stream :     not null access Root_Stream_Type'Class;
    Item   : out Segment_ID_with_Delimiter);

for Segment_ID_with_Delimiter'Read use Read_Segment_ID_With_Delimiter;
```

### Package `Ada.Streams.Stream_IO` vs `Ada.Text_IO.Text_Streams`
To cope with the end of line not having a usable pattern, basic `Stream_IO` is prefered over `Text_Streams`.\
`Stream_IO` do not *eat* the `CR/LF` characters which can be used as delimiter(s) of the last `[a-g]+` pattern.

### Using some of the best Ada *goodies* ❤️ : [Unchecked Conversion](http://www.ada-auth.org/standards/12rm/html/RM-13-9.html)

Usage:

```Ada
-- build corresponding segments of some Digit `S`
    for ID in Segment_IDs loop
        if (To_Binary (Matrix (ID)) and To_Binary (This.Segments)) /= 0 then
            S (ID) := ON;
        end if;
    end loop;
```

Definition:

```Ada
    function To_Binary
       (S : Segment_array)
        return Segment_Binary
    is
        function Binary is new Ada.Unchecked_Conversion 
            (Source => Segment_array, 
             Target => Segment_Binary);
    begin
        return Binary (S);
    end To_Binary;
```

### Using some of the best Ada *goodies* ❤️ : [Logical operations on arrays of booleans](http://www.ada-auth.org/standards/12rm/html/RM-4-5-1.html)


```Ada
PV_1, PV_4, PV_069 : Segment_array;
(...)
    Matrix (B) := (PV_4 xor PV_1) and PV_069;
```

## Algorithms

* Store any `[a-g]+` pattern in a (sorted) array `Signal_Pattern`
  * ```Signal_Pattern (D) := Some_Pattern;```
* Define for each occurence a `Digit_Matrix`
* Compute the right combination of segment attribution
  * `Match_Connections (Digit_Matrix, Signal_Pattern);`
* Store any output pattern `[a-g]+` in an array 
  * `Output_Value (D) := Some_Pattern;`
* Find out which digit value corresponds to a given segment combination
  * `Connect (Some_Pattern, Digit_Matrix);`
  
```Ada
-- Compute the matrix
Matrix (F) := PV_1 and PV_069;
Matrix (C) := Matrix (F) xor PV_1;
Matrix (A) := PV_7 and PV_235;
Matrix (B) := (PV_4 xor PV_1) and PV_069;
Matrix (D) := (PV_4 xor PV_1) and PV_235;
Matrix (G) := ((PV_235 and PV_069) xor PV_7) xor PV_1;
Matrix (E) := PV_8 xor (PV_4 or PV_069);
```

## Using Exceptions

For the fun of it (and to illustrate), you will find some usage of Ada Exception mecanism.
Two `Check` procedures verifies the (theorical) health of each `Segment`.
They verify the correct number of lit segments compared to the predefined current.

`SEGMENT_IN_DIGIT_FAILURE` exception could raise, and trigger `DISPLAY_FAILURE` exception.
