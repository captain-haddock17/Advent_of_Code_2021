package Crabs is

    Max_Crab_Population : constant Positive := 1_000;

    subtype Population is Natural range 0 .. Max_Crab_Population;
    subtype Individual is Population range 1 .. Max_Crab_Population;

    subtype Distance is Integer;

    type Crab_Array is
       array (Individual)
       of Distance;

    subtype Fuel is Integer;
    type Consumption_Type is
       (LINEAR,
        PROGRESSIVE);

    procedure New_Crab (Position : Distance);

    function Compute_Best_Position
       (Fuel_Mode : Consumption_Type)
        return Distance;

    function Global_Fuel_Consumption
       (Mode        : Consumption_Type;
        Destination : Distance)
        return Fuel;

end Crabs;
