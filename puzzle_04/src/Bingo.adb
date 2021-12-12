-- with Ada.Containers;

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
    type Board_Set_info is record
        Set : Set_of_Numbers.Set (Count_Type (Board_Dimension));
        Won : Boolean := False;
    end record;

    subtype VH_range is Positive range 1 .. V_Index'Last + H_Index'Last;
    type Board_Set_Array is
       array (VH_range)
       of Board_Set_info;

    procedure put (S : Set_of_Numbers.Set) is separate;

    -- ------
    -- Boards
    -- ------
    Actual_Boards_in_Play : Natural range 0 .. Max_Boards_in_Play := 0;

    Current_Row : Positive := V_Index'First;

    Boards_in_game : Board_array;

    protected body Protected_Board is separate;

    procedure create_New_Board is
        MAX_BOARDS_PER_GAME_REACHED : exception;
    begin
        if not (Actual_Boards_in_Play + 1 > Max_Boards_in_Play) then
            Actual_Boards_in_Play := @ + 1;
            Do_we_create_a_New_Board := False; -- Done

        else
            raise MAX_BOARDS_PER_GAME_REACHED;
        end if;

        Current_Row := V_Index'First;
        Put ('[' & Actual_Boards_in_Play'Image & ']');

    exception
        when MAX_BOARDS_PER_GAME_REACHED =>
            New_Line;
            Put_Line ("No more Boards left in Game !!");
            raise;
    end create_New_Board;

    procedure store_Row (This_Row : Row_array) is
        MAX_OF_ROWS_PER_BOARD_REACHED : exception;
    begin
        if Current_Row <= V_Index'Last then

            for i in H_Index loop
                Boards_in_game (Actual_Boards_in_Play).Cell (Current_Row, i) := This_Row (i);
                Protected_Board.store_Number
                   (ID => Actual_Boards_in_Play,
                    V  => Current_Row,
                    H  => i,
                    N  => This_Row (i));
            end loop;
            Current_Row := @ + 1;

        else
            raise MAX_OF_ROWS_PER_BOARD_REACHED;
        end if;

    exception
        when MAX_OF_ROWS_PER_BOARD_REACHED =>
            New_Line;
            Put_Line (Standard_Error, "EXCEPTION: No more rows left in board [" & Actual_Boards_in_Play'Image & "] !!");
            raise;
    end store_Row;


    function get_Current_Row return Natural is
    begin
        return Current_Row;
    end get_Current_Row;


    function get_Actual_nb_of_Boards return Natural is
    begin
        return Actual_Boards_in_Play;
    end get_Actual_nb_of_Boards;


    -- ----
    -- Game
    -- ----
    protected body Game_Status is separate;

    procedure Charge_Sets
       (This_Board :        Board;
        Some_Sets  : in out Board_Set_Array) is separate;

    -- ----------
    -- Jury Actor
    -- ----------
    task body Jury_Actor is separate;

    -- ------------
    -- Board Actors
    -- ------------
    task body Board_Actor is separate;

end Bingo;
