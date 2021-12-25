with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Display_Unit;
use SevenSegment.Display_Unit;

-- Ada Common Libraries
with Ada.Streams;
use Ada.Streams;

with Ada.Text_IO;

package SevenSegment.Digit_Device_IO is

    type Pattern is record
        Length   : Natural;
        Segments : Segment_array := (others => OFF);
    end record;

    type Digit_Pattern is record
        A : Status := OFF;
        B : Status := OFF;
        C : Status := OFF;
        D : Status := OFF;
        E : Status := OFF;
        F : Status := OFF;
        G : Status := OFF;
    end record;
    for Digit_Pattern use record
        A at 0 range 0 .. 0;
        B at 0 range 1 .. 1;
        C at 0 range 2 .. 2;
        D at 0 range 3 .. 3;
        E at 0 range 4 .. 4;
        F at 0 range 5 .. 5;
        G at 0 range 6 .. 6;
    end record;
    for Digit_Pattern'Size use Integer'Size;

    function To_Pattern (Item : Digit_Pattern) return Pattern;
    function To_Digit_Pattern (Item : Pattern) return Digit_Pattern;

    type Segment_ID_with_Delimiter is record
        ID        : Segment_IDs;
        Delimiter : Boolean;
    end record;

    procedure Read_Pattern
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out Pattern);
    for Pattern'Read use Read_Pattern;

    procedure Read_Segment_ID_With_Delimiter
       (Stream :     not null access Ada.Streams.Root_Stream_Type'Class;
        Item   : out Segment_ID_with_Delimiter);
    for Segment_ID_with_Delimiter'Read use Read_Segment_ID_With_Delimiter;

end SevenSegment.Digit_Device_IO;
