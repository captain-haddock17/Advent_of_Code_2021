-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-02
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Submarine.Navigation;
use Submarine.Navigation;

with Ada.Strings.Bounded;
with Ada.Command_Line;
use Ada.Command_Line;
with Ada.Characters.Latin_1;
use Ada.Characters;
-- with Ada.Text_IO.Bounded_IO;

with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;
use Ada.Text_IO;

with Ada.Streams;
-- use Ada.Streams;

procedure Puzzle_02_B is

    Actual_Position : Position_Info := (Forward => 0, Depth => 0);
    Actual_Aim      : Aim_Info      := (Aim => 0, Depth => 0);

    -- File and Records definitions
    -- ----------------------------
    Data_File   : Ada.Text_IO.File_Type;
    Data_Stream : Text_Streams.Stream_Access;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    -- Stream definitions
    -- ------------------
    CourseCommand_received : CourseCommand;

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

    Data_Stream := Text_Streams.Stream (Data_File);

    while not End_Of_File (Data_File) loop

        CourseCommand'Read (Data_Stream, CourseCommand_received);

        -- Ada.Text_IO.Put (CourseCommand_received.Direction'Image);
        -- Ada.Text_IO.Put (" @" & CourseCommand_received.Amount'Image);

        compute_Course
           (Position => Actual_Position,
            Command  => CourseCommand_received);
        compute_Aim
           (Aim     => Actual_Aim,
            Command => CourseCommand_received);
        -- Ada.Text_IO.New_Line;
    end loop;

    Close (Data_File);

    -- Output the result
    Put_Line ("New Position & Aim :");
    Put_Line (Latin_1.HT & "Horizontal :" & Actual_Position.Forward'Image);
    Put_Line (Latin_1.HT & "Depth      :" & Actual_Position.Depth'Image);
    Put_Line (Latin_1.HT & "Aim        :" & Actual_Aim.Aim'Image);
    Put_Line (Latin_1.HT & "Aim Depth  :" & Actual_Aim.Depth'Image);
    Put_Line ("Position redux = " & Distance (Actual_Position.Forward * Actual_Position.Depth)'Image); -- 2147104
    Put_Line ("Aim      redux = " & Distance (Actual_Position.Forward * Actual_Aim.Depth)'Image); -- 2044620088

end Puzzle_02_B;

-- $ bin/Puzzle_02_B data/Puzzle_02.txt
-- New Position & Aim :
--      Horizontal : 1832
--      Depth      : 1172
--      Aim        : 1172
--      Aim Depth  : 1116059
-- Position redux =  2147104
-- Aim      redux =  2044620088
