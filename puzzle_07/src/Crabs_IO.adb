with Ada.Text_IO;

package body Crabs_IO is

    Separator : Character := ',';

    -- --------
    -- Get_Next
    -- --------
    procedure Get_Next
       (File :        Ada.Text_IO.File_Type;
        Item : in out Distance)
    is
    begin
        Ada.Text_IO.Get
           (File => File,
            Item => Separator);
        get
           (File => File,
            Item => Item);
    end Get_Next;

    -- ---
    -- Get
    -- ---
    procedure Get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Distance)
    is
    begin
        Distance_IO.Get
           (File => File,
            Item => Item);
    end Get;

    procedure put (Item : Crab_Array) is
    begin
        for i in Item'Range loop
            Ada.Text_IO.Put (i'Image);
            Ada.Text_IO.Put (Item (i)'Image);
            exit when i = Distance'First;
        end loop;
    end put;

end Crabs_IO;
