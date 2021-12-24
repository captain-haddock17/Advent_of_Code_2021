with E_Digits;
use E_Digits;

with E_Display;
use E_Display;

-- Ada Common Libraries
with Ada.Streams;
use Ada.Streams;

with Ada.Text_IO;


package E_Digits_IO is

    type Pattern is record
        Length   : Natural;
        Segments : Segment_array := (others => OFF);
    end record;


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

end E_Digits_IO;
