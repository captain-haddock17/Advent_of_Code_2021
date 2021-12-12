separate (Submarine.Binary_Diagnostic)

procedure report_Life_support_rating (Life_support : in out Rating; Air : in out Air_Mix_Ratings) is
begin
    Air.Oxygen := Rating(compute_Life_support_rating (OXYGEN));

    Air.CO2 := Rating(compute_Life_support_rating (CO2));

    Life_support := Rating (Air.Oxygen) * Rating (Air.CO2);

end report_Life_support_rating;
