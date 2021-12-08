with Ada.Streams;
-- use Ada.Streams;
with Ada.Characters.Latin_1;
use Ada.Characters;

with Ada.Text_IO;
use Ada;

package body Submarine.Navigation is

    procedure Read_CourseCommand
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out CourseCommand)
    is
    begin
        XYZ_Direction'Read (Stream, Item.Direction);
        Read_Distance (Stream, Item.Amount);
    end Read_CourseCommand;

    procedure Read_Direction
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out XYZ_Direction)
    is
        C : Character;
        S : String (1 .. 20);
        i : Natural := 0;
    begin
        loop
            Character'Read (Stream, C);
            i     := @ + 1;
            S (i) := C;
            exit when C = Latin_1.Space or C = Latin_1.HT;
        end loop;
        Item := XYZ_Direction'Value (S (1 .. i - 1));
    end Read_Direction;

    procedure Read_Distance
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out Distance)
    is
        C : Character;
        S : String (1 .. 20);
        i : Natural := 0;
    begin
        loop
            Character'Read (Stream, C);
            i     := @ + 1;
            S (i) := C;
            exit when C = Latin_1.CR or C = Latin_1.LF;  --ADDME: or end_of_file()
        end loop;
        Item := Distance'Value (S (1 .. i - 1));
    end Read_Distance;

    procedure compute_Course
       (Position           : in out Position_Info;
        Command            :        CourseCommand)
    is

    -- Definition of the Positional system
    begin
        case Command.Direction is
            when FORWARD =>
                Position.Forward := @ + Command.Amount;
            when DOWN =>
                Position.Depth := @ + Command.Amount;
            when UP =>
                Position.Depth := @ - Command.Amount;
                if Position.Depth < 0 then
                    Position.Depth := 0;
                end if;
        end case;

    end compute_Course;

    procedure compute_Aim
       (Aim                : in out Aim_Info;
        Command            :        CourseCommand)
    is

    -- Definition of the Positional system
    begin
        case Command.Direction is
            when FORWARD =>
                Aim.Depth := @ + Command.Amount * Aim.Aim;
            when DOWN =>
                Aim.Aim := @ + Command.Amount;
            when UP =>
                Aim.Aim := @ - Command.Amount;
        end case;
    end compute_Aim;

end Submarine.Navigation;
