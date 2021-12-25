with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

package SevenSegment.Display_Unit is

    Digits_in_Display : constant := 4;
    type Digit_IDs is new Positive range 1 .. Digits_in_Display;

    type Display is
       array (Digit_IDs)
       of Digit_Values;

    type Connection_Matrix is
       array (Segment_IDs, Segment_IDs)
       of Boolean;

    Display_Failure : exception;

    -- -------------
    -- Check Display (Optional)
    -- -------------
    procedure Check (This : Display);

private
end SevenSegment.Display_Unit;
