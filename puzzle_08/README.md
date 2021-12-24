# Design

## Domain description

For the fun of it, I have described the digit system using all what Ada is good for readability 😎

* a `Display` of 4 of `Digits`
* each `Digits` may have 10 different values (`0` .. `9`)
* each `Digit` is made of 7 `Segments` noted `A` through `G`, with predefined values.
* Display has a specific connection (squared) matrix

```Ada
-- Ada pseudo code

type Display is array(1 .. 4 ) of Digit;

type Digit_Values is new Natural range 0 .. 9;

type Digit is record
    Value : Digit_Values;
    Segments : Segment_array;
    Consumption : Current;
end record;

type Segment_array is array (a .. g) of Status (off, on);
type Segment_IDs is (A, B, C, D, E, F, G);

Digit_0 : constant Digit := (
    Value => 0, 
    Segments => (
        A => On,
        B => On,
        C => On,
        D => Off,
        E => On,
        F => On,
        G => On
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

## Using best Ada *goodies*

To `read` the different `[a-g]+` patterns having different lengths, a specific object `Pattern` is defined in package `E_Digits_IO`:

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

## Algorithms

(...)

## Using Exceptions

For the fun of it (and to illustrate), you will find some usage of Ada Exception mecanism.
Two `Check` procedures verifies the (theorical) health of each `Segment`.
They verify the correct number of lit segments compared to the predifined current.

`Segment_in_Digit_Failure` could raise, and trigger `Display_Failure` exception.
