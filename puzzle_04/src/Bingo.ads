with Ada.Containers;
use Ada.Containers;

with Ada.Containers.Bounded_Ordered_Sets;

with Ada.Strings.Bounded;
-- with Ada.Text_IO.Bounded_IO;

package Bingo is

    -- -------
    -- Numbers
    -- -------
    Max_NumberOutputs_in_Play : constant Positive := 100;

    subtype Called_Number is Natural;

    subtype Called_Index is Positive range 1 .. Max_NumberOutputs_in_Play;
    type Called_Numbers is
       array (Called_Index)
       of Called_Number;

    procedure add_Called_Number (Number : in Called_Number);
    function get_Called_Number
       (i : Called_Index)
        return Called_Number;
    function get_Actual_Numbers_in_Play return Natural;

    -- ---------------
    -- Sets of Numbers
    -- ---------------

    package Set_of_Numbers is new Ada.Containers.Bounded_Ordered_Sets (Element_Type => Called_Number, "<" => "<", "=" => "=");

    procedure put (S : Set_of_Numbers.Set);



    -- ----
    -- Game
    -- ----
    Board_Dimension          : constant Positive := 5;
    Max_Boards_in_Play       : constant Positive := (Board_Dimension - 1) * Board_Dimension**2; -- 100
    subtype Board_ID is Positive range 1 .. Max_Boards_in_Play;
  
    type Status_of_Game is
       (ACTIVE,
        OVER,
        NO_WINNER);
    type Type_of_Game is
       (FIRST_WINNER,
        LAST_WINNER);

    protected Game_Status is
        function is_Game_Over return Boolean;
        function Has_No_Winner return Boolean;
        function Game_FIRST return Boolean;
        function Game_LAST return Boolean;
        procedure Game_is_Over;
        procedure set_Game_FIRST_Winner;
        procedure set_Game_LAST_Winner;

    private
        Status : Status_of_Game := ACTIVE;
        Stop : Type_of_Game := FIRST_WINNER;
    end Game_Status;


end Bingo;
