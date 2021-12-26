with Ada.Unchecked_Conversion;

package body SevenSegment.Wirings is

    -- type Digit_Pattern is recordy
    --     A : Status := OFF;
    --     B : Status := OFF;
    --     C : Status := OFF;
    --     D : Status := OFF;
    --     E : Status := OFF;
    --     F : Status := OFF;
    --     G : Status := OFF;
    -- end record;
    -- for Digit_Pattern use record
    --     A at 0 range 0 .. 0;
    --     B at 0 range 1 .. 1;
    --     C at 0 range 2 .. 2;
    --     D at 0 range 3 .. 3;
    --     E at 0 range 4 .. 4;
    --     F at 0 range 5 .. 5;
    --     G at 0 range 6 .. 6;
    -- end record;
    -- for Digit_Pattern'Size use Integer'Size;


    function To_Binary (Item : Pattern) return Pattern_Binary is
        DP : Pattern_Binary := 2#0000000#;
    begin
        for ID in Segment_IDs loop
            if Item.Segments(ID) = On then
                case ID is
                    when A => 
                        DP := @ or 2#0000001#;
                    when B => 
                        DP := @ or 2#0000010#;
                    when C => 
                        DP := @ or 2#0000100#;
                    when D => 
                        DP := @ or 2#0001000#;
                    when E => 
                        DP := @ or 2#0010000#;
                    when F => 
                        DP := @ or 2#0100000#;
                    when G => 
                        DP := @ or 2#1000000#;
                end case;
            end if;
        end loop;
        return DP;
    end To_Binary;

    function To_Pattern (Item : Pattern_Binary) return Pattern is
        P : Pattern := (Length => 0, Segments => (Others => OFF));
        I : Natural;
    begin
        for ID in Segment_IDs loop
            I := Segment_IDs'Pos(ID) - Segment_IDs'Pos(Segment_IDs'First);
            if (Item and 2**I) > 0 then
                P.Segments(ID) := On;
                P.Length := @+1;
            end if;
        end loop;
        return P;
    end To_Pattern;


    -- function Binary is new Ada.Unchecked_Conversion(Source => Digit_Pattern, Target => Pattern_Binary);

    -- function To_Digit_Pattern (Item : Pattern) return Digit_Pattern is
    --     DP : Digit_Pattern;
    -- begin
    --     DP.A := Item.Segments(A);
    --     DP.B := Item.Segments(B);
    --     DP.C := Item.Segments(C);
    --     DP.D := Item.Segments(D);
    --     DP.E := Item.Segments(E);
    --     DP.F := Item.Segments(F);
    --     DP.G := Item.Segments(G);
    --     return DP;
    -- end To_Digit_Pattern;

    -- function To_Pattern (Item : Digit_Pattern) return Pattern is
    --     P : Pattern;
    -- begin
    --     P.Segments(A) := Item.A;
    --     P.Segments(B) := Item.B;
    --     P.Segments(C) := Item.C;
    --     P.Segments(D) := Item.D;
    --     P.Segments(E) := Item.E;
    --     P.Segments(F) := Item.F;
    --     P.Segments(G) := Item.G;
    --     return P;
    -- end To_Pattern;
            
end SevenSegment.Wirings;