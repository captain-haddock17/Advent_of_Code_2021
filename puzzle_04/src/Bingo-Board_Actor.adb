separate (Bingo)

task body Board_Actor is

    Array_of_Sets         : Board_Set_Array;
    is_Winner             : Boolean := False;
    Last_Winner_Set_index : VH_range;
    Sum_of_unchecked      : Natural := 0;

    use Set_of_Numbers;

    Called_Numbers, Numbers_in_Board : Set_of_Numbers.Set (Count_Type (Max_NumberOutputs_in_Play));

    Indent : String := ID * "  ";

begin
    -- New_Line;
    -- Put_Line (Indent & "Board" & ID'Image & " created");

    -- Load from Board array
    Charge_Sets (Boards_in_game (ID), Array_of_Sets);

    Put ('[' & ID'Image & ']');
-- Put_Line (Indent & "Board [" & ID'Image & "] is ready");

    -- Waiting for a Called_Number
    loop
        select 
         when not Game_Status.is_Game_Over =>
            accept Verify (New_Set : Set_of_Numbers.Set) do
                Called_Numbers := New_Set;
            end Verify; -- return to the caller

                for i in VH_range loop
                    -- put (Array_of_Sets (i));
                    -- New_Line;
                    if not Array_of_Sets (i).Won then

                        is_Winner := Is_Subset
                              (Subset => Array_of_Sets (i).Set,
                               Of_Set => Called_Numbers);
                        if is_Winner then
                            Array_of_Sets (i).Won := True;
                            Last_Winner_Set_index := i;
                            -- Put_Line (Indent & "THERE IS A WINNER on board [" & ID'Image & "] index (" & i'Image & ")");
                            Jury.Winning_Board (ID, Called_Numbers);
                            -- if Game_Status.is_Game_Over then -- or Protected_Board.is_Last_Winner then
                            -- if Game_Status.is_Game_Over or Protected_Board.is_Last_Winner then
                                -- exit;
                            --  end if;
                        end if;
                    end if;
                end loop;
        or -- when Game_Status.is_Game_Over =>
            accept Done do
                null; -- synchro
            end Done;
        or -- when Game_Status.is_Game_Over =>
            accept Compute_Unchecked_Numbers
               (Sum                            : out Natural;
                Last_Winning_Called_Number_Set :     Set_of_Numbers.Set) do

                -- Agregate all numbers in this board
                -- Put_line ("Agregate all numbers in this board");
                Clear (Numbers_in_Board);
                for i in H_Index loop
                    Union
                       (Target => Numbers_in_Board,
                        Source => Array_of_Sets (i).Set);
                end loop;

                Difference
                   (Target => Numbers_in_Board,
                    Source => Last_Winning_Called_Number_Set);
                -- put (Numbers_in_Board);
                -- New_Line;

                -- compute sum
                -- Put_Line ("compute sum");
                declare
                    i : Cursor;
                begin
                    Sum_of_unchecked := 0;
                    i                := First (Numbers_in_Board);
                    while Has_Element (i) loop
                        Sum_of_unchecked := @ + Element (i);
                        Next (i);
                    end loop;
                    Sum := Sum_of_unchecked;
                end;
            end Compute_Unchecked_Numbers; -- return to the caller
        or
            -- when Game_Status.is_Game_Over =>
            accept Stop do
                null;
            end Stop;
            exit;
        end select;
    end loop;
    -- Put_Line (Indent & "End of Board [" & ID'Image & "].");
end Board_Actor;
