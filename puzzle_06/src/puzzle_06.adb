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

with Command_Line;
use Command_Line;

-- Ada Common Libraries
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

-- with Ada.Characters.Latin_1;
-- use Ada.Characters;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_06 is

    -- ----------------------------
    -- File and Run-Time Parameters
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;
    Run_Args  : Command_Line.Program_args;


    -- ---------------------
    -- Objects for computing 
    -- ---------------------
    Day             : Natural    := 0;
    Some_Fish_Timer : Life_Timer := 0;
    Fish_Count      : Population := 0;
    Big_Fish_Count  : Big_Integer;

begin

    -- get the command lien arguments
    Command_Line.get_args (args => Run_Args);

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

        new_fish (Some_Fish_Timer);

    end loop;

    Close (Data_File);

    -- Time and Life is passing by
    Fish_Count := 0;
    while Day < Run_Args.Nb_of_Days loop
        Day        := @ + 1;
        Fish_Count := Next_Day;
    end loop;

    Fish_Count     := get_Nb_Fishs_in_School;
    Big_Fish_Count := Population_IO.To_Big_Integer (Fish_Count);

    -- Output the result
    Put (Trim(Source => Day'Image, Side => Left));
    Put (" days to get ");
    Put (To_String
           (Arg   => Big_Fish_Count,
            Width => 20));
    Put_Line (" fishs.");

end Puzzle_06;

-- $ bin/puzzle_06 data/Puzzle_06.txt
-- Fish_Count 350605
-- Nb_Fishs_in_School 350605
-- Count_Fishs_in_School 350605
--
-- Nb of Days : 80 to get  350605 fishs
