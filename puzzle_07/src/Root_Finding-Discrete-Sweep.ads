package Root_Finding.Discrete.Sweep is

    generic
        type X is (<>);
        type Y is (<>);
        type F is
           array (X)
           of Y;

        type Mode_enum is (<>);

        with function Regression
           (Mode     : Mode_enum;
            Data     : F;
            Position : X)
            return Y;

    function Minimum
       (Mode : Mode_enum;
        Data : F)
        return X;

end Root_Finding.Discrete.Sweep;
