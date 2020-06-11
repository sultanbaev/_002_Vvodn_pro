    uses wingraph,wincrt;
    var gd,gm,x,y,c,x1,y1,x2,y2:integer;
    begin

    randomize;
    gd:= detect;
    initgraph (gd,gm, '');

    repeat

    x:=random(50)+(getmaxx-50);
    x1:=random(50);
    y:=random(getmaxy);

    x2:=random(getmaxx);
    y1:=random(50)+(getmaxy-50);
    y2:=random(50);


    c:=random(3);

   if c=2 then begin
   putpixel (x,y, red);   putpixel (x1,y, red);    end else

   if c=1 then begin
   putpixel (x,y, white);   putpixel (x1,y, white);  end else

   if c=0 then begin
   putpixel (x,y, yellow);  putpixel (x1,y, yellow);  end;
   until  keypressed;

    c:=random(3);

   if c=2 then begin
   putpixel (x,y, red);   putpixel (x1,y, red);    end else

   if c=1 then begin
   putpixel (x,y, white);   putpixel (x1,y, white);  end else

   if c=0 then begin
   putpixel (x,y, yellow);  putpixel (x1,y, yellow);  end;

   until  keypressed;






    readkey;
    closegraph;

 end.
