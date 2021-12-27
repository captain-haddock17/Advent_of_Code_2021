with SevenSegment.Digit_Device;
use SevenSegment.Digit_Device;

with SevenSegment.Digit_Device_IO;
use SevenSegment.Digit_Device_IO;

package body SevenSegment.Display_Unit_IO is

    -- --------
    -- Put_Line
    -- --------
    procedure Put_Line
       (File : in File_Type;
        Item :    Connection_Matrix)
    is
    begin
        for ID in Segment_IDs loop
            Put (File, '[' & ID'Image & "]:");
            Put (File, Item (ID));
            New_Line (File);
        end loop;
    end Put_Line;

    -- --------
    -- Put_Line
    -- --------
    procedure Put_Line (Item : Connection_Matrix) is
    begin
        Put_Line (Standard_Output, Item);
    end Put_Line;

end SevenSegment.Display_Unit_IO;
