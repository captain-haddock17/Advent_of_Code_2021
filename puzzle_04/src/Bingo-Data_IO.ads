with Bingo;
use Bingo;

with Ada.Strings.Bounded;
with Ada.Text_IO.Bounded_IO;

with Ada.Numerics.Generic_Elementary_Functions;

package Bingo.Data_IO is

    -- --------------------------
    -- Compute `Max_String_length` of a series of Called Numbers based on value of `Max_NumberOutputs_in_Play`
    -- --------------------------
    package Math is new Ada.Numerics.Generic_Elementary_Functions (Float);
    use Math;

    Nb_of_digits : constant Positive := Positive (Float'Ceiling (1.0 + Log (Float (Max_NumberOutputs_in_Play), 10.0)));

    Max_String_length : constant Positive := 2 + 100 * 3; -- := 2 + Max_NumberOutputs_in_Play * Nb_of_digits;

    is_First_Row : Boolean;
    
    -- -----------------------------
    -- Define Bounded_Strings and IO
    -- -----------------------------
    package Bingo_Data_String is new Ada.Strings.Bounded.Generic_Bounded_Length (Max_String_length);

    package Bingo_Data_Stream is new Ada.Text_IO.Bounded_IO (Bingo_Data_String);

--    package Called_Number_IO is new Ada.Text_IO.Bounded_IO (Bingo_Data_String);

    package Called_Number_IO is new Ada.Text_IO.Integer_IO (Called_Number);

    -- -----------------------------
    -- Analyse incoming Data from file and store `Called_Number` or Board's `Row`
    -- -----------------------------
    procedure Analyze_String_Received (Some_Data : Bingo_Data_String.Bounded_String);

end Bingo.Data_IO;
