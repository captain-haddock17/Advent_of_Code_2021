-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-01
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------
with Submarine.Sonar;
use Submarine.Sonar;

with Ada.Command_Line;
use Ada.Command_Line;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Bounded;

procedure Puzzle_01_A is

    Depth_received : Natural;

    DepthCount_Increasing : Natural := 0;

    Data_File : File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

begin

    -- get the filename
    if Argument_Count /= 1 then
        raise Missing_FileName;
    end if;

    Data_File_Name := OS_File_Name.To_Bounded_String (Argument (1));

    -- Open and read the file
    Open
       (File => Data_File,
        Mode => In_File,
        Name => OS_File_Name.To_String (Data_File_Name));

    while not End_Of_File (Data_File) loop
        Depth_received := Natural'Value (Get_Line (Data_File));
        compute_Depth_Increments
           (Depth      => Depth_received,
            Increments => DepthCount_Increasing);
    end loop;

    Close (Data_File);

    -- Open and read the file
    Put_Line ("Number of Depth increases = " & DepthCount_Increasing'Image); -- 1564

end Puzzle_01_A;
