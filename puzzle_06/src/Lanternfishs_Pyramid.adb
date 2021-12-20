with Ada.Text_IO;
use Ada.Text_IO;

package body Lanternfishs_Pyramid is

    Fish_Population       : Pyramid_of_Age := (others => 0);
    Next_Generation_Count : Population     := 0;

    -- --------
    -- New_Fish
    -- --------
    procedure New_Fish (Timer : Life_Timer) is
    begin
        Fish_Population (Timer) := @ + 1;
        Next_Generation_Count   := Fish_Population (Mature);
    end New_Fish;

    -- --------
    -- Next_Day
    -- --------
    function Next_Day return Population is
        Count, New_Young, New_Generation : Population;
    begin

        -- General population aging
        for T in Life_Timer loop
            case T is
                when Mature => -- 0
                    New_Young      := Fish_Population (Mature);
                    New_Generation := Fish_Population (Mature);
                when others =>
                    Fish_Population (T - 1) := Fish_Population (T);
            end case;
        end loop;

        -- New Babies and add youngsters
        Fish_Population (BabyFish) := Next_Generation_Count;
        Fish_Population (Young)    := @ + New_Young;

        Next_Generation_Count := Fish_Population (Mature);

        -- Count population before babies are born
        Count := 0;
        for T in Life_Timer loop
            Count := @ + Fish_Population (T);
        end loop;
        return Count;

    end Next_Day;

end Lanternfishs_Pyramid;
