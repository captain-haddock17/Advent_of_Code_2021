-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-05
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Lanternfishs;
use Lanternfishs;

with Lanternfishs_IO;
use Lanternfishs_IO;

with Ada.Strings.Bounded;

with Ada.Command_Line;
use Ada.Command_Line;

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_06 is

    -- File and Records definitions
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    -- Definitions
    -- -----------
    Some_Fish_Timer : Life_Timer := 0;
    Fish_Count : Natural := 0;
    Nb_of_Days : Natural := 0;

    Max_Nb_Days : constant Positive := 80;

begin

    -- get the filename
    if Argument_Count /= 1 then
        raise Missing_FileName;
    end if;

    Data_File_Name := OS_File_Name.To_Bounded_String (Argument (1));

    -- Open and read the file
    Ada.Text_IO.Open
       (File => Data_File,
        Mode => Ada.Text_IO.In_File,
        Name => OS_File_Name.To_String (Data_File_Name));

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
    Nb_of_Days := 0;
    while Nb_of_Days < Max_Nb_Days loop
        Nb_of_Days := @+1;
        Fish_Count := next_day;
        -- Put_Line ("Day" & Nb_of_Days'Image & " : " & Fish_Count'Image & " Fishs.");
    end loop;

    Put_Line ("Fish_Count" & Fish_Count'Image);
    Put_Line ("Nb_Fishs_in_School" & Nb_Fishs_in_School'Image);
    Put_Line ("Count_Fishs_in_School" & Count_Fishs_in_School'Image);
    New_Line;
    -- Output the result
    Put_Line ("Nb of Days :" & Nb_of_Days'Image & " to get " & Fish_Count'Image & " fishs.");

end Puzzle_06;

-- $ bin/Puzzle_06 data/Puzzle_06.txt
-- Fish_Count 350605
-- Nb_Fishs_in_School 350605
-- Count_Fishs_in_School 350605
--
-- Nb of Days : 80 to get  350605 fishs
