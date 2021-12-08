package Submarine.Binary_Diagnostic is

    -- Define max binary length of diagnostic channels
    Nb_of_Binary_diagnostic_Channels : constant Positive := 12;
    Max_Data_Buffer                  : constant          := 1_100;

    subtype Channel_ID is Positive range 1 .. Nb_of_Binary_diagnostic_Channels;

    -- Define Diagnostics info
    type Binary_diagnostic is mod 2**Channel_ID'Last;
    for Binary_diagnostic'Size use Channel_ID'Last;

    type Failure_Rate is record
        Gamma   : Binary_diagnostic := 0;
        Epsilon : Binary_diagnostic := 0;
    end record;

    subtype Rating is Integer;

    procedure store_Diagnostic (Binary_Puzzle : in Binary_diagnostic);

    procedure compute_Diagnostics;

    procedure compute_Report (Report : in out Failure_Rate);

    procedure report_Life_support_rating (Life_support : in out Rating);

end Submarine.Binary_Diagnostic;
