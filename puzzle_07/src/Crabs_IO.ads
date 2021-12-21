with Crabs;
use Crabs;

with Ada.Text_IO;

package Crabs_IO is

    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Distance);

    procedure get_next
       (File :        Ada.Text_IO.File_Type;
        Item : in out Distance);

    procedure put (Item : Crab_Array);

    package Distance_IO is new Ada.Text_IO.Integer_IO (Distance);
end Crabs_IO;
