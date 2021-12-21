package Root_Finding.Discrete.Bisection is

    generic
        type X is (<>);
        type Y is (<>);
        type F is
           array (X)
           of Y;
        with function Regression
           (input : X)
            return Y;

    function Minimum return X;

end Root_Finding.Discrete.Bisection;
