-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-01
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Depth_Filtering; use Depth_Filtering;

with Ada.Strings.Bounded;
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
-- with Ada.Text_IO.Bounded_IO;

procedure Puzzle_01_B is

    Message : Message_Strings.Bounded_String;

    -- File and Records definitions
    Data_File : File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    Record_index   : Natural := 0;
    Depth_received : Natural := 0;

begin

    -- get the filename
    if Argument_Count /= 1 then
        raise Missing_FileName;
    end if;

    Data_File_Name := OS_File_Name.To_Bounded_String (Argument (1));

    -- Open and read the file
    Open (File => Data_File, Mode => In_File, Name => OS_File_Name.To_String (Data_File_Name));

    while not End_Of_File (Data_File) loop

        Depth_received := Natural'Value (Get_Line (Data_File));
        Record_index   := @ + 1;

        compute_Depth_Filter (Pulse => Record_index, Depth => Depth_received, Message_from_filter => Message);

        Message_IO.put_Line (Message);

    end loop;

    Close (Data_File);

    -- Output the result
    Put_Line ("Number of Depth increases = " & get_DepthCount_Increasing'Image); -- 1611

end Puzzle_01_B;
