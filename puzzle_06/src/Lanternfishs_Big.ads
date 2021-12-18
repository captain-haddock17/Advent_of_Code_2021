with Lanternfishs;
use Lanternfishs;

with System.Storage_Pools ;
use System.Storage_Pools ;
with System.Storage_Elements;
use System.Storage_Elements;

--Ada.Unchecked_Deallocation;

package Lanternfishs_Big is

    -- -----------------------------------------
    -- Definition of some dimensional contraints
    -- -----------------------------------------

    -- Specific Frame algorithm
    -- ------------------------
    Initial_Population     : constant Positive := 5;
    Nb_Days_of_Generations : constant Positive := 256;

    -- type Population_Frame_type is mod Initial_Population;
    subtype Population_Frame_type is
       Positive range
          1 .. 4_000_000;
             -- 1_800_000; --Nb_Days_of_Generations*10 * SubLife_Timer'Last * Integer(Life_Timer'Last - Life_Timer'First +1 ); -- = 300 * 6 * 9

    subtype Days_of_Generations_range is Natural range 0 .. Nb_Days_of_Generations; --18

    type Generations_array is
       array (Days_of_Generations_range, Population_Frame_type)
       of Lanternfish;

    type Generations_array_Ptr is access Generations_array;
    for Generations_array_Ptr'Storage_Size use 2**43;
   
    -- for Generations_array'Component_Size use 8;
    -- pragma Pack (Generations_array);

    subtype myPool is Root_Storage_Pool;
    -- Pool_Object : myPool;
    Pool_Address : System.Address;
    Pool_Size : System.Storage_Elements.Storage_Count := 2**40;
    Pool_Alignement : System.Storage_Elements.Storage_Count := 64;

    -- with Storage_Pool => Pool_Object;

    -- function allocate ( 
    --     Pool => myPool, 
    --     Storage_Address => Pool_Address, 
    --     Size_In_Storage_Elements => Pool_Size,
    --     Alignment => Pool_Alignement);

    -- function deallocate ( 
    --     Pool => myPool, 
    --     Storage_Address => Pool_Address, 
    --     Size_In_Storage_Elements => Pool_Size,
    --     Alignment => Pool_Alignement);



    -- for Generations_array_Ptr'Storage_Size use 2**40;
    -- ====================================
    -- Pool_Object : Some_Storage_Pool_Type;
    -- type T is access Designated;
    -- for T'Storage_Pool use Pool_Object;
    -- for T2'Storage_Pool use T'Storage_Pool;

    -- ====================================

    -- procedure Free is new Ada.Unchecked_Deallocation(Object => Generations_array, Name =>  Generations_array_Ptr);

    -- -----------------------------------------
    -- Definition of some dimensional contraints
    -- -----------------------------------------

    procedure New_Fish_In_Big_School
       (Big_School : Generations_array_Ptr;
        Timer      : Life_Timer);
    procedure Populate_Frame
       (Frame        : Generations_array_Ptr;
        Nb_of_Babies : Population_Frame_type;
        First_Day    : Days_of_Generations_range);

    function Next_Big_Generation
       (Actual_Frame, New_Frame : Generations_array_Ptr)
        return Population;

    function get_Nb_Fishs_in_School return Population;

end Lanternfishs_Big;
