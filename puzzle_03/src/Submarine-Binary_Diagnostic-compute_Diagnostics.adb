separate (Submarine.Binary_Diagnostic)

procedure compute_Diagnostics is
begin
    for i in 1 .. Nb_Data loop
        for c in Channel_ID loop
            if (Submarine_Health (i).Diagnostic and 2**(c - 1)) = 0 then
                Epsilon_Count (c) := @ + 1;
            else
                Gamma_Count (c) := @ + 1;
            end if;
        end loop;
    end loop;
end compute_Diagnostics;
