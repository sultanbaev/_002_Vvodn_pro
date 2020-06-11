uses wingraph, wincrt;
var  gd, gm, x, y, dx, dy, p, i, n   : integer;
     xg, yg, dxg, dyg                : array [1..10] of integer;
     pic                             : pointer;
     ch                              : char;

function loader (filename : string) : pointer;
var sz                              : longint;
    p                               : pointer;
    f                               : file;

begin
 assign (f, filename);
 reset (f, 1);
 sz := filesize (f);
 getmem (p, sz);
 blockread (f, p^, sz);
 close (f);
 loader := p;
end;

//------------------------------------------------------------------

procedure neupr (var x, y, dx, dy : integer; pic : pointer);

begin
  putimage (x, y, pic^, xorput);
  x := x + dx;
  y := y + dy;

  if (x>(getmaxx-100)) then dx := -dx; // границы
  if (x<1) then dx := -dx;

  if (y>(getmaxy-100)) then dy := -dy;
  if (y<1) then dy := -dy;
  putimage (x, y, pic^, xorput);
end;

//--------------------------------------------------------------------

begin
 gd := detect;                       // подгрузка изображения
 initgraph (gd, gm, '');
 pic := loader ('character.bmp');
// pic2 := loader ('character2.bmp');

 x := 50; y := 50; dx := 10; dy := 10;
// x2 := 100; y2 := 100; dx2 := 20; dy2 := 20;
 putimage (x, y, pic^, xorput);
// putimage (x2, y2, pic2^, xorput);


 repeat
   neupr (x, y, dx, dy, pic);
  // neupr(x, y, dx2, dy2, pic); // повт проц неупр
   //if keypressed then Upr;
   delay (50);
 until ch = #27;

keypressed;
closegraph;
end.
