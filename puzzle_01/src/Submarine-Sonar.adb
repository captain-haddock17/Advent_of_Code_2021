with Ada.Text_IO;
use Ada.Text_IO;

package body Submarine.Sonar is

    subtype Channel_index is Positive range 1 .. Number_of_Measurement_Channels;

    type Channel_Info is record
        is_Open        : Boolean := False;
        Filtered_Depth : Natural := 0;
    end record;

    type Measurement_Channel_array is
       array (Channel_index)
       of Channel_Info;

    -- for filtering Algorithms
    subtype Filter_index is Positive range 1 .. Number_of_Measurement_Filters;

    First_record : Boolean := True;

    Current_Depth, Previous_Depth : Natural := 0;
    DepthCount_Increasing         : Natural := 0;

    Measurement_Channel     : Measurement_Channel_array := (others => (is_Open => False, Filtered_Depth => 0));
    Previous_Filtered_Depth : Natural                   := 0;

    -- --------------------------------------------------------
    -- Compute a modulo from a base of '1' instead of usual '0'
    -- --------------------------------------------------------
    function modulo
       (i       : Integer;
        modulus : Positive)
        return Natural
    is
    begin
        return 1 + ((i - 1) mod modulus);
    end modulo;

    -- -----------------------------------
    -- Compute depth values and increments
    -- -----------------------------------
    procedure compute_Depth_Increments
       (Depth      :        Natural;
        Increments : in out Natural)
    is
    begin
        if Depth > Previous_Depth and not First_record then
            DepthCount_Increasing := @ + 1;
        end if;

        Previous_Depth := Depth;
        First_record   := False;

        -- Return expected info
        Increments := DepthCount_Increasing;

    end compute_Depth_Increments;

    -- -------------------------------------------------------------------------
    -- Compute filtered depth values per different channels en filtering history
    -- -------------------------------------------------------------------------
    procedure compute_Depth_Filter
       (Pulse               :        Natural;
        Depth               :        Natural;
        Message_from_filter : in out Message_Strings.Bounded_String)
    is
        Active_Channel, Previous_Channel_idx : Channel_index;
        Filter_idx                           : Channel_index;

        use Message_Strings;

    begin
        Active_Channel                               := modulo (Pulse, Channel_index'Last);
        Measurement_Channel (Active_Channel).is_Open := True;

        for Idx in Channel_index'Range loop

            if Measurement_Channel (Idx).is_Open then
                Previous_Channel_idx := modulo (Idx - 1, Channel_index'Last);
                Filter_idx           := modulo (Pulse - Idx + 1, Number_of_Measurement_Channels);

                case Filter_idx is
                    when 1 =>
                        Measurement_Channel (Idx).Filtered_Depth := Depth;

                    when 2 .. Number_of_Measurement_Filters - 1 =>
                        Measurement_Channel (Idx).Filtered_Depth := @ + Depth;

                    when Number_of_Measurement_Filters =>

                        Measurement_Channel (Idx).Filtered_Depth := @ + Depth;

                        Message_from_filter :=
                           To_Bounded_String
                              ("[" & Character'Val (Character'Pos ('A') - 1 + Idx) & "]: " &
                               Measurement_Channel (Idx).Filtered_Depth'Image);
                        if not Measurement_Channel (Previous_Channel_idx).is_Open then
                            Append (Message_from_filter, " (N/A - no previous sum)");
                        elsif Measurement_Channel (Idx).Filtered_Depth > Previous_Filtered_Depth then
                            DepthCount_Increasing := @ + 1;
                            Append (Message_from_filter, " (increased)");
                        elsif Measurement_Channel (Idx).Filtered_Depth = Previous_Filtered_Depth then
                            Append (Message_from_filter, " (no change)");
                        else
                            Append (Message_from_filter, " (decreased)");
                        end if;

                        Previous_Filtered_Depth := Measurement_Channel (Idx).Filtered_Depth;

                    when others =>
                        null;
                end case;
            end if;
        end loop;

    end compute_Depth_Filter;

    -- ------------------
    -- Get the end-result
    -- ------------------
    function get_DepthCount_Increasing return Natural is
    begin
        return DepthCount_Increasing;
    end get_DepthCount_Increasing;

end Submarine.Sonar;
