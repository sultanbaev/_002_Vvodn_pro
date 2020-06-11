uses wingraph, wincrt;
var x, y, z, gd, gm : integer;



begin
 gd:= detect;
 initgraph (gd, gm, '');
 randomize;
  setcolor (yellow);
  line (getmaxx div 2, 0, getmaxx div 2, getmaxy);

  x:= random (getmaxx);
  y:= random (getmaxy);
  z:= 100;
  circle (x, y, z);

  if x < getmaxx div 2 - z
  then outtextxy (10, 10, '‹…‚') else
  if x > getmaxx div 2 + z then
  outtextxy (10, 10, '€‚') else
  outtextxy (10, 10, 'ƒ€ˆ–€');

 readkey;
 closegraph;
end.
