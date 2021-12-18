package Lanternfishs is

    BabyFish : constant := 8;

    type Life_Timer is new Natural range 0 .. BabyFish;
    for Life_Timer'Size use 4; -- bits

    subtype SubLife_Timer is Natural range 0 .. 6;

    -- general
    subtype Population is Long_Long_Integer; -- 64 bits

    type Lanternfish is record
        Timer : Life_Timer := BabyFish;
        Alive : Boolean    := False;
    end record;
    for Lanternfish'Size use 8; -- bits
    for Lanternfish use record
        Timer at 0 range 0 .. 3;
        Alive at 0 range 5 .. 5;
    end record;

end Lanternfishs;
