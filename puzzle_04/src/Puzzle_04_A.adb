-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-04
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

-- Specif Libraries
with Bingo;
use Bingo;

with Bingo.Data_IO;
use Bingo.Data_IO;

with Bingo.Called_Numbers_IO;
use Bingo.Called_Numbers_IO;

with Bingo.Boards_IO;
use Bingo.Boards_IO;

-- Common Ada Libraries

with Ada.Command_Line;
use Ada.Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;
-- with Ada.Text_IO.Bounded_IO;

with Ada.Strings;
use Ada.Strings;
with Ada.Strings.Bounded;

with Ada.Characters.Latin_1;
use Ada.Characters;

procedure Puzzle_04_A is

    -- File and Records definitions
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    use Bingo_Data_String;
    use Bingo.Data_IO.Bingo_Data_Stream;

    Some_Data : Bingo_Data_String.Bounded_String;

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
        Bingo_Data_Stream.Get_Line (Data_File, Some_Data);
        Analyse_String_Received (Some_Data);
    end loop;

    Find_Winning_Board;

    Close (Data_File);
    New_Line;

    -- compute_Diagnostics;

    -- compute_Report (Report => Diagostic_Report);

    -- Output the result
    Put_Line ("Diagnostic report:");
    -- Put_Line (Latin_1.HT & "Gamma rate   =" & Diagostic_Report.Gamma'Image);
    -- Put_Line (Latin_1.HT & "Epsilon rate =" & Diagostic_Report.Epsilon'Image);
    -- Put_Line ("Power consumption =" & Integer (Integer (Diagostic_Report.Gamma) * Integer (Diagostic_Report.Epsilon))'Image);

-- Diagnostic report:
--      Gamma rate   = 3437
--      Epsilon rate = 658
-- Power consumption = 2261546

end Puzzle_04_A;
