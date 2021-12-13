with Bingo.Board;
use Bingo.Board;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

with Ada.Characters.Latin_1;
use Ada.Characters;

package body Bingo is

    -- -------
    -- Numbers
    -- -------
    Actual_Numbers_in_Play : Natural range 0 .. Max_NumberOutputs_in_Play;

    List_of_Called_Numbers : Called_Numbers;

    procedure add_Called_Number (Number : in Called_Number) is
    begin
        Actual_Numbers_in_Play := Actual_Numbers_in_Play + 1;
        -- Actual_Numbers_in_Play                          := @ + 1;
        List_of_Called_Numbers (Actual_Numbers_in_Play) := Number;
    end add_Called_Number;

    function get_Called_Number
       (i : Called_Index)
        return Called_Number
    is
    begin
        return List_of_Called_Numbers (i);
    end get_Called_Number;

    function get_Actual_Numbers_in_Play return Natural is
    begin
        return Actual_Numbers_in_Play;
    end get_Actual_Numbers_in_Play;

    -- ---------------
    -- Sets of Numbers
    -- ---------------
    procedure put (S : Set_of_Numbers.Set) is separate;


    -- ----
    -- Game
    -- ----
    protected body Game_Status is separate;

end Bingo;
