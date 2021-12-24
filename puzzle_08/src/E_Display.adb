with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Exceptions;


package body E_Display is

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

end E_Display;
