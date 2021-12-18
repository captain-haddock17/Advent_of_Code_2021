with Lanternfishs;
use Lanternfishs;

package Lanternfish_School is

    -- -----------------------------------------
    -- Definition of some dimensional contraints
    -- -----------------------------------------

    -- Specific dynamic Fish allocation algorithm
    -- ------------------------------------------
    type Lanternfish_chain;
    type Lanternfish_Ptr is access all Lanternfish_chain;
    for Lanternfish_Ptr'Storage_Size use 2**40;
    type Lanternfish_chain is record
        Fish    : Lanternfish;
        Sibling : Lanternfish_Ptr := null;
    end record;

    -- -----------------------------------------
    -- Definition of some dimensional contraints
    -- -----------------------------------------

    procedure New_Fish (Timer : Life_Timer);

    -- function Aging (Timer : Life_Timer) return Life_Timer;

    function Next_Day return Population;

    function get_Nb_Fishs_in_School return Population;

    function Count_Fishs_in_School return Population;

end Lanternfish_School;
