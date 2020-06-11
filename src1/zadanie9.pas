uses wingraph, wincrt;
var x, y, z, gd, gm : integer;

begin
 gd:= detect;
 initgraph (gd, gm, '');
 randomize;

 repeat
 x := random (getmaxx);
 y := random (getmaxy);
 putpixel (x, y, red);


 until keypressed;












 readkey;
 closegraph;
end.
