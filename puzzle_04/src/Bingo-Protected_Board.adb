separate (Bingo)

protected body Protected_Board is

    procedure store_Number
       (ID : Board_ID;
        V  : V_Index;
        H  : H_Index;
        N  : Called_Number)
    is
    begin
        Protected_Boards (ID).Cell (V, H) := N;
    end store_Number;

    function get_Number
       (ID : Board_ID;
        V  : V_Index;
        H  : H_Index)
        return Called_Number
    is
    begin
        return Protected_Boards (ID).Cell (V, H);
    end get_Number;

    procedure Flag_Winner (ID : Board_ID) is
    begin
        case Protected_Boards (ID).Won is
            when False =>
                Protected_Boards (ID).Won := True;
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
            if Protected_Boards (i).Won then
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

end Protected_Board;
