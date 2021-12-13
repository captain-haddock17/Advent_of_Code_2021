-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-02
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Hydrothermal_Vents;
use Hydrothermal_Vents;

with Hydrothermal_Vents_IO;
use Hydrothermal_Vents_IO;

with Ada.Strings.Bounded;

with Ada.Command_Line;
use Ada.Command_Line;

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_05_A is

    -- File and Records definitions
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    -- Stream definitions
    -- ------------------
    Some_Segment          : Segment;
    Map_of_Vents          : Chart   := (others => (others => 0));
    Dangerous_Areas_Count : Natural := 0;

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

        get
           (File => Data_File,
            Item => Some_Segment);

        -- put (Some_Segment);
        -- Ada.Text_IO.New_Line;

        set
           (Map => Map_of_Vents,
            Seg => Some_Segment);

    end loop;

    Close (Data_File);

    -- put (Map_of_Vents);

    -- Output the result
    Dangerous_Areas_Count := Overlap (Map_of_Vents);

    Put_Line ("Dangerous_Areas_Count :" & Dangerous_Areas_Count'Image);

end Puzzle_05_A;

-- $ bin/Puzzle_05_A data/Puzzle_05.txt
-- Dangerous_Areas_Count : 6666
