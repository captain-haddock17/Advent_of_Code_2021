-- Ada Common Libraries
with Ada.Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;


package body Command_Line is

    -- --------
    -- Get_Args
    -- --------
    procedure Get_Args (args : in out Program_args) is

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
                args.Data_File_Name := To_Bounded_String (ACL.Argument (1));

            when others =>
                raise Bad_Arguments;
        end case;

    exception
        when Bad_Arguments =>
            New_Line (Standard_Error);
            Put_Line (Standard_Error, "Usage : " & ACL.Command_Name & " file_name ");
            New_Line (Standard_Error);
            ACL.Set_Exit_Status (ACL.Failure);
            raise;

    end Get_Args;

end Command_Line;
