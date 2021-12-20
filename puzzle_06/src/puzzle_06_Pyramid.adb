-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-06
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Lanternfishs;
use Lanternfishs;

with Lanternfishs_IO;
use Lanternfishs_IO;

with Lanternfishs_Pyramid;
use Lanternfishs_Pyramid;

with Command_Line;
use Command_Line;

-- Ada Common Libraries
with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_06_Pyramid is

    -- ----------------------------
    -- File and Run-Time Parameters
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;
    Run_Args  : Command_Line.Program_args;

    -- ---------------------
    -- Objects for computing
    -- ---------------------
--    Day             : Natural    := 0;
    Some_Fish_Timer : Life_Timer := 0;
    Fish_Count      : Population := 0;

begin

    -- get the command lien arguments
    Command_Line.Get_Args (args => Run_Args);

    -- Open and read the file
    Ada.Text_IO.Open
       (File => Data_File,
        Mode => Ada.Text_IO.In_File,
        Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

    while not End_Of_File (Data_File) loop

        if Fish_Count = 0 then
            get
               (File => Data_File,
                Item => Some_Fish_Timer);
        else
            get_next
               (File => Data_File,
                Item => Some_Fish_Timer);
        end if;

        Fish_Count := @ + 1;

        New_Fish (Some_Fish_Timer);

    end loop;

    Close (Data_File);


    -- Time and Life is passing by  
    for D in 1.. Run_Args.Nb_of_Days loop
        Fish_Count := Next_Day;
    end loop;

    -- Output the result
    Put (Trim
           (Source => Run_Args.Nb_of_Days'Image,
            Side   => Left));
    Put (" days to get");
    Put (Fish_Count'Image);
    Put_Line (" fishs.");

end Puzzle_06_Pyramid;

-- $ bin/puzzle_06_Pyramid data/Puzzle_06.txt
-- 256 days to get 1592778185024 fishs.