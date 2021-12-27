with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;

package SevenSegment.Wirings is

    type Pattern_array is
       array (Digit_Values)
       of Pattern;

    type Connection_Matrix is
       array (Segment_IDs)
       of Segment_array;

end SevenSegment.Wirings;
