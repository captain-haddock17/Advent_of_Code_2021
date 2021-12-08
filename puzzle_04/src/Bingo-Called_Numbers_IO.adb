with Bingo;
use Bingo;

with Bingo.Data_IO;
use Bingo.Data_IO;

with Ada.Text_IO;
use Ada;

package body Bingo.Called_Numbers_IO is

    use Bingo_Data_String;
    use Called_Number_IO;

    procedure store_Called_Numbers (Data : in Bingo_Data_String.Bounded_String) is

        Number        : Called_Number;
        end_of_Number : Positive;
        this_Data     : Bingo_Data_String.Bounded_String;
    begin
        this_Data := Data;

        loop
            Called_Number_IO.Get
               (From => To_String (this_Data),
                Item => Number,
                Last => end_of_Number);
            add_Called_Number (Number);

            exit when Length (this_Data) <= 1;

            Bounded_Slice
               (Source => this_Data,
                Target => this_Data,
                Low    => end_of_Number + 2,
                High   => Length (this_Data));
        end loop;

    end store_Called_Numbers;

end Bingo.Called_Numbers_IO;
