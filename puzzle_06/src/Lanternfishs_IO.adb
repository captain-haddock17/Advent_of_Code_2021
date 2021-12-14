with Ada.Text_IO;

package body Lanternfishs_IO is

    Separator : Character := ',';

    -- --------
    -- Get_Next
    -- --------
    procedure Get_Next
       (File :        Ada.Text_IO.File_Type;
        Item : in out Life_Timer)
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
    -- get
    -- ---
    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Life_Timer)
    is
        Char : Character;
    begin
        Ada.Text_IO.Get
           (File => File,
            Item => Char);
        Item := Life_Timer'Value (" " & Char);
    end get;

end Lanternfishs_IO;
