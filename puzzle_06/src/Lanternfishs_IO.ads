with Lanternfishs;
use Lanternfishs;

with Ada.Text_IO;

package Lanternfishs_IO is

    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Life_Timer);

    procedure get_next
       (File :        Ada.Text_IO.File_Type;
        Item : in out Life_Timer);

end Lanternfishs_IO;
