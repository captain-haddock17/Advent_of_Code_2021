with Ada.Strings.Bounded;
with Ada.Text_IO.Bounded_IO;

package Bingo is

    -- -------
    -- Numbers
    -- -------
    Max_NumberOutputs_in_Play : constant Positive := 100;

    subtype Called_Number is Natural;
    type Called_Numbers is
       array (1 .. Max_NumberOutputs_in_Play)
       of Called_Number;

    procedure add_Called_Number (Number : in Called_Number);
    function get_Actual_Numbers_in_Play return Natural;

    -- ------
    -- Boards
    -- ------
    Board_Dimension    : constant Positive := 5;
    Max_Boards_in_Play : constant Positive := (Board_Dimension - 1) * Board_Dimension**2; -- 100
    Do_we_create_a_New_Board : Boolean := False;

    subtype Index_in_Row is Positive range 1 .. Board_Dimension;
    type Row_array is
       array (Index_in_Row)
       of Called_Number;

    subtype Board_V_Index is Positive range 1 .. Board_Dimension;
    type Board is
       array (Board_V_Index, Index_in_Row)
       of Called_Number;

    subtype Board_ID is Positive range 1 .. Max_Boards_in_Play;
    type Set_of_Boards is
       array (Board_ID)
       of Board;

    procedure create_New_Board;
    function get_Actual_nb_of_Boards return Natural;

    procedure store_Row (This_Row : in Row_array);
    function get_Current_Row return Natural;

    function First_Winning_Board return Board_ID;

end Bingo;
