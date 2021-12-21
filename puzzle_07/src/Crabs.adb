with Root_Finding.Discrete.Sweep;
use Root_Finding.Discrete.Sweep;

package body Crabs is

    Actual_Crab_Population : Population := 0;
    Crab                   : Crab_Array := (others => 0);


    -- --------
    -- New_Crab
    -- --------
    procedure New_Crab (Position : Distance) is
    begin
        Actual_Crab_Population        := @ + 1;
        Crab (Actual_Crab_Population) := Position;

    end New_Crab;

    -- ----------------
    -- Fuel_Consumption
    -- ----------------
    function Fuel_Consumption
       (From, To : Distance)
        return Fuel
    is
    begin
        return abs (To - From);
    end Fuel_Consumption;

    -- -----------------------
    -- Global_Fuel_Consumption
    -- -----------------------
    function Global_Fuel_Consumption
       (Data     : Crab_Array;
        Position : Distance)
        return Fuel
    is
        Total : Fuel := 0;
    begin
        for i in Individual'First .. Actual_Crab_Population loop
            Total := @ + Fuel_Consumption
                  (From => Data (i),
                   To   => Position);
        end loop;
        return Total;
    end Global_Fuel_Consumption;

    -- -----------------------
    -- Global_Fuel_Consumption
    -- -----------------------
    function Global_Fuel_Consumption
       (Destination : Distance)
        return Fuel
    is
    begin
        return Global_Fuel_Consumption (Crab, Destination);
    end Global_Fuel_Consumption;

    -- ---------------------
    -- Compute_Best_Position
    -- ---------------------
    function Compute_Best_Position return Distance is

       subtype Actual_Individual is Individual range Individual'First .. Actual_Crab_Population;

       function Minimum_Fuel is new Root_Finding.Discrete.Sweep.Minimum
           (X => Individual, Y => Fuel, F => Crab_Array, Regression => Global_Fuel_Consumption);

    begin
        return Minimum_Fuel (Crab);
    end Compute_Best_Position;

end Crabs;
