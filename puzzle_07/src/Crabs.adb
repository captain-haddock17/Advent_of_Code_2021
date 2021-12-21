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
    -- Cesaro_Summation
    -- ----------------
    function Cesaro_Summation
       (Dist : Distance)
        return Fuel
    is
        Total : Fuel := 0;
    begin
        for i in 1 .. Dist loop
            Total := @ + i;
        end loop;
        return Total;
    end Cesaro_Summation;

    -- ----------------
    -- Fuel_Consumption
    -- ----------------
    function Fuel_Consumption
       (Mode     : Consumption_Type := LINEAR;
        From, To : Distance)
        return Fuel
    is
        Distance_to_go : Distance;
    begin
        Distance_to_go := abs (To - From);
        case Mode is
            when LINEAR =>
                return Fuel (Distance_to_go);
            when PROGRESSIVE =>
                return Cesaro_Summation (Distance_to_go);
        end case;
    end Fuel_Consumption;

    -- -----------------------
    -- Global_Fuel_Consumption
    -- -----------------------
    function Global_Fuel_Consumption
       (Mode     : Consumption_Type;
        Data     : Crab_Array;
        Position : Distance)
        return Fuel
    is
        Total : Fuel := 0;
    begin
        for i in Individual'First .. Actual_Crab_Population loop
            Total := @ + Fuel_Consumption
                  (Mode => Mode,
                   From => Data (i),
                   To   => Position);
        end loop;
        return Total;
    end Global_Fuel_Consumption;

    -- -----------------------
    -- Global_Fuel_Consumption
    -- -----------------------
    function Global_Fuel_Consumption
       (Mode        : Consumption_Type;
        Destination : Distance)
        return Fuel
    is
    begin
        return Global_Fuel_Consumption
              (Mode     => Mode,
               Data     => Crab,
               Position => Destination);
    end Global_Fuel_Consumption;

    -- ---------------------
    -- Compute_Best_Position
    -- ---------------------
    function Compute_Best_Position
       (Fuel_Mode : Consumption_Type)
        return Distance
    is

        subtype Actual_Individual is Individual range Individual'First .. Actual_Crab_Population;

        function Minimum_Fuel is new Root_Finding.Discrete.Sweep.Minimum
           (X => Individual, Y => Fuel, F => Crab_Array, Mode_enum => Consumption_Type, Regression => Global_Fuel_Consumption);

    begin
        return Minimum_Fuel
              (Mode => Fuel_Mode,
               Data => Crab);
    end Compute_Best_Position;

end Crabs;
