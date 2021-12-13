with Ada.Strings.Bounded;
use Ada.Strings.Bounded;

package Command_Line is


    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    use OS_File_Name;

    type Game_Kind is (FIRST, LAST);

    type Program_args is
        record
            Data_File_Name : Bounded_String;
            Winner     : Game_Kind := FIRST;
        end record;

    procedure get_args (args : in out Program_args);



end Command_Line;