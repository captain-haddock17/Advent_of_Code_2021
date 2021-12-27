with SevenSegment.Display_Unit;
use SevenSegment.Display_Unit;

with SevenSegment.Wirings;
use SevenSegment.Wirings;

-- Ada Common Libraries
with Ada.Text_IO;
use Ada.Text_IO;

package SevenSegment.Display_Unit_IO is

    procedure Put_Line
       (File : in File_Type;
        Item :    Connection_Matrix);
    procedure Put_Line (Item : Connection_Matrix);

end SevenSegment.Display_Unit_IO;
