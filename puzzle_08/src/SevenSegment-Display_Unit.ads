with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Wirings;
use SevenSegment.Wirings;

with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;
package SevenSegment.Display_Unit is

    Digits_in_Display : constant := 4;
    type Digit_IDs is new Positive range 1 .. Digits_in_Display;

    type Display is
       array (Digit_IDs)
       of Digit_Values;

   
    Display_Failure : exception;

    -- -------------
    -- Check Display (Optional)
    -- -------------
    procedure Check (This : Display);

    procedure Match_Connections ( Matrix : in out Connection_Matrix; Patterns : Pattern_array);

    function Connect(This : Pattern; Matrix : Connection_Matrix) return Digit_Values;

private
end SevenSegment.Display_Unit;
