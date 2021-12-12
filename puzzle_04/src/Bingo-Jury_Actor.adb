separate (Bingo)

task body Jury_Actor is
    Winner_ID                   : Board_ID := 100; --FIXME
    Last_Winning_Called_Numbers : Set_of_Numbers.Set (Count_Type (Max_NumberOutputs_in_Play));

    -- Winner : Boolean := False;
    NO_WINNER : exception;

begin
    Put_Line ("Installing the Jury ...");
    loop
        select 
         when not Game_Status.is_Game_Over =>
            -- waiting for a winner ...
            accept Winning_Board
               (ID                             : Board_ID;
                Last_Winning_Called_Number_Set : Set_of_Numbers.Set) do
                Winner_ID                   := ID;
                Last_Winning_Called_Numbers := Last_Winning_Called_Number_Set;
            end Winning_Board;
                -- Put_Line ("Jury received a winning Board [" & Winner_ID'Image & "] !!");
                --
                Protected_Board.Flag_Winner (Winner_ID);
                -- Winner    := True;

                -- Determine the continuation of the game
                if Game_Status.Game_FIRST then
                    Game_Status.Game_is_Over;
                    New_Line;
                    -- Put_Line (".... Game_is_Over .... [" & Winner_ID'Image & "] FIRST WINNER");
                end if;
                if Protected_Board.is_Last_Winner then
                    Game_Status.Game_is_Over;
                    New_Line;
                    -- Put_Line (".... Game_is_Over .... [" & Winner_ID'Image & "] LAST WINNER");
                end if;

        or 
        -- when Game_Status.is_Game_Over =>
            accept get_Winner_ID
               (ID                             :    out Board_ID;
                Last_Winning_Called_Number_Set : in out Set_of_Numbers.Set) do
                ID                             := Winner_ID;
                Last_Winning_Called_Number_Set := Last_Winning_Called_Numbers;
                Put_Line ("Jury got winner [" & Winner_ID'Image & ']');
            end get_Winner_ID;
            -- if Game_Status.Game_FIRST or Protected_Board.is_Last_Winner then
            exit;
            -- end if;

        or 
         when not Game_Status.is_Game_Over =>
            accept get_Winner_ID
               (ID                             :    out Board_ID;
                Last_Winning_Called_Number_Set : in out Set_of_Numbers.Set) do
                ID := 1; -- not significant value (as null value)
                null;
            end get_Winner_ID;
            Put_Line ("no winner ...");
            exit;
-- else
--  null;
        end select;
    end loop;
    Put_Line ("End of game.");
end Jury_Actor;
