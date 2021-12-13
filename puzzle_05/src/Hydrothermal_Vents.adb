package body Hydrothermal_Vents is

    procedure set
       (Map : in out Chart;
        Seg :        Segment)
    is
        AB_Distance_X, AB_Distance_Y : Integer;
    begin
        AB_Distance_X := Seg.B.X - Seg.A.X;
        AB_Distance_Y := Seg.B.Y - Seg.A.Y;
        -- case vertical lines
        if AB_Distance_X = 0 then
            if AB_Distance_Y >= 0 then
                for y in 0 .. AB_Distance_Y loop
                    Map (Seg.A.X, Seg.A.Y + y) := @ + 1;
                end loop;
            end if;
            if AB_Distance_Y < 0 then
                for y in 0 .. abs (AB_Distance_Y) loop
                    Map (Seg.A.X, Seg.A.Y - y) := @ + 1;
                end loop;
            end if;

            -- case horizontal lines
        elsif AB_Distance_Y = 0 then
            if AB_Distance_X >= 0 then
                for x in 0 .. AB_Distance_X loop
                    Map (Seg.A.X + x, Seg.A.Y) := @ + 1;
                end loop;
            end if;
            if AB_Distance_X < 0 then
                for x in 0 .. abs (AB_Distance_X) loop
                    Map (Seg.A.X - x, Seg.A.Y) := @ + 1;
                end loop;
            end if;

            -- case diagonal lines
        elsif abs (AB_Distance_X) = abs (AB_Distance_Y) then

            if AB_Distance_X > 0 and AB_Distance_Y > 0 then
                for i in 0 .. AB_Distance_X loop
                    Map (Seg.A.X + i, Seg.A.Y + i) := @ + 1;
                end loop;
            end if;

            if AB_Distance_X < 0 and AB_Distance_Y < 0 then
                for i in 0 .. abs (AB_Distance_X) loop
                    Map (Seg.A.X - i, Seg.A.Y - i) := @ + 1;
                end loop;
            end if;

            if AB_Distance_X < 0 and AB_Distance_Y > 0 then
                for i in 0 .. abs (AB_Distance_X) loop
                    Map (Seg.A.X - i, Seg.A.Y + i) := @ + 1;
                end loop;
            end if;

            if AB_Distance_X > 0 and AB_Distance_Y < 0 then
                for i in 0 .. AB_Distance_X loop
                    Map (Seg.A.X + i, Seg.A.Y - i) := @ + 1;
                end loop;
            end if;

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
