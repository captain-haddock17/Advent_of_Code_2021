with Bingo;
use Bingo;

with Bingo.Jury;
use Bingo.Jury;

package Bingo.Board is


    -- ------
    -- Boards
    -- ------
    subtype H_Index is Positive range 1 .. Board_Dimension;
    subtype V_Index is Positive range 1 .. Board_Dimension;

    type Cell_array is
       array (V_Index, H_Index)
       of Called_Number;
    type Board is record
        Cell : Cell_array;
        Won  : Boolean := False;
    end record;

    type Board_array is
       array (Board_ID)
       of Board;

    procedure create_New_Board;
    function get_Actual_nb_of_Boards return Natural;

    -- ------------
    -- Board actors
    -- ------------

    task type Board_Actor (ID : Board_ID; Jury : Jury_Actor_Ptr) is
        entry Verify (New_Set : Set_of_Numbers.Set);
        entry Compute_Unchecked_Numbers
           (Sum                            : out Natural;
            Last_Winning_Called_Number_Set :     Set_of_Numbers.Set);
        entry Stop;
    end Board_Actor;

    type Board_Actor_Ptr is access Board_Actor;

    -- -----------------
    -- Board Sets & Rows
    -- -----------------
    type Row_array is
       array (H_Index)
       of Called_Number;

    type Board_Set_info is record
        Set : Set_of_Numbers.Set (Count_Type (Board_Dimension));
        Won : Boolean := False;
    end record;

    subtype VH_range is Positive range 1 .. V_Index'Last + H_Index'Last;
    type Board_Set_Array is
       array (VH_range)
       of Board_Set_info;

    procedure store_Row (This_Row : in Row_array);
    function get_Current_Row return Natural;

    -- -------
    -- Winners
    -- -------
    NB_Winning_Boards : Natural range 0 .. Max_Boards_in_Play := 0;
    procedure Flag_Winner (ID : Board_ID);
    function is_Last_Winner return Boolean;
    function get_Nb_of_Winners return Natural;


end Bingo.Board;