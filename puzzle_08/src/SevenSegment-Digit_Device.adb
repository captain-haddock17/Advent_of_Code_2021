-- Ada Common Libraries
with Ada.Exceptions;

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO;
use Ada.Text_IO;

package body SevenSegment.Digit_Device is

    Digit_Counter : array (Digit_Values)
    of Natural := (others => 0);

    -- -------------
    -- Check 1 Digit
    -- -------------
    procedure Check (This : Digit) is
        Total_Current    : Current;
        Digit_in_default : Digit_Values;
    begin
        Total_Current := 0;
        -- Mesure total current in a digit
        for i in Segment_IDs loop
            if This.Segments (i) = ON then
                Total_Current := @ + 1;
            end if;
        end loop;
        if This.Consumption /= Total_Current then
            Digit_in_default := This.Value;
            raise Segment_in_Digit_Failure;
        end if;
    exception
        when Failure : Segment_in_Digit_Failure =>
            Put_Line (Standard_Error, "Failure in digit #" & Digit_in_default'Image);
            Put_Line (Standard_Error, Latin_1.HT & "Current defined =" & This.Consumption'Image);
            Put_Line (Standard_Error, Latin_1.HT & "Segment count   =" & Total_Current'Image);
            Put_Line (Standard_Error, Ada.Exceptions.Exception_Message (Failure));
            raise;
    end Check;

    -- -------------------------
    -- Check Digits of a display (Optional)
    -- -------------------------
    procedure Check (This : Digit_Display_array) is
    begin
        for Value in Digit_Values loop
            Check (Digit_Display (Value));
        end loop;
    end Check;

end SevenSegment.Digit_Device;
