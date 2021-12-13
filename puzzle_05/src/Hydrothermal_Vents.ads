package Hydrothermal_Vents is

    subtype Chart_dimension is Natural range 0 .. 1_000;
    -- subtype Chart_dimension is Natural range 0 .. 9;

    type Point is record
        X, Y : Chart_dimension;
    end record;

    subtype Force is Integer;

    type Chart is
       array (Chart_dimension, Chart_dimension)
       of Force;

    type Segment is record
        A, B : Point;
    end record;

    procedure set
       (Map : in out Chart;
        Seg :        Segment);

    function Overlap
       (Map : Chart)
        return Natural;

end Hydrothermal_Vents;
