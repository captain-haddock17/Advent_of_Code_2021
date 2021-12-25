-- Ada Common Libraries
with Ada.Streams;
use Ada.Streams;

with Ada.IO_Exceptions;

with Ada.Characters.Handling;
use Ada.Characters.Handling;

with Ada.Text_IO;

package body SevenSegment.Digit_Device_IO is

    Separator : Character := ' ';

    function To_Pattern (Item : Digit_Pattern) return Pattern is
        P : Pattern;
    begin
        P.Segments(A) := Item.A;
        P.Segments(B) := Item.B;
        P.Segments(C) := Item.C;
        P.Segments(D) := Item.D;
        P.Segments(E) := Item.E;
        P.Segments(F) := Item.F;
        P.Segments(G) := Item.G;
        return P;
    end To_Pattern;
    
    function To_Digit_Pattern (Item : Pattern) return Digit_Pattern is
        DP : Digit_Pattern;
    begin
        DP.A := Item.Segments(A);
        DP.B := Item.Segments(B);
        DP.C := Item.Segments(C);
        DP.D := Item.Segments(D);
        DP.E := Item.Segments(E);
        DP.F := Item.Segments(F);
        DP.G := Item.Segments(G);
        return DP;
    end To_Digit_Pattern;

    -- ------------
    -- Read_Pattern
    -- ------------
    procedure Read_Pattern
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out Pattern)
    is
        S     : Segment_ID_with_Delimiter;
        Count : Natural := 0;
    begin
        Item.Segments := (others => OFF);
        loop
            Segment_ID_with_Delimiter'Read (Stream, S);
            exit when S.Delimiter;
            Item.Segments (S.ID) := ON;
            Count                := @ + 1;
        end loop;
        Item.Length := Count;
    end Read_Pattern;

    -- ------------------------------
    -- Read_Segment_ID_With_Delimiter
    -- ------------------------------
    procedure Read_Segment_ID_With_Delimiter
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out Segment_ID_with_Delimiter)
    is
        Char : Character;
    begin
        Item.Delimiter := False;
        Character'Read (Stream, Char);
        case To_Upper (Char) is
            when 'A' =>
                Item.ID := A;
            when 'B' =>
                Item.ID := B;
            when 'C' =>
                Item.ID := C;
            when 'D' =>
                Item.ID := D;
            when 'E' =>
                Item.ID := E;
            when 'F' =>
                Item.ID := F;
            when 'G' =>
                Item.ID := G;
            when ' ' =>
                Item.Delimiter := True;
            when others =>
                Item.Delimiter := True;
        end case;
    exception
        when Ada.IO_Exceptions.End_Error =>
            Item.Delimiter := True;

    end Read_Segment_ID_With_Delimiter;

end SevenSegment.Digit_Device_IO;
