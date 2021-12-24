-- Ada Common Libraries
with Ada.Streams;
use Ada.Streams;

with Ada.IO_Exceptions;

with Ada.Characters.Handling;
use Ada.Characters.Handling;

with Ada.Text_IO;


package body E_Digits_IO is

    Separator : Character := ' ';


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

end E_Digits_IO;
