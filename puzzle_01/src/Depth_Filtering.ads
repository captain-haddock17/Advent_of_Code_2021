with Ada.Strings.Bounded;
with Ada.Text_IO.Bounded_IO;

package Depth_Filtering is

    -- Definition of the Sonar system
    Number_of_Measurement_Filters  : constant Positive := 3;
    Number_of_Measurement_Channels : constant Positive := Number_of_Measurement_Filters + 1;


    -- for geting the results
    package Message_Strings is new Ada.Strings.Bounded.Generic_Bounded_Length (1_024);
    package Message_IO is new Ada.Text_IO.Bounded_IO (Message_Strings);

    procedure compute_Depth_Filter (Pulse : Natural; Depth : Natural; Message_from_filter : in out Message_Strings.Bounded_String);

    function get_DepthCount_Increasing return Natural;

end Depth_Filtering;
