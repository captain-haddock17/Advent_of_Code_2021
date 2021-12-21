package body Root_Finding.Discrete.Bisection is

    function Minimum return X is
        Min            : X := X'First;
        Previous, Next : Y;
    begin
        Previous := Regression (X'First);

        for i in X'First .. X'Pred (X'Last) loop
            Min  := i;
            Next := Regression (X'Succ (i));
            exit when Previous < Next;
        end loop;
        return Min;
    end Minimum;

end Root_Finding.Discrete.Bisection;
