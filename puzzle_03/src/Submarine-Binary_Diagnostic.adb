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

    type Air_Element is
       (CO2,
        OXYGEN);
    for Air_Element use (0, 1);

    type Air_Mix is record
        Oxygen : Rating;
        CO2    : Rating;
    end record;

    package xx is new Modular_IO (Binary_diagnostic);

    Submarine_Health : Submarine_Health_array := (others => (Diagnostic => 0, Filtered => False));
    Nb_Data          : Data_Index_zero        := 0;

    Gamma_Count, Epsilon_Count : Count_Channels := (others => 0);

    Air_Rating : Air_Mix := (Oxygen => 0, CO2 => 0);

    Oxygen_generator_rating : Binary_diagnostic;
    CO2_scrubber_rating     : Binary_diagnostic;

    procedure Store_Diagnostic (Binary_Puzzle : in Binary_diagnostic) is
    begin
        Nb_Data                               := @ + 1;
        Submarine_Health (Nb_Data).Diagnostic := Binary_Puzzle;
    end Store_Diagnostic;

    procedure compute_Diagnostics is
    begin
        for i in 1 .. Nb_Data loop
            for c in Channel_ID'Range loop
                if (Submarine_Health (i).Diagnostic and 2**(c - 1)) = 0 then
                    Epsilon_Count (c) := @ + 1;
                else
                    Gamma_Count (c) := @ + 1;
                end if;
            end loop;
        end loop;
    end compute_Diagnostics;

    procedure compute_Report (Report : in out Failure_Rate) is
    begin
        for c in Channel_ID'Range loop
            if Gamma_Count (c) >= Epsilon_Count (c) then
                Report.Gamma := @ + 2**(c - 1);
            else
                Report.Epsilon := @ + 2**(c - 1);
            end if;
        end loop;
--        Report.Epsilon := Report.Gamma xor Binary_diagnostic'Last;
    end compute_Report;



    function compute_Life_support_rating
       (Element : Air_Element)
        return Binary_diagnostic
    is
        Count_0, Count_1   : Natural           := 0;
        Apply_Filter_on  : Binary_diagnostic := 0;
        Records_count      : Data_Index_zero   := 0;
        Index              : Data_Index;

    begin
        Count_0 := 0;
        Count_1 := 0;
        Apply_Filter_on   := 0;
        Records_count       := 0;

        -- initialize the filtering
        for i in 1 .. Nb_Data loop
            Submarine_Health (i).Filtered := False;
        end loop;

        -- go through the channels to find out most/least common until last unique Data
        for c in reverse Channel_ID'Range loop

            Count_0 := 0;
            Count_1 := 0;

            -- count '0' and '1'
            for i in 1 .. Nb_Data loop
                if not Submarine_Health (i).Filtered then
                    if (Submarine_Health (i).Diagnostic and 2**(c - 1)) = 0 then
                        Count_0 := @ + 1;
                    else
                        Count_1 := @ + 1;
                    end if;
                end if;
            end loop;
            Put_Line("Count_0 = "& Count_0'image);
            Put_Line("Count_1 = "& Count_1'image);

            -- Determine most/least, depending on which `Air_Element`
            if Count_1 > Count_0 then -- '1' is most common
                case Element is
                    when OXYGEN =>
                        Apply_Filter_on  := 0; -- mask Data having the '0' bit
                    when CO2 =>
                        Apply_Filter_on  := 1; -- mask Data having the '1' bit
                end case;
            elsif Count_0 > Count_1 then-- '0' is most common
                case Element is
                    when OXYGEN =>
                        Apply_Filter_on  := 1; -- mask Data having the '1' bit
                    when CO2 =>
                        Apply_Filter_on  := 0; -- mask Data having the '0' bit
                end case;
            else -- Count_1 = Count_0
                case Element is
                    when OXYGEN =>
                        Apply_Filter_on  := 0; -- mask Data having the '1' bit
                    when CO2 =>
                        Apply_Filter_on  := 1; -- mask Data having the '0' bit
                end case;
            end if;
            Put_Line("Filter_on = "& Apply_Filter_on'image);

            -- Filter out
            Records_count := 0;
            for i in 1 .. Nb_Data loop
                if not Submarine_Health (i).Filtered then
                    if (Submarine_Health (i).Diagnostic and 2**(c - 1)) = 0  then
                        if Apply_Filter_on = 0 then
                            Submarine_Health (i).Filtered := True;
                        else
                            Records_count := @ + 1;
                        end if;
                    else
                        if Apply_Filter_on = 1 then
                            Submarine_Health (i).Filtered := True;
                        else
                            Records_count := @ + 1;
                        end if;
                    end if;
                end if;
            end loop;
            Put_Line("Records_count = "& Records_count'image);

--            New_Line;
            Records_count := 0;
            for i in 1 .. Nb_Data loop
                if not Submarine_Health (i).Filtered then
                    Records_count := @ + 1;
                    Index         := i;
                    -- xx.Put
                    --    (Item  => Submarine_Health (i).Diagnostic,
                    --     Base  => 2,
                    --     Width => Nb_of_Binary_diagnostic_Channels);
                    --New_Line;
                end if;
            end loop;
            New_Line;


            exit when Records_count = 1; -- found the one-unique !!
        end loop;
        return Submarine_Health (Index).Diagnostic;
    end compute_Life_support_rating;

    procedure report_Life_support_rating (Life_support : in out Rating) is
    begin
        Put_Line ("Oxygen_generator_rating ................");
        Oxygen_generator_rating := compute_Life_support_rating (OXYGEN);
        Put_Line ("Oxygen_generator_rating" & Oxygen_generator_rating'Image);

        Put_Line ("CO2_scrubber_rating ....................");
        CO2_scrubber_rating := compute_Life_support_rating (CO2);
        Put_Line ("CO2_scrubber_rating" & CO2_scrubber_rating'Image);

        Life_support := Rating (Oxygen_generator_rating) * Rating (CO2_scrubber_rating);

    end report_Life_support_rating;

end Submarine.Binary_Diagnostic;
