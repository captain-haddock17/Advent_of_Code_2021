separate (Bingo)

-- --------------------
-- put a Set to Text_IO
-- --------------------

procedure put (S : Set_of_Numbers.Set) is
    use Set_of_Numbers;
    i : Cursor;

    package B_String is new Ada.Strings.Bounded.Generic_Bounded_Length (100 * 4);
    use B_String;
    Output : Bounded_String;

begin
    i := First (S);
    Set_Bounded_String (Output, "(");
    while Has_Element (i) loop
        Output := Output & Element (i)'Image;
        Next (i);
    end loop;
    Append (Output, ')');
    Put (To_String (Output));
end put;
