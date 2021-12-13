with Bingo;
use Bingo;

package Bingo.Jury is

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

    type Jury_Actor_ptr is access all Jury_Actor;

end Bingo.Jury;
