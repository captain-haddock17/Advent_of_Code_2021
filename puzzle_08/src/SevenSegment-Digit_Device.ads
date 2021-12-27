package SevenSegment.Digit_Device is

    type Segment_IDs is
       (A,
        B,
        C,
        D,
        E,
        F,
        G);

    subtype Current is Natural range 0 .. Segment_IDs'Pos (Segment_IDs'Last) - Segment_IDs'Pos (Segment_IDs'First) + 1;

    subtype Digit_Values is Natural range 0 .. 9;
    Digit_Values_Length : constant Positive :=
       Digit_Values'Pos (Digit_Values'Last) - Digit_Values'Pos (Digit_Values'First) + 1; -- 10

    subtype Status is Boolean;
    OFF : Status := False;
    ON  : Status := True;

    type Segment_array is
       array (Segment_IDs)
       of Status;
    type Segment_Binary is mod 2**(7 * 8);  -- Segment_array'Size
    function To_Binary
       (S : Segment_array)
        return Segment_Binary;

    Segment_in_Digit_Failure : exception;

    type Digit is record
        Value       : Digit_Values;
        Segments    : Segment_array;
        Consumption : Current;
    end record;

    type Digit_Display_array is
       array (Digit_Values)
       of Digit;

    Digit_0 : constant Digit :=
       (Value => 0, Segments => (A => ON, B => ON, C => ON, D => OFF, E => ON, F => ON, G => ON), Consumption => 6);

    Digit_1 : constant Digit :=
       (Value => 1, Segments => (A => OFF, B => OFF, C => ON, D => OFF, E => OFF, F => ON, G => OFF), Consumption => 2);

    Digit_2 : constant Digit :=
       (Value => 2, Segments => (A => ON, B => OFF, C => ON, D => ON, E => ON, F => OFF, G => ON), Consumption => 5);

    Digit_3 : constant Digit :=
       (Value => 3, Segments => (A => ON, B => OFF, C => ON, D => ON, E => OFF, F => ON, G => ON), Consumption => 5);

    Digit_4 : constant Digit :=
       (Value => 4, Segments => (A => OFF, B => ON, C => ON, D => ON, E => OFF, F => ON, G => OFF), Consumption => 4);

    Digit_5 : constant Digit :=
       (Value => 5, Segments => (A => ON, B => ON, C => OFF, D => ON, E => OFF, F => ON, G => ON), Consumption => 5);

    Digit_6 : constant Digit :=
       (Value => 6, Segments => (A => ON, B => ON, C => OFF, D => ON, E => ON, F => ON, G => ON), Consumption => 6);

    Digit_7 : constant Digit :=
       (Value => 7, Segments => (A => ON, B => OFF, C => ON, D => OFF, E => OFF, F => ON, G => OFF), Consumption => 3);

    Digit_8 : constant Digit :=
       (Value => 8, Segments => (A => ON, B => ON, C => ON, D => ON, E => ON, F => ON, G => ON), Consumption => 7);

    Digit_9 : constant Digit :=
       (Value => 9, Segments => (A => ON, B => ON, C => ON, D => ON, E => OFF, F => ON, G => ON), Consumption => 6);

    Digit_Display : Digit_Display_array :=
       (0 => Digit_0,
        1 => Digit_1,
        2 => Digit_2,
        3 => Digit_3,
        4 => Digit_4,
        5 => Digit_5,
        6 => Digit_6,
        7 => Digit_7,
        8 => Digit_8,
        9 => Digit_9);

    -- -------------
    -- Check 1 Digit (Optional)
    -- -------------
    procedure Check (This : Digit);

    -- -------------------------
    -- Check Digits of a display (Optional)
    -- -------------------------
    procedure Check (This : Digit_Display_array);

private

end SevenSegment.Digit_Device;
