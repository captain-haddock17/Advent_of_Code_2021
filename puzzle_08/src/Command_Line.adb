-- Ada Common Libraries
with Ada.Command_Line;

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO;
use Ada.Text_IO;

package body Command_Line is

    -- --------
    -- Get_Args
    -- --------
    procedure Get_Args (args : in out Program_args) is

        package ACL renames Ada.Command_Line;

    begin

        -- Help ?
        for i in 1 .. ACL.Argument_Count loop
            if ACL.Argument (i) = "-h" then
                raise BAD_ARGUMENTS;
            end if;
        end loop;

        case ACL.Argument_Count is
            when 1 =>
                args.Trace := FALSE;
                args.Data_File_Name := To_Bounded_String (ACL.Argument (1));

            when 2 =>
                if ACL.Argument (1) = "-t" then
                    args.Trace := TRUE;
                else
                    raise BAD_ARGUMENTS;
                end if;
                args.Data_File_Name := To_Bounded_String (ACL.Argument (2));
            when others =>
                raise BAD_ARGUMENTS;
        end case;

    exception
        when BAD_ARGUMENTS =>
            New_Line (Standard_Error);
            Put_Line (Standard_Error, "Usage : " & ACL.Command_Name & " [ -t ] file_name ");
            Put_Line (Standard_Error, "Options:");
            Put_Line (Standard_Error, Latin_1.HT & "-t : Trace of intermediate results");
            New_Line (Standard_Error);
            ACL.Set_Exit_Status (ACL.Failure);
            raise;

    end Get_Args;

end Command_Line;
