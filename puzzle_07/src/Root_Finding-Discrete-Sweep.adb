with Ada.Text_IO;
package body Root_Finding.Discrete.Sweep is

    function Minimum
       (Data : F)
        return X
    is
        Min            : X := Data'First;
        Previous, Next : Y;
    begin
        Previous := Regression (Data, Data'First);

        for i in Data'First .. X'Pred (Data'Last) loop
            Next := Regression (Data, X'Succ (i));
            Min  := i;
            exit when Previous <= Next;

            Previous := Next;
        end loop;

        return Min;

    end Minimum;

end Root_Finding.Discrete.Sweep;
