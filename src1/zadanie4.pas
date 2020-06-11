uses wingraph, wincrt;
var x, y, z, gd, gm : integer;

begin
 gd:= detect;
 initgraph (gd, gm, '');
 randomize;

  setcolor (yellow);
  rectangle (200, 500, 700, 200);

  x:= random (getmaxx);
  y:= random (getmaxy);
  z:= 100;
  circle (x, y, z);

  if then
  outtextxy (10, 10, 'ŒˆŒ') else

  if (x > 200-z) and (x < 700+z) and (y > 200-z) and (y < 500+z) then
  outtextxy (10, 10, '€‹') else
  outtextxy (10, 10, 'ƒ€ˆ–€');



 readkey;
 closegraph;
end.
