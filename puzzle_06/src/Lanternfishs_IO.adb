-- with Hydrothermal_Vents;
-- use Hydrothermal_Vents;

with Ada.Text_IO;

package body Lanternfishs_IO is

--    package Life_Timer_IO is new Ada.Text_IO.Integer_IO (Life_Timer);

    Separator : Character := ',';

    -- ---
    -- get
    -- ---
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

    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Life_Timer)
    is
        Char : Character;
        i : integer;
    begin
        ada.Text_IO.Get
           (File => File,
            Item => Char);
        Item := Life_Timer'Value(" "&Char);
    end get;

end Lanternfishs_IO;
