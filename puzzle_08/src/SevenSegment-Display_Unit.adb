with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Exceptions;

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
            raise Display_Failure;
        end if;

    exception
        when Failure : Display_Failure =>

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


    procedure Match_Connections ( Matrix : in out Connection_Matrix; Patterns : Pattern_array) is
        PV_1, PV_4, PV_7 : Segment_array;
        PV_235, PV_069, PV_8 : Segment_array :=  Digit_8.Segments;
    begin

        -- Attribute a value given a Pattern of a given length
        for D in Digit_Values loop
            case Patterns(D).Length is 
                when 2 =>
                    PV_1 := Patterns(D).Segments;
                when 3 =>
                    PV_7 := Patterns(D).Segments;
                when 4 =>
                    PV_4 := Patterns(D).Segments;
                when 5 =>
                    PV_235 := PV_235 and Patterns(D).Segments;
                when 6 =>
                    PV_069 := PV_069 and Patterns(D).Segments;
                when 8 =>
                    PV_8 := Patterns(D).Segments;
                when Others =>
                    null;
            end case;
        end loop;

        -- Compute the matrix
        Matrix(F) := PV_1 and PV_069;
        Matrix(C) := Matrix(F) xor PV_1;
        Matrix(A) := PV_7 and PV_235;
        Matrix(B) := (PV_4 xor PV_1)  and PV_069;
        Matrix(D) := (PV_4 xor PV_1)  and PV_235;
        Matrix(G) := ((PV_235 and PV_069) xor PV_7 ) xor PV_1;
        Matrix(E) := (PV_4 and PV_235) xor PV_8;
        
    end Match_Connections;

    function Connect(This : Pattern; Matrix : Connection_Matrix) return Digit_Values is
    begin
        for ID in Segment_IDs loop
        null;    
        end loop;
        return 8;
    end Connect;

end SevenSegment.Display_Unit;
