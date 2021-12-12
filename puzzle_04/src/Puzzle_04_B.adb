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

with Ada.Containers;
use Ada.Containers;

with Ada.Text_IO;
use Ada.Text_IO;
-- with Ada.Text_IO.Bounded_IO;

with Ada.Strings;
use Ada.Strings;
with Ada.Strings.Bounded;

with Ada.Characters.Latin_1;
use Ada.Characters;

procedure Puzzle_04_B is

    -- File and Records definitions
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;

    package OS_File_Name is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    Data_File_Name : OS_File_Name.Bounded_String;

    Missing_FileName : exception;

    use Bingo_Data_String;
    use Bingo.Data_IO.Bingo_Data_Stream;

    Some_Data : Bingo_Data_String.Bounded_String;

    Nb_of_Active_Boards : Board_ID;
    Active_Boards       : array (Board_ID)
    of Board_Actor_Ptr;

    New_Called_Set, Winning_Called_Numbers : Set_of_Numbers.Set (Count_Type (Max_NumberOutputs_in_Play));
    Last_Called_Number                     : Called_Number;

    Winner_ID                : Natural range 0 .. Board_ID'Last := 0;
    Sum_of_Unchecked_Numbers : Natural                          := 0;
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

    Put ("Loading array of boards ");
    while not End_Of_File (Data_File) loop
        Bingo_Data_Stream.Get_Line (Data_File, Some_Data);
        Analyze_String_Received (Some_Data);
    end loop;

    Close (Data_File);
    Put_Line (" done.");

    -- Launch_the_Game
    Put_Line ("Launch the Game");
    Game_Status.set_Game_LAST_Winner;
    
    Nb_of_Active_Boards := get_Actual_nb_of_Boards;

-- Launch all the Board Actor threads
    Put ("Launching Board agent ");
    for ID in 1 .. Nb_of_Active_Boards loop
        Active_Boards (ID) := new Board_Actor (ID);
    end loop;
    Put_Line (" done.");

    -- Initialize the list of Calling Numbers with the first 4.
    Put_Line ("Calling Numbers");
    for i in 1 .. Board_Dimension - 1 loop
        Last_Called_Number := get_Called_Number (i);
        Set_of_Numbers.Insert
           (Container => New_Called_Set,
            New_Item  => Last_Called_Number);
    end loop;
    put (New_Called_Set);
    New_Line;

    -- Go through the list of all the Calling Numbers
    for i in Board_Dimension .. get_Actual_Numbers_in_Play loop
        Last_Called_Number := get_Called_Number (i);
        Set_of_Numbers.Insert
           (Container => New_Called_Set,
            New_Item  => Last_Called_Number);
        Put ("{" & Last_Called_Number'Image & "}");

        -- Send set of Calling Numbers to all boards
        for ID in 1 .. Nb_of_Active_Boards loop
                Active_Boards (ID).Verify (New_Set => New_Called_Set);
        end loop;

        exit when Game_Status.is_Game_Over;
    end loop;

    -- Now wait for a winner
    New_Line;
    Put_Line ("Is there a winner ?");
    Jury.get_Winner_ID
       (ID                             => Winner_ID,
        Last_Winning_Called_Number_Set => Winning_Called_Numbers);

    Put_Line ("Compute Unchecked_Numbers and report");
    Active_Boards (Winner_ID).Compute_Unchecked_Numbers
       (Sum                            => Sum_of_Unchecked_Numbers,
        Last_Winning_Called_Number_Set => Winning_Called_Numbers);
    Put_Line ("Sum_of_Unchecked_Numbers" & Sum_of_Unchecked_Numbers'Image);

    for ID in 1 .. Nb_of_Active_Boards loop
        Active_Boards (ID).Stop;
    end loop;

    -- Output the result
    if Game_Status.Has_No_Winner then
        Put_Line ("Winner ID:" & Winner_ID'Image);
    end if;
    Put_Line ("Last Called Number:" & Last_Called_Number'Image); -- Sample.txt: 13
    Put_Line ("Magic Result Number:" & Natural (Last_Called_Number * Sum_of_Unchecked_Numbers)'Image); -- Sample.txt: 1924

end Puzzle_04_B;

-- $ bin/Puzzle_04_A data/Puzzle_04.txt
-- (...)
-- Jury got winner [ 35]
-- Compute Unchecked_Numbers and report
-- End of game.
-- Agregate all numbers in this board
-- Sum_of_Unchecked_Numbers 170
-- Last Called Number: 99
-- Magic Result Number: 16830
