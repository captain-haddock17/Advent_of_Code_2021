package Crabs is

    Max_Crab_Population : constant Positive := 1_000;

    subtype Population is Natural range 0 .. Max_Crab_Population;
    subtype Individual is Population range 1 .. Max_Crab_Population;

    subtype Distance is Integer;

    type Crab_Array is
       array (Individual)
       of Distance;

    subtype Fuel is Integer;

    procedure New_Crab (Position : Distance);

    function Compute_Best_Position return Distance;

    function Global_Fuel_Consumption
       (Destination : Distance)
        return Fuel;

end Crabs;
