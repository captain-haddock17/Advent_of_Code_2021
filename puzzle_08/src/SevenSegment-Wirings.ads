with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;

package SevenSegment.Wirings is

    type Pattern_array is array (Digit_Values)
    of Pattern;


    
    type Pattern_Binary is mod 2**7;

    function To_Pattern (Item : Pattern_Binary) return Pattern;
    function To_Binary (Item : Pattern) return Pattern_Binary;


    type Connection_Matrix is
       array (Segment_IDs) of Segment_array;


end SevenSegment.Wirings;