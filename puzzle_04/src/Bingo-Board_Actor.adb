separate (Bingo)

task body Board_Actor is

    Array_of_Sets         : Board_Set_Array;
    is_Winner             : Boolean := False;
    Last_Winner_Set_index : VH_range;
    Sum_of_unchecked      : Natural := 0;

    use Set_of_Numbers;

    Called_Numbers, Numbers_in_Board : Set_of_Numbers.Set (Count_Type (Max_NumberOutputs_in_Play));

    Indent : String := ID * "  ";

    procedure Charge_Sets2
       (This_Board :        Board;
        Some_Sets  : in out Board_Set_Array)
    is
        Set_ID : Natural range 0 .. VH_range'Last := 0;

        use Set_of_Numbers;

    begin
--        Put_Line (Indent & "Charging ..." & VH_range'Last'Image & " combinaisons...");
        Set_ID := 0;

        -- Horizontal scan
        for V in V_Index loop
            Set_ID := @ + 1;
            for H in H_Index loop
                Insert (Some_Sets (Set_ID).Set, This_Board.Cell (V, H));
                Some_Sets (Set_ID).Won := False;
            end loop;
--        put('H');put(Some_Sets (Set_ID));
--        new_line;
        end loop;
        -- Vertical scan
        for H in H_Index loop
            Set_ID := @ + 1;
            for V in V_Index loop
                Insert (Some_Sets (Set_ID).Set, This_Board.Cell (V, H));
                Some_Sets (Set_ID).Won := False;
            end loop;
--        put('V');put(Some_Sets (Set_ID));
--        new_line;
        end loop;
        -- Put(Indent);
        Put_Line ("Charging [" & ID'Image & "] Done.");
    end Charge_Sets2;

begin
    -- New_Line;
    -- Put_Line (Indent & "Board" & ID'Image & " created");

    -- Load from Board
    Charge_Sets2 (Boards_in_game (ID), Array_of_Sets);

    -- Put_Line (Indent & "Board [" & ID'Image & "] is ready");

    -- Wait for a Called_Number
    loop
        select 
         when not Game_Status.is_Game_Over =>
            accept Verify (New_Set : Set_of_Numbers.Set) do
                Called_Numbers := New_Set;
--                 Called_Numbers := Copy (New_Set);
                -- Put (Indent & "copied numbers: ");
                -- put (Called_Numbers);
                -- New_Line;

                -- Put_Line (Indent & "Board [" & ID'Image & "] is verifying");
            end Verify;

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
        -- end select;
        -- end loop;
        -- loop
        --     select
        or -- when Game_Status.is_Game_Over =>
            accept Done do
                null; -- synchro
            end Done;
        or -- when Game_Status.is_Game_Over =>
            accept Compute_Unchecked_Numbers
               (Sum                            : out Natural;
                Last_Winning_Called_Number_Set :     Set_of_Numbers.Set) do

                -- Agregate all numbers in this board
                Put_line ("Agregate all numbers in this board");
                Clear (Numbers_in_Board);
                for i in H_Index loop
                    Union
                       (Target => Numbers_in_Board,
                        Source => Array_of_Sets (i).Set);
                end loop;
                -- put ("": Index");
                -- put (Numbers_in_Board);
                -- New_Line;

                -- Select unchecked numbers
                -- Put ("Winning called numbers:");
                -- put (Last_Winning_Called_Number_Set);
                -- New_Line;
                -- Put ("Select unchecked numbers:");

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
            end Compute_Unchecked_Numbers;

        or
            -- when Game_Status.is_Game_Over =>
            accept Stop do
                null;
            end Stop;
            exit;
        -- else
        -- null;
        end select;
    end loop;
    -- Put_Line (Indent & "End of Board [" & ID'Image & "].");
end Board_Actor;
