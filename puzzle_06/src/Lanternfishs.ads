package Lanternfishs is

    subtype Life_Timer is Natural range 0 .. 8;
    subtype SubLife_Timer is Natural range 0 .. 6;
    Baby : Life_Timer := 8;

    type Lanternfish;
    type Lanternfish_Ptr is access all Lanternfish;

    type Lanternfish is record
        Timer   : Life_Timer      := 8;
        Sibling : Lanternfish_Ptr := null;
    end record;

    procedure new_fish (Timer : Life_Timer);

    -- function Aging (Timer : Life_Timer) return Life_Timer;

    function next_day return Natural;

    function Nb_Fishs_in_School return Natural;

    function Count_Fishs_in_School return Natural;

end Lanternfishs;
