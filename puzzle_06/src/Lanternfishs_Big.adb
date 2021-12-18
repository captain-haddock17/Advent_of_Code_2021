with Lanternfishs_IO;
use Lanternfishs_IO;

with Ada.Text_IO;
use Ada.Text_IO;

package body Lanternfishs_Big is

    NB_Fish_to_be_Created : Natural := 0;

    Nb_of_Fishs  : Population                                    := 0;
    Fish_Index   : Natural range 0 .. Population_Frame_type'Last := 0;
    Nb_of_Frames : Natural                                       := 0;

    -- Big_School_array : Generations_array := (Others => (Others => (BabyFish, null)));

    -- New_Big_School_array_Ptr : Generations_array_Ptr;

    -- ------------------
    -- New_Fish_In_School
    -- ------------------
    procedure New_Fish_In_Big_School
       (Big_School : Generations_array_Ptr;
        Timer      : Life_Timer)
    is
    begin
        Fish_Index                       := @ + 1;
        Big_School (0, Fish_Index).Timer := Timer;
        Big_School (0, Fish_Index).Alive := True;

        Nb_of_Frames := 1;

    end New_Fish_In_Big_School;

    -- -----
    -- Aging
    -- -----
    function Aging
       (Timer : Life_Timer)
        return Life_Timer
    is
        New_Timer : Life_Timer;
    begin
        New_Timer := Timer;
        case New_Timer is
            when Life_Timer'First =>  -- 0
                New_Timer             := Life_Timer (SubLife_Timer'Last); -- 6
                NB_Fish_to_be_Created := @ + 1;
            when Life_Timer'First + 1 .. Life_Timer'Last => -- 2 .. 8
                New_Timer := @ - 1;
        end case;
        return New_Timer;
    end Aging;

    procedure put (Frame : Generations_array_Ptr) is
    begin
        New_Line;
        for Day in 0 .. Nb_Days_of_Generations loop
            for Fish in Population_Frame_type loop
                put (Frame (Day, Fish));
            end loop;
            New_Line;
        end loop;
    end put;

    -- --------------
    -- Populate_Frame
    -- --------------
    procedure Populate_Frame
       (Frame        : Generations_array_Ptr;
        Nb_of_Babies : Population_Frame_type;
        First_Day    : Days_of_Generations_range)
    is
    begin
--        put(Frame);
        for Fish in 1 .. Nb_of_Babies loop
            for Day in First_Day .. Nb_Days_of_Generations loop
                if Frame (Day, Fish).Alive then
                    for NextDay in Day + 1 .. Nb_Days_of_Generations loop
                        Frame (NextDay, Fish).Timer := Aging (Frame (NextDay - 1, Fish).Timer);
                        Frame (NextDay, Fish).Alive := True;
                    end loop;
                end if;
            end loop;
        end loop;
--       put(Frame);
    end Populate_Frame;

    -- -------------------
    -- Next_Big_Generation
    -- -------------------
    function Next_Big_Generation
       (Actual_Frame, New_Frame : Generations_array_Ptr)
        return Population
    is

        Count_Babies_to_Born : Population            := 0;
        Baby_Index           : Population_Frame_type := 1;
    begin
        New_Frame.all := (others => (others => (BabyFish, False)));
        Put ("Frames [" & Nb_of_Frames'Image & "]");

        for Day in Nb_of_Frames .. Nb_Days_of_Generations - 1 loop
            for Fish in Population_Frame_type loop
                if Actual_Frame (Day, Fish).Timer = 0 and Actual_Frame (Day, Fish).Alive then
                    Count_Babies_to_Born                  := @ + 1;
                    New_Frame (Day + 1, Baby_Index).Alive := True;
                    New_Frame (Day + 1, Baby_Index).Timer := BabyFish;
                    Baby_Index                            := @ + 1;
                else
                    New_Frame (Day + 1, Baby_Index).Alive := False;
                end if;
            end loop;
        end loop;

        Nb_of_Frames := @ + 1;

        Populate_Frame
           (Frame        => New_Frame,
            Nb_of_Babies => Population_Frame_type (Count_Babies_to_Born),
            First_Day    => Nb_of_Frames);

        return Count_Babies_to_Born;
    end Next_Big_Generation;

    -- ------------------
    -- Nb_Fishs_in_School
    -- ------------------
    function get_Nb_Fishs_in_School return Population is
    begin
        return Nb_of_Fishs;
    end get_Nb_Fishs_in_School;

end Lanternfishs_Big;
