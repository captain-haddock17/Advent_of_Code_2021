with Bingo.Called_Numbers_IO;
use  Bingo.Called_Numbers_IO;

with Ada.Text_IO;
use Ada.Text_IO;

with Ada.Strings.Fixed;
use Ada.Strings.Fixed;

package body Bingo.Board is

    procedure Charge_Sets
       (This_Board :        Board;
        Some_Sets  : in out Board_Set_Array) is separate;

    -- ------
    -- Boards
    -- ------
    Actual_Boards_in_Play : Natural range 0 .. Max_Boards_in_Play := 0;

    Current_Row : Positive := V_Index'First;

    Boards_in_game : Board_array;


    procedure create_New_Board is
        MAX_BOARDS_PER_GAME_REACHED : exception;
    begin
        if not (Actual_Boards_in_Play + 1 > Max_Boards_in_Play) then
            Actual_Boards_in_Play := @ + 1;
        else
            raise MAX_BOARDS_PER_GAME_REACHED;
        end if;

        Current_Row := V_Index'First;

    exception
        when MAX_BOARDS_PER_GAME_REACHED =>
            New_Line;
            Put_Line ("No more Boards left in Game !!");
            raise;
    end create_New_Board;



    function get_Actual_nb_of_Boards return Natural is
    begin
        return Actual_Boards_in_Play;
    end get_Actual_nb_of_Boards;


    -- ------------
    -- Board Actors
    -- ------------
    task body Board_Actor is separate;


    -- ----
    -- Rows
    -- ----
    procedure store_Row (This_Row : Row_array) is
        MAX_OF_ROWS_PER_BOARD_REACHED : exception;
    begin
        if Current_Row <= V_Index'Last then

            for i in H_Index loop
                Boards_in_game (Actual_Boards_in_Play).Cell (Current_Row, i) := This_Row (i);
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


    -- -------
    -- Winners
    -- -------
    procedure Flag_Winner (ID : Board_ID) is
    begin
        case Boards_in_game (ID).Won is
            when False =>
                Boards_in_game (ID).Won := True;
                NB_Winning_Boards         := @ + 1;
            when True =>
                null;
        end case;
    end Flag_Winner;


    function is_Last_Winner return Boolean is
        Total_of_winners : Natural := 0;
        Last_Winner_ERROR : exception;

    begin
        for i in 1 .. get_Actual_nb_of_Boards loop
            if Boards_in_game (i).Won then
                Total_of_winners := @ + 1;
            end if;
        end loop;

        if NB_Winning_Boards /= Total_of_winners then
            raise Last_Winner_ERROR;
        end if;

        if NB_Winning_Boards = get_Actual_nb_of_Boards then
            return True;
        else
            return False;
        end if;
    end is_Last_Winner;


    function get_Nb_of_Winners return Natural is
    begin
        return NB_Winning_Boards;
    end get_Nb_of_Winners;

end Bingo.Board;