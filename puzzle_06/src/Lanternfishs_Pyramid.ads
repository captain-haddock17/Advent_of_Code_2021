with Lanternfishs;
use Lanternfishs;

package Lanternfishs_Pyramid is

    type Pyramid_of_Age is
       array (Life_Timer)
       of Population;

    procedure New_Fish (Timer : Life_Timer);

    function Next_Day return Population;

end Lanternfishs_Pyramid;
