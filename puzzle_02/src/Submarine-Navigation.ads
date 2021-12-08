-- use Ada.Strings;
with Ada.Streams;

package Submarine.Navigation is

    -- Definition of the Positional system
    subtype Distance is Integer;

    type Position_Info is record
        Forward : Distance := 0;
        Depth   : Distance := 0;
    end record;
    type Aim_Info is record
        Aim   : Distance := 0;
        Depth : Distance := 0;
    end record;

    type XYZ_Direction is
       (FORWARD,
        DOWN,
        UP);

    type CourseCommand is record
        Direction : XYZ_Direction;
        Amount    : Distance;
    end record;

    -- -------------
    -- Main function
    -- -------------
    procedure compute_Course
       (Position           : in out Position_Info;
        Command            :        CourseCommand);
    procedure compute_Aim
       (Aim                : in out Aim_Info;
        Command            :        CourseCommand);
        -- -----------------------------------
        -- Read function for Data Text Streams
        -- -----------------------------------

    procedure Read_CourseCommand
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out CourseCommand);
    for CourseCommand'Read use Read_CourseCommand;

    procedure Read_Direction
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out XYZ_Direction);
    for XYZ_Direction'Read use Read_Direction;

    procedure Read_Distance
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out Distance);
        -- for Integer'Read use Read_Distance;

end Submarine.Navigation;
