with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Wirings;
use SevenSegment.Wirings;

with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;
package SevenSegment.Display_Unit is

    Digits_in_Display : constant := 4;
    subtype Digit_IDs is Positive range 1 .. Digits_in_Display;

    type Display is
       array (Digit_IDs)
       of Digit_Values;

    DISPLAY_FAILURE  : exception;
    NO_SEGMENT_MATCH : exception;

    -- -------------
    -- Check Display (Optional)
    -- -------------
    procedure Check (This : Display);

    procedure Match_Connections
       (Matrix   : in out Connection_Matrix;
        Patterns :        Pattern_array);

    function Connect
       (This   : Pattern;
        Matrix : Connection_Matrix)
        return Digit_Values;

    function To_Number(This : Display) return Natural;

    function To_String(This : Display) return String;

private
end SevenSegment.Display_Unit;
