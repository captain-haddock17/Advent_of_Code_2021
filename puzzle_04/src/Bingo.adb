with Ada.Text_IO;
use Ada.Text_IO;

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
        Actual_Numbers_in_Play                          := @ + 1;
        List_of_Called_Numbers (Actual_Numbers_in_Play) := Number;
    end add_Called_Number;

    function get_Actual_Numbers_in_Play return Natural is
    begin
        return Actual_Numbers_in_Play;
    end get_Actual_Numbers_in_Play;

    -- ------
    -- Boards
    -- ------
    Actual_Boards_in_Play : Natural range 0 .. Max_Boards_in_Play := 0;

    Current_Row : Positive := Board_V_Index'First;

    Boards_in_game : Set_of_Boards;

    procedure create_New_Board is
        MAX_BOARDS_PER_GAME_REACHED : exception;
    begin
        if not (Actual_Boards_in_Play + 1 > Max_Boards_in_Play) then
            Actual_Boards_in_Play := @ + 1;
            Do_we_create_a_New_Board := False; -- Done

        else
            raise MAX_BOARDS_PER_GAME_REACHED;
        end if;

        Current_Row := Board_V_Index'First;
        Put_Line ("New board [" & Actual_Boards_in_Play'Image & "] created.");

    exception
        when MAX_BOARDS_PER_GAME_REACHED =>
            New_Line;
            Put_Line ("No more Boards left in Game !!");
            raise;
    end create_New_Board;

    -- procedure add_in_Row ( New_Called_Number : Called_Number) is
    -- begin
    --     for i in Index_in_Row loop
    --         Boards_in_game (Actual_Boards_in_Play)(Current_Row, i) := This_Row(i);
    --     end loop;
    --     Current_Row := @ +1;
    -- end add_in_Row;

    procedure store_Row (This_Row : Row_array) is
        MAX_OF_ROWS_PER_BOARD_REACHED : exception;
    begin
        if Current_Row <= Board_V_Index'Last then

            for i in Index_in_Row loop
                Boards_in_game (Actual_Boards_in_Play) (Current_Row, i) := This_Row (i);
            end loop;
            Put_Line (Latin_1.HT & "New row #" & Current_Row'Image & " stored in Board [" & Actual_Boards_in_Play'Image & "].");
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

    -- 
    function First_Winning_Board return Board_ID is
    begin
        for in Board_Dimension .. Actual_Numbers_in_Play loop
        
                List_of_Called_Numbers (Actual_Numbers_in_Play) := Number;
        end loop;
    end First_Winning_Board;

end Bingo;
