separate (Submarine.Binary_Diagnostic)

procedure Compute_Report (Report : in out Failure_Rate) is
begin
    for c in Channel_ID loop
        if Gamma_Count (c) >= Epsilon_Count (c) then
            Report.Gamma := @ + 2**(c - 1);
        else
            Report.Epsilon := @ + 2**(c - 1);
        end if;
    end loop;
end Compute_Report;
