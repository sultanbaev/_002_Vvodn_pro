uses wingraph, wincrt;
var x, i, z, gd, gm : integer;

begin
 gd:= detect;
 initgraph (gd, gm, '');

  setcolor (red);

  x := 35;
  for i := 1 to 23 do

   begin
    circle (x, 50, 20);

    setfillstyle (1, red);
    floodfill (x, 50, red);

    x := x + 40;
   end;

 readkey;
 closegraph;
end.
