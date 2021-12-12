separate (Bingo)

procedure Charge_Sets
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
end Charge_Sets;
