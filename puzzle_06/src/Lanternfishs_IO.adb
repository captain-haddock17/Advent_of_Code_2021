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

    procedure put (Item : Lanternfish) is
    begin
        if Item.Alive then
            Ada.Text_IO.Put (Item.Timer'Image);
        else
            null;
            -- Ada.Text_IO.put(" .");
        end if;
    end put;

end Lanternfishs_IO;
