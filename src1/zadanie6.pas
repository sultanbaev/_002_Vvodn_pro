uses wingraph, wincrt;
var x, i, c, gd, gm : integer;

begin
 gd:= detect;
 initgraph (gd, gm, '');



  x := 35;
  c := 0;

  repeat
   c := c + 1;
   setcolor (white);

    if c = 1 then
    setfillstyle (1, white);

    if c = 2 then
    setfillstyle (1, blue);

    if c = 3 then
    setfillstyle (1, red);

   circle (x, 50, 20);
   floodfill (x, 50, white);
   x := x + 40;
   if c = 3 then c := 0;
   delay(100);
  until (x > getmaxx);






 readkey;
 closegraph;
end.
