with Ada.Text_IO;

package body Submarine.Navigation_IO is

    package XYZ_Direction_IO is new Ada.Text_IO.Enumeration_IO (XYZ_Direction);

    package Distance_IO is new Ada.Text_IO.Integer_IO (Distance);

    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out CourseCommand)
    is
    begin
        XYZ_Direction_IO.Get
           (File => File,
            Item => Item.Direction);
        Distance_IO.Get
           (File => File,
            Item => Item.Amount);
    end get;

end Submarine.Navigation_IO;
