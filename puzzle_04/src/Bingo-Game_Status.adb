separate (Bingo)

protected body Game_Status is

    function is_Game_Over return Boolean is
    begin
        if Status = OVER then
            return True;
        else
            return False;
        end if;
    end is_Game_Over;

    function Game_FIRST return Boolean is
    begin
        if Stop = FIRST_WINNER then
            return True;
        else
            return False;
        end if;
    end Game_FIRST;

    function Game_LAST return Boolean is
    begin
        if Stop = LAST_WINNER then
            return True;
        else
            return False;
        end if;
    end Game_LAST;

    procedure set_Game_FIRST_Winner is
    begin
        Stop := FIRST_WINNER;
    end set_Game_FIRST_Winner;

    procedure set_Game_LAST_Winner is
    begin
        Stop := LAST_WINNER;
    end set_Game_LAST_Winner;

    procedure Game_is_Over is
    begin
        Status := OVER;
    end Game_is_Over;

    function Has_No_Winner return Boolean is
    begin
        if Status = NO_WINNER then
            return True;
        else
            return False;
        end if;
    end Has_No_Winner;

end Game_Status;
