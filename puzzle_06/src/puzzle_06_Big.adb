-- ------------------------------------------------
-- Author : William J. FRANCK
-- e-Mail : william@sterna.io
--
-- Initial creation date : 2021-12-06
-- ------------------------------------------------
-- License : CC-BY-SA
-- ------------------------------------------------

with Lanternfishs;
use Lanternfishs;

with Lanternfishs_IO;
use Lanternfishs_IO;

with Lanternfishs_Big;
use Lanternfishs_Big;

with Command_Line;
use Command_Line;

-- Ada Common Libraries
with Ada.Numerics.Big_Numbers.Big_Integers;
use Ada.Numerics.Big_Numbers.Big_Integers;

with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

-- with Ada.Characters.Latin_1;
-- use Ada.Characters;

with Ada.Text_IO;
use Ada.Text_IO;

procedure Puzzle_06_Big is

    -- ----------------------------
    -- File and Run-Time Parameters
    -- ----------------------------
    Data_File : Ada.Text_IO.File_Type;
    Run_Args  : Command_Line.Program_args;

    -- ---------------------
    -- Objects for computing
    -- ---------------------
    Day                   : Natural    := Nb_Days_of_Generations;
    Some_Fish_Timer       : Life_Timer := 0;
    Fish_Count, New_Fishs : Population := 0;
    Big_Fish_Count        : Big_Integer;

    Big_Frame, New_Big_Frame : Generations_array_Ptr;
begin
    Big_Frame     := new Generations_array;
    Big_Frame.all := (others => (others => (7, False)));

    -- get the command lien arguments
    Command_Line.Get_Args (args => Run_Args);

    Put_Line (Integer (Lanternfish'Size / 8)'Image & " bytes");
    Put_Line (Integer (Generations_array'Size / 8)'Image & " bytes");

    -- Open and read the file
    Ada.Text_IO.Open
       (File => Data_File,
        Mode => Ada.Text_IO.In_File,
        Name => OS_File_Name.To_String (Run_Args.Data_File_Name));

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

        New_Fish_In_Big_School (Big_Frame, Some_Fish_Timer);

    end loop;

    Close (Data_File);

    Put_Line ("Fish_Count" & Fish_Count'Image);
    Populate_Frame
       (Frame        => Big_Frame,
        Nb_of_Babies => Population_Frame_type (Fish_Count),
        First_Day    => 0);

    -- Time and Life is passing by
        New_Big_Frame := new Generations_array;
    loop

        New_Fishs := Next_Big_Generation
              (Actual_Frame => Big_Frame,
               New_Frame    => New_Big_Frame);

        Put_Line (New_Fishs'Image & " new fishs.");

        exit when New_Fishs = 0;-- or Fish_Count > 30;
        Fish_Count := @ + New_Fishs;
        Big_Frame.all  := New_Big_Frame.all;
    end loop;

    -- Fish_Count     := get_Nb_Fishs_in_School;
    Big_Fish_Count := Population_IO.To_Big_Integer (Fish_Count);

    -- Output the result
    New_Line;
    Put (Trim
           (Source => Day'Image,
            Side   => Left));
    Put (" days to get ");
    Put (To_String
           (Arg   => Big_Fish_Count,
            Width => 20));
    Put_Line (" fishs.");

end Puzzle_06_Big;

-- $ bin/Puzzle_06_Big data/Puzzle_06_Big.txt
-- 80 days to get               350605 fishs.
-- in 0.023 sec.
