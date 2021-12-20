with Lanternfishs_IO;
use Lanternfishs_IO;

with Ada.Text_IO;
use Ada.Text_IO;

package body Lanternfishs_Relatives is

    School_of_fishs       : Lanternfish_Ptr := null; -- First fish in tyhe School
    Last_fish             : Lanternfish_Ptr := null;
    NB_Fish_to_be_Created : Natural         := 0;
    Nb_of_Fishs           : Population      := 0;

--     Nb_of_Fishs : Population := 0;
--    Fish_Index : Natural range 0 .. Population_Frame_type'Last := 0;
--    Nb_of_Frames : Natural := 0;

    -- --------
    -- New_Fish
    -- --------
    procedure New_Fish (Timer : Life_Timer) is
        Previous_Last_Fish : Lanternfish_Ptr;
    begin
        Nb_of_Fishs          := @ + 1;
        Previous_Last_Fish   := Last_fish;
        Last_fish            := new Lanternfish_chain;
        Last_fish.Sibling    := null;
        Last_fish.Fish.Timer := Timer;
        Last_fish.Fish.Alive := True;

        if School_of_fishs = null then
            School_of_fishs := Last_fish; -- First fish :-)
        else
            Previous_Last_Fish.Sibling := Last_fish;
        end if;
    end New_Fish;

    -- ---------
    -- New_Birth
    -- ---------
    procedure New_Birth is
    begin
        New_Fish (8);
    end New_Birth;

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

    -- --------
    -- Next_Day
    -- --------
    function Next_Day return Population is
        Some_Fish : Lanternfish_Ptr;
    begin
        Some_Fish := School_of_fishs;

        while Some_Fish /= null loop
            Some_Fish.Fish.Timer := Aging (Some_Fish.Fish.Timer);
            Some_Fish            := Some_Fish.Sibling;
        end loop;

        for i in 1 .. NB_Fish_to_be_Created loop
            New_Fish (BabyFish);
        end loop;
        NB_Fish_to_be_Created := 0;

        return Nb_of_Fishs;
    end Next_Day;

    -- ------------------
    -- Nb_Fishs_in_School
    -- ------------------
    function get_Nb_Fishs_in_School return Population is
    begin
        return Nb_of_Fishs;
    end get_Nb_Fishs_in_School;

    -- ---------------------
    -- Count_Fishs_in_School
    -- ---------------------
    function Count_Fishs_in_School return Population is
        Some_Fish : Lanternfish_Ptr;
        Count     : Population := 0;
    begin
        Some_Fish := School_of_fishs;
        while Some_Fish /= null loop
            Count     := @ + 1;
            Some_Fish := Some_Fish.Sibling;
        end loop;
        return Count;
    end Count_Fishs_in_School;

end Lanternfishs_Relatives;
