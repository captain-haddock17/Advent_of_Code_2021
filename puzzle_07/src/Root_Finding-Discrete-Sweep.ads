package Root_Finding.Discrete.Sweep is

    generic
        type X is (<>);
        type Y is (<>);
        type F is
           array (X)
           of Y;
        with function Regression
           (Data     : F;
            Position : X)
            return Y;

    function Minimum
       (Data : F)
        return X;

end Root_Finding.Discrete.Sweep;
