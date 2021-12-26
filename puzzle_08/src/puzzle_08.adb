-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-08
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;

with SevenSegment.Display_Unit;
use SevenSegment.Display_Unit;

with SevenSegment.Display_Unit_IO;
use SevenSegment.Display_Unit_IO;

with SevenSegment.Wirings;
use SevenSegment.Wirings;

with Command_Line;
use Command_Line;

-- Ada Common Libraries
with Ada.Streams;

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Strings;
use Ada.Strings;

with Ada.Text_IO;
use Ada;

procedure Puzzle_08 is

    -- ----------------------------
    -- File and Run-Time Parameters
    -- ----------------------------
    Data_File   : File_Type;
    Data_Stream : Stream_Access;
    Run_Args    : Command_Line.Program_args;

    Signal_Pattern : Pattern_array;

    Data_Separator : String := "| ";

    Output_Value : array (Digit_IDs)
    of Pattern;

    -- ---------------------
    -- Objects for computing
    -- ---------------------
    Some_Pattern : Pattern;

    Count_of : array (Digit_Values)
    of Natural := (others => 0);

    Digit_Matrix : Connection_Matrix; 

    myDisplay : Display;
    Number_to_Display : Natural;    
    Grand_Total  : Natural := 0;
begin

    -- get the command lien arguments
    Command_Line.Get_Args (args => Run_Args);

    -- Open and read the file
    Open
       (File => Data_File,
        Mode => In_File,
        Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

    Data_Stream := Stream (Data_File);

    while not End_Of_File (Data_File) loop

        -- Signal_Pattern
        for D in Digit_Values loop

            Pattern'Read (Data_Stream, Some_Pattern);

            -- Store Pattern
            Signal_Pattern (D) := Some_Pattern;

        end loop;

        Match_Connections(Digit_Matrix, Signal_Pattern);

        -- Data_Separator
        String'Read (Data_Stream, Data_Separator);

        -- Output_Value
        for D in Digit_IDs loop
            Pattern'Read (Data_Stream, Some_Pattern);
            Output_Value (D) := Some_Pattern;
            case Some_Pattern.Length is
                when 2 =>
                    Count_of (1) := @ + 1;
                when 4 =>
                    Count_of (4) := @ + 1;
                when 3 =>
                    Count_of (7) := @ + 1;
                when 7 =>
                    Count_of (8) := @ + 1;
                when others =>
                    null;
            end case;

            myDisplay(D) := Connect(Some_Pattern, Digit_Matrix);

        end loop;

    -- Output the result Part ’B’
        Number_to_Display := 0;    
        for D in Digit_IDs loop
            Number_to_Display := @+ myDisplay(D) * 10**(Digit_IDs'Last -D);
            Text_IO.Put(myDisplay(D)'Image);
        end loop;
        Text_IO.New_Line;
        Text_IO.Put_line(Number_to_Display'Image);
        Grand_Total := @+ Number_to_Display;
    end loop;

    Close (Data_File);
    Text_IO.New_Line;

    -- Output the result Part ’A’
    Text_IO.Put_Line ("Count of digits");
    Text_IO.Put_Line (Latin_1.HT & "Digit #1:" & Count_of (1)'Image);
    Text_IO.Put_Line (Latin_1.HT & "Digit #4:" & Count_of (4)'Image);
    Text_IO.Put_Line (Latin_1.HT & "Digit #7:" & Count_of (7)'Image);
    Text_IO.Put_Line (Latin_1.HT & "Digit #8:" & Count_of (8)'Image);

    Text_IO.Put_Line ("Total = " & Natural (Count_of (1) + Count_of (4) + Count_of (7) + Count_of (8))'Image);
    Text_IO.Put_Line ("Sum of all displayed digits =" & Grand_Total'Image);





end Puzzle_08;

-- $ bin/puzzle_08 data/Puzzle_08.txt
-- Count of digits
--      Digit #1: 95
--      Digit #4: 108
--      Digit #7: 93
--      Digit #8: 113
-- Total =  409

-- $ bin/puzzle_08 data/Puzzle_08.txt
