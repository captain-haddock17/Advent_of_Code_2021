separate (Submarine.Binary_Diagnostic)

function compute_Life_support_rating
   (Element : Air_Element)
    return Binary_diagnostic
is
    Count_0, Count_1 : Natural;
    Apply_Filter_on  : Binary_diagnostic := 0;
    Records_count    : Data_Index_zero   := 0;
    Index            : Data_Index;

begin
    -- initialize the filtering for the particular `Element`
    for i in 1 .. Nb_Data loop
        Submarine_Health (i).Filtered := False;
    end loop;

    -- go through the channels to find out most/least common until last unique Data
    for c in reverse Channel_ID loop

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

        -- Determine most/least, depending on which `Air_Element`
        if Count_1 > Count_0 then -- '1' is most common
            case Element is
                when OXYGEN =>
                    Apply_Filter_on := 0; -- mask Data having the '0' bit
                when CO2 =>
                    Apply_Filter_on := 1; -- mask Data having the '1' bit
            end case;
        elsif Count_0 > Count_1 then-- '0' is most common
            case Element is
                when OXYGEN =>
                    Apply_Filter_on := 1; -- mask Data having the '1' bit
                when CO2 =>
                    Apply_Filter_on := 0; -- mask Data having the '0' bit
            end case;
        else -- Count_1 = Count_0
            case Element is
                when OXYGEN =>
                    Apply_Filter_on := 0; -- mask Data having the '1' bit
                when CO2 =>
                    Apply_Filter_on := 1; -- mask Data having the '0' bit
            end case;
        end if;

        -- Filter out
        Records_count := 0;
        for i in 1 .. Nb_Data loop
            if not Submarine_Health (i).Filtered then
                if (Submarine_Health (i).Diagnostic and 2**(c - 1)) = 0 then
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

        Records_count := 0;
        for i in 1 .. Nb_Data loop
            if not Submarine_Health (i).Filtered then
                Records_count := @ + 1;
                Index         := i;
            end if;
        end loop;

        exit when Records_count = 1; -- found the one-unique !!
    end loop;

    return Submarine_Health (Index).Diagnostic;

end compute_Life_support_rating;
