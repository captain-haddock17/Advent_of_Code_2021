with Bingo;
use Bingo;

with Bingo.Called_Numbers_IO;
use Bingo.Called_Numbers_IO;

with Bingo.Boards_IO;
use Bingo.Boards_IO;

with Ada.Strings;
use Ada.Strings;

with Ada.Strings.Maps;
with Ada.Strings.Bounded;

use Ada.Strings.Maps;
use Ada.Strings.Bounded;

with Ada.Text_IO;
use Ada.Text_IO;
use Ada;

-- with Ada.Text_IO.Bounded_IO;

package body Bingo.Data_IO is

    procedure Analyze_String_Received (Some_Data : Bingo_Data_String.Bounded_String) is
        Position_F : Positive;
        Position_L : Natural;

        use Bingo_Data_String;

    begin
        if Bingo_Data_String.Length (Some_Data) = 0 then
            Do_we_create_a_New_Board := True;
        else
            Find_Token
               (Source => Some_Data,
                Set    => To_Set (','),
                Test   => Inside,
                First  => Position_F,
                Last   => Position_L);
            if Position_L > 0 then
                -- Bingo_Data_Stream.Put (Some_Data);
                -- New_Line;
                store_Called_Numbers (Data => Some_Data);

            end if;

            Find_Token
               (Source => Some_Data,
                Set    => To_Set (' '),
                Test   => Inside,
                First  => Position_F,
                Last   => Position_L);
            if Position_L > 0 then
                store_Row (Data => Some_Data);
            end if;

        end if;
    end Analyze_String_Received;

end Bingo.Data_IO;
