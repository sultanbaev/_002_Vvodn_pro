   //-------------------------------------------------- pri propuske shara snizu
   putimage (platfbx, platfby, platfb^, xorput);

   life := 3003;

   if (shary>(getmaxy-10)) then
    begin
      life := life - 1001;
    end;
    
   putimage (platfbx, platfby, platfb^, xorput);