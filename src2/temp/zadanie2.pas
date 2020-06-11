uses wingraph, wincrt;
var x, y, gd, gm : integer;



begin
 gd:= detect;
 initgraph (gd, gm, '');
 randomize;
  setcolor (yellow);
  line (getmaxx div 2, 0, getmaxx div 2, getmaxy);

  x:= random (getmaxx);
  y:= random (getmaxy);
  circle (x, y, 20);

  if x < getmaxx div 2 then outtextxy (10, 10, '‹…‚Ž') else
  outtextxy (10, 10, '€‚Ž');

 readkey;
 closegraph;
end.
