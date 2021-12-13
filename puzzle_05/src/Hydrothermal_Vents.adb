package body Hydrothermal_Vents is

    procedure set
       (Map : in out Chart;
        Seg :        Segment)
    is
    begin
        -- case vertical lines
        if Seg.A.X = Seg.B.X then
            for y in Seg.A.Y .. Seg.B.Y loop
                Map (Seg.A.X, y) := @ + 1;
            end loop;
            for y in Seg.B.Y .. Seg.A.Y loop
                Map (Seg.A.X, y) := @ + 1;
            end loop;
            -- case horizontal lines
        elsif Seg.A.Y = Seg.B.Y then
            for x in Seg.A.X .. Seg.B.X loop
                Map (x, Seg.A.Y) := @ + 1;
            end loop;
            for x in Seg.B.X .. Seg.A.X loop
                Map (x, Seg.A.Y) := @ + 1;
            end loop;
        end if;

    end set;

    function Overlap
       (Map : Chart)
        return Natural
    is
        Count     : Natural           := 0;
        Threshold : constant Positive := 2;
        Value     : Force;
    begin
        for y in Chart_dimension loop
            for x in Chart_dimension loop
                Value := Map (x, y);
                if Value >= Threshold then
                    Count := @ + 1;
                end if;
            end loop;
        end loop;
        return Count;
    end Overlap;

end Hydrothermal_Vents;
