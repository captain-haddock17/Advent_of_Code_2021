-- with Hydrothermal_Vents;
-- use Hydrothermal_Vents;

with Ada.Text_IO;

package body Hydrothermal_Vents_IO is

    package Chart_dimension_IO is new Ada.Text_IO.Integer_IO (Chart_dimension);
    package Force_IO is new Ada.Text_IO.Integer_IO (Force);

    XY_Separator    : Character := ',';
    Point_Separator : String    := " ->";

    -- ---------
    -- get "X,Y"
    -- ---------
    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Point)
    is
    begin
        Chart_dimension_IO.Get
           (File => File,
            Item => Item.X);
        Ada.Text_IO.Get
           (File => File,
            Item => XY_Separator);
        Chart_dimension_IO.Get
           (File => File,
            Item => Item.Y);
    end get;

    -- ----------------
    -- get "X,Y -> Z,T"
    -- ----------------
    procedure get
       (File :        Ada.Text_IO.File_Type;
        Item : in out Segment)
    is
    begin
        get
           (File => File,
            Item => Item.A);
        Ada.Text_IO.Get
           (File => File,
            Item => Point_Separator);
        get
           (File => File,
            Item => Item.B);
    end get;

    -- ----------------
    -- put "X,Y -> Z,T"
    -- ----------------
    procedure put (Item : Segment) is
        use Ada.Text_IO;
        use Chart_dimension_IO;
    begin
        Put (Item.A.X);
        Put (XY_Separator);
        Put (Item.A.Y);

        Put (Point_Separator);

        Put (Item.B.X);
        Put (XY_Separator);
        Put (Item.B.Y);

    end put;

    -- -------------------------------
    -- display map X lines / Y columns
    -- -------------------------------
    procedure put (Map : Chart) is
    begin
        for y in Chart_dimension loop
            for x in Chart_dimension loop
                if Map (x, y) /= 0 then
                    Force_IO.Put
                       (Item  => Map (x, y),
                        Width => 4);
                else
                    Ada.Text_IO.Put ("   .");
                end if;
            end loop;
            Ada.Text_IO.New_Line;
        end loop;
    end put;

end Hydrothermal_Vents_IO;
