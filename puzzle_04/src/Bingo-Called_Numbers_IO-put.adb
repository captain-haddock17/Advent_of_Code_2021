separate (Bingo.Called_Numbers_IO)

-- --------------------
-- put a Set to Text_IO
-- --------------------

procedure put (S : Set_of_Numbers.Set) is

    use Set_of_Numbers;

    i : Cursor;

    Output : Bounded_String;

begin
    i := First (S);
    Set_Bounded_String (Output, "{");
    while Has_Element (i) loop
        Output := Output & Element (i)'Image;
        Next (i);
    end loop;
    Append (Output, '}');
    Ada.Text_IO.Put (To_String (Output));
end put;
