
with Ada.Characters.Handling;
use Ada.Characters.Handling;

with Ada.Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;

package body Command_Line is

    procedure get_args (args : in out Program_args) is

        Bad_Arguments : exception;

        package ACL renames Ada.Command_Line;

    begin

        -- Help ?
        for i in 1 .. ACL.Argument_Count loop
            if ACL.Argument (i) = "-h" then
                raise Bad_Arguments;
            end if;
        end loop;

        case ACL.Argument_Count is 
            when 1 =>
                args.Winner  := FIRST;
                args.Data_File_Name := To_Bounded_String (ACL.Argument (1));

            when 2 =>         
                if to_Upper(ACL.Argument (1)) = "FIRST" then
                    args.Winner  := FIRST;
                elsif to_Upper(ACL.Argument (1)) = "LAST" then
                    args.Winner  := LAST;
                else 
                    raise Bad_Arguments;
                end if;

                args.Data_File_Name := To_Bounded_String (ACL.Argument (2));

            when others =>
                raise Bad_Arguments;
        end case;

    exception
        when Bad_Arguments =>
            New_Line (Standard_Error);
            Put_Line (Standard_Error, "Usage : " & ACL.Command_Name & " [FIRST|LAST] file_name ");
            New_Line (Standard_Error);
            ACL.Set_Exit_Status (ACL.Failure);
            raise;

    end get_args;

end Command_Line;