with Hydrothermal_Vents;
use Hydrothermal_Vents;

with Ada.Text_IO;

package Hydrothermal_Vents_IO is

    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Segment);

    procedure put (Item : Segment);

    procedure put (Map : Chart);

end Hydrothermal_Vents_IO;
