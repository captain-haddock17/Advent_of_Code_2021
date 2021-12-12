-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-02
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Submarine.Binary_Diagnostic;
use Submarine.Binary_Diagnostic;

with Ada.Strings.Bounded;
with Ada.Command_Line;
use Ada.Command_Line;

with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Characters.Latin_1;
use Ada.Characters;

procedure Puzzle_03_A is

    -- File and Records definitions
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    Data_Length     : Natural                                                := 0;
    Diagnostic_Data : String (1 .. Nb_of_Binary_diagnostic_Channels + 2)     := (others => '0');
    Diagnostic_Str  : String (1 .. Nb_of_Binary_diagnostic_Channels + 2 + 3) := (others => '0');
    Diagnostic_Val  : Binary_diagnostic;

    Diagostic_Report : Failure_Rate := (Gamma => 0, Epsilon => 0);

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

        Ada.Text_IO.Get_Line (Data_File, Diagnostic_Data, Data_Length);
        Put ('.');  -- some I/O tracing
        Diagnostic_Str                        := (others => ' ');
        Diagnostic_Str (1 .. Data_Length + 3) := "2#" & Diagnostic_Data (1 .. Data_Length) & "#";
        Diagnostic_Val                        := Binary_diagnostic'Value (Diagnostic_Str);

        store_Diagnostic (Binary_Puzzle => Diagnostic_Val);

    end loop;

    Close (Data_File);
    New_Line;

    compute_Diagnostics;

    compute_Report (Report => Diagostic_Report);

    -- Output the result
    Put_Line ("Diagnostic report:");
    Put_Line ("Power consumption    =" & Integer (Integer (Diagostic_Report.Gamma) * Integer (Diagostic_Report.Epsilon))'Image);
    Put_Line (Latin_1.HT & "Gamma rate   =" & Diagostic_Report.Gamma'Image);
    Put_Line (Latin_1.HT & "Epsilon rate =" & Diagostic_Report.Epsilon'Image);


end Puzzle_03_A;

-- $ bin/Puzzle_03_A data/Puzzle_03.txt
-- (...)
-- Diagnostic report:
--      Gamma rate   = 3437
--      Epsilon rate = 658
-- Power consumption = 2261546
