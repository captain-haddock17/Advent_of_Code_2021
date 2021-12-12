with Ada.Text_IO;
use Ada.Text_IO;

package body Submarine.Binary_Diagnostic is

    type Count_Channels is
       array (Channel_ID'Range)
       of Natural;

    type Data_Record is record
        Diagnostic : Binary_diagnostic := 0;
        Filtered   : Boolean           := False;
    end record;

    subtype Data_Index_zero is Natural range 0 .. Max_Data_Buffer;
    subtype Data_Index is Data_Index_zero range 1 .. Max_Data_Buffer;

    type Submarine_Health_array is
       array (Data_Index)
       of Data_Record;


    Submarine_Health : Submarine_Health_array := (others => (Diagnostic => 0, Filtered => False));
    Nb_Data          : Data_Index_zero        := 0;

    Gamma_Count, Epsilon_Count : Count_Channels := (others => 0);


    procedure Store_Diagnostic (Binary_Puzzle : in Binary_diagnostic) is
    begin
        Nb_Data                               := @ + 1;
        Submarine_Health (Nb_Data).Diagnostic := Binary_Puzzle;
    end Store_Diagnostic;

    procedure compute_Diagnostics is separate;


    procedure compute_Report (Report : in out Failure_Rate) is separate;

    function compute_Life_support_rating
       (Element : Air_Element)
        return Binary_diagnostic is separate;

    procedure report_Life_support_rating (Life_support : in out Rating; Air : in out Air_Mix_Ratings) is separate;

end Submarine.Binary_Diagnostic;
