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

    -- --------------
    -- Main functions
    -- --------------
    procedure compute_Course
       (Position : in out Position_Info;
        Command  :        CourseCommand);

    procedure compute_Aim
       (Aim     : in out Aim_Info;
        Command :        CourseCommand);

end Submarine.Navigation;
