package body Submarine.Navigation is

    procedure compute_Course
       (Position : in out Position_Info;
        Command  :        CourseCommand)
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
       (Aim     : in out Aim_Info;
        Command :        CourseCommand)
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
