-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-07
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Crabs;
use Crabs;

with Crabs_IO;
use Crabs_IO;

with Root_Finding.Discrete.Sweep;
use Root_Finding.Discrete.Sweep;

with Command_Line;
use Command_Line;

-- Ada Common Libraries
with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_07 is

    -- ----------------------------
    -- File and Run-Time Parameters
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;
    Run_Args  : Command_Line.Program_args;

    -- ---------------------
    -- Objects for computing
    -- ---------------------
--    Actual_Crab_Population : Individual := 0;
    Some_Distance, Best_Alignement : Distance := 0;
    Global_Fuel                    : Fuel     := 0;
    Crab_Count                     : Natural  := 0;

begin

    -- get the command lien arguments
    Command_Line.Get_Args (args => Run_Args);

    -- Open and read the file
    Ada.Text_IO.Open
       (File => Data_File,
        Mode => Ada.Text_IO.In_File,
        Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

    while not End_Of_File (Data_File) loop

        if Crab_Count = 0 then
            get
               (File => Data_File,
                Item => Some_Distance);
        else
            get -- _next
               (File => Data_File,
                Item => Some_Distance);
        end if;

        New_Crab (Position => Some_Distance);
        Crab_Count := @ + 1;

    end loop;

    Close (Data_File);
    Put_Line ("Number of crabs :" & Crab_Count'Image);

    Best_Alignement := Compute_Best_Position;
    Global_Fuel     := Global_Fuel_Consumption (Best_Alignement);

    -- Output the result
    Put ("Best position to align :");
    Put (Best_Alignement'Image);
    Put_Line (".");

    Put ("Fuel consumed");
    Put (Global_Fuel'Image);
    Put_Line (".");

end Puzzle_07;

-- $ bin/Puzzle_07 data/Puzzle_06.txt
-- 256 days to get 1592778185024 fishs.
