with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;

-- Ada Common Libraries
with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Exceptions;

with Ada.Text_IO;
use Ada.Text_IO;

package body SevenSegment.Display_Unit is

    -- -------------
    -- Check Display (Optional)
    -- -------------
    procedure Check (This : Display) is
        Count_Digits_in_default    : Natural := 0;
        Will_Raise_Display_Failure : Boolean := False;

    begin
        for Some_Digit in Digit_IDs loop

            declare
            begin
                null;
                -- Check (This_Display (Some_Digit));
            exception
                when Segment_in_Digit_Failure =>
                    Count_Digits_in_default    := @ + 1;
                    Will_Raise_Display_Failure := True;
            end;
        end loop;

        if Will_Raise_Display_Failure then
            raise DISPLAY_FAILURE;
        end if;

    exception
        when Failure : DISPLAY_FAILURE =>

            Put (Standard_Error, "Failure in display :");
            Put (Standard_Error, Count_Digits_in_default'Image);
            if Count_Digits_in_default = 1 then
                Put (Standard_Error, " is");
            else
                Put (Standard_Error, " are");
            end if;
            Put_Line (Standard_Error, " faulty.");

            Put_Line (Standard_Error, Ada.Exceptions.Exception_Message (Failure));
            raise;
    end Check;

    -- -----------------
    -- Match_Connections
    -- -----------------
    procedure Match_Connections
       (Matrix   : in out Connection_Matrix;
        Patterns :        Pattern_array)
    is
        PV_1, PV_4, PV_7     : Segment_array;
        PV_235, PV_069, PV_8 : Segment_array := Digit_8.Segments;
    begin

        -- Attribute a value given a Pattern of a given length
        for D in Digit_Values loop
            case Patterns (D).Length is
                when 2 =>
                    PV_1 := Patterns (D).Segments;
                when 3 =>
                    PV_7 := Patterns (D).Segments;
                when 4 =>
                    PV_4 := Patterns (D).Segments;
                when 5 =>
                    PV_235 := PV_235 and Patterns (D).Segments;
                when 6 =>
                    PV_069 := PV_069 and Patterns (D).Segments;
                when 7 =>
                    PV_8 := Patterns (D).Segments;
                when others =>
                    null;
            end case;
        end loop;

        -- Compute the matrix
        Matrix (F) := PV_1 and PV_069;
        Matrix (C) := Matrix (F) xor PV_1;
        Matrix (A) := PV_7 and PV_235;
        Matrix (B) := (PV_4 xor PV_1) and PV_069;
        Matrix (D) := (PV_4 xor PV_1) and PV_235;
        Matrix (G) := ((PV_235 and PV_069) xor PV_7) xor PV_1;
        Matrix (E) := PV_8 xor (PV_4 or PV_069);

    end Match_Connections;

    -- -------
    -- Connect
    -- -------
    function Connect
       (This   : Pattern;
        Matrix : Connection_Matrix)
        return Digit_Values
    is
        S : Segment_array := (others => OFF);

    begin
        -- build corresponding segments of some Digit
        S := (others => OFF);
        for ID in Segment_IDs loop
            if (To_Binary (Matrix (ID)) and To_Binary (This.Segments)) /= 0 then
                S (ID) := ON;
            end if;
        end loop;

        -- find value of Digit
        for i in Digit_Values loop
            if Digit_Display (i).Segments = S then
                return Digit_Display (i).Value;
            end if;
        end loop;

        raise NO_SEGMENT_MATCH; -- should not happen

    end Connect;


    -- ---------
    -- To_Number
    -- ---------
    function To_Number(This : Display) return Natural is
        Number_Displayed : Natural := 0;      
    begin
        for D in Digit_IDs loop
            Number_Displayed := @ + This(D) * 10**(Digit_IDs'Last - D);
        end loop;
        return Number_Displayed;
    end To_Number;

    -- ---------
    -- To_String
    -- ---------
    function To_String(This : Display) return String is
        String_Displayed : String(1 .. Digits_in_Display);
        C : Character;
    begin
        for D in Digit_IDs loop
            C := String(This(D)'Image)(2);
            String_Displayed(D) := C;
        end loop;
        return String_Displayed;
    end To_String;

end SevenSegment.Display_Unit;
