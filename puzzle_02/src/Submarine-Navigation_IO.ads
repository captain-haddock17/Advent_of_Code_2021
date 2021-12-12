with Submarine.Navigation;
use Submarine.Navigation;

with Ada.Text_IO;

package Submarine.Navigation_IO is

    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out CourseCommand);

end Submarine.Navigation_IO;
