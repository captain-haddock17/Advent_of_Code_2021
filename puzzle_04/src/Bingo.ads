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

    -- ------
    -- Boards
    -- ------
    Board_Dimension          : constant Positive := 5;
    Max_Boards_in_Play       : constant Positive := (Board_Dimension - 1) * Board_Dimension**2; -- 100
    Do_we_create_a_New_Board : Boolean           := False;

    subtype Board_ID is Positive range 1 .. Max_Boards_in_Play;

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

    protected Protected_Board is
        procedure store_Number
           (ID : Board_ID;
            V  : V_Index;
            H  : H_Index;
            N  : Called_Number);
        function get_Number
           (ID : Board_ID;
            V  : V_Index;
            H  : H_Index)
            return Called_Number;
        procedure Flag_Winner (ID : Board_ID);
        function is_Last_Winner return Boolean;
        function get_Nb_of_Winners return Natural;
    private
        Protected_Boards  : Board_array                           := (others => (Cell => <>, Won => False));
        NB_Winning_Boards : Natural range 0 .. Max_Boards_in_Play := 0;
    end Protected_Board;

    type Row_array is
       array (H_Index)
       of Called_Number;

    function get_Actual_nb_of_Boards return Natural;

    procedure store_Row (This_Row : in Row_array);
    function get_Current_Row return Natural;

    procedure create_New_Board;

    -- ----
    -- Game
    -- ----
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

    -- ----------
    -- Jury actor
    -- ----------
    task type Jury_Actor is
        entry Winning_Board
           (ID                             : Board_ID;
            Last_Winning_Called_Number_Set : Set_of_Numbers.Set);
        entry get_Winner_ID
           (ID                             :    out Board_ID;
            Last_Winning_Called_Number_Set : in out Set_of_Numbers.Set);

    end Jury_Actor;
    Jury : Jury_Actor;

    -- ------------
    -- Board actors
    -- ------------

    task type Board_Actor (ID : Board_ID) is
        entry Verify (New_Set : Set_of_Numbers.Set);
        entry Compute_Unchecked_Numbers
           (Sum                            : out Natural;
            Last_Winning_Called_Number_Set :     Set_of_Numbers.Set);
        entry Stop;
    end Board_Actor;

    type Board_Actor_Ptr is access Board_Actor;

end Bingo;
