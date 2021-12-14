with Ada.Text_IO;
use Ada.Text_IO;

package body Lanternfishs is

    School_of_fishs : Lanternfish_Ptr := null; -- first fish
    Last_fish       : Lanternfish_Ptr := null;
    NB_Fish_to_be_Created : natural := 0;

    Nb_of_Fishs : Natural := 0;


    -- --------
    -- New_Fish
    -- --------
    procedure New_Fish (Timer : Life_Timer) is
        Previous_Last_Fish : Lanternfish_Ptr;
    begin
        Previous_Last_Fish := Last_Fish;
        Last_Fish := new Lanternfish;
        Last_Fish.Sibling := null;
        Last_Fish.Timer   := Timer;

        if School_of_fishs = null then
            School_of_fishs := Last_fish; -- First fish :-)
        else
            Previous_Last_Fish.Sibling := Last_Fish;
        end if;

        Nb_of_Fishs       := @ + 1;

    end New_Fish;


    -- ---------
    -- New_Birth
    -- ---------
    procedure New_Birth is
    begin
        New_Fish(8);
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
                New_Timer := SubLife_Timer'Last; -- 6
                NB_Fish_to_be_Created := @ +1;
            -- when Life_Timer'First + 1 =>  -- 1
            --     New_Timer := SubLife_Timer'First; -- 0
            when Life_Timer'First + 1 .. Life_Timer'Last => -- 2 .. 8
                New_Timer := @ - 1;
        end case;
        return New_Timer;
    end Aging;


    -- --------
    -- Next_Day
    -- --------
    function Next_Day return Natural is
        Some_Fish : Lanternfish_Ptr;
    begin
        Some_Fish := School_of_fishs;

        while Some_Fish /= null loop
            Some_Fish.Timer := Aging (Some_Fish.Timer);
            Some_Fish       := Some_Fish.Sibling;
        end loop;

        for i in 1.. NB_Fish_to_be_Created loop
            New_Fish(8);
        end loop;
        NB_Fish_to_be_Created :=0;

        return Nb_of_Fishs;
    end Next_Day;


    -- ------------------
    -- Nb_Fishs_in_School
    -- ------------------
    function Nb_Fishs_in_School return Natural is
    begin
        return Nb_of_Fishs;
    end Nb_Fishs_in_School;

    -- ---------------------
    -- Count_Fishs_in_School
    -- ---------------------
    function Count_Fishs_in_School return Natural is
        Some_Fish : Lanternfish_Ptr;
        Count     : Natural := 0;
    begin
        Some_Fish := School_of_fishs;
        while Some_Fish /= null loop
            Count     := @ + 1;
            Some_Fish := Some_Fish.Sibling;
        end loop;
        return Count;
    end Count_Fishs_in_School;

end Lanternfishs;