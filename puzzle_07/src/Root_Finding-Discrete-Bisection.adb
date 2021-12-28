package body Root_Finding.Discrete.Bisection is

    function Minimum
       (Data : F)
        return X
    is
        Min            : X := Data'First;
        Mid            : X := X((Data'Last - Data'First)/2);
        Previous, Next : Y;
    begin
        Previous := Regression (Data, Data'First);

        while  Previous < Next loop
                    Mid            : X := X((Data'Last - Data'First)/2);

            Next := Regression (Data, X'Succ (i));
            Min  := i;

            Previous := Next;
        end loop;

        while    Next <= Previous loop
            Mid            : X := X((Data'Last - Data'First)/2);

            Next := Regression (Data, X'Succ (i));
            Min  := i;

            Previous := Next;
        end loop;

        return Min;

    end Minimum;


end Root_Finding.Discrete.Bisection;
