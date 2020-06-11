uses wingraph, wincrt;
var  gd, gm, x, y, dx, dy, del, x2, y2, dx2, dy2, bx, by, bdy     : integer;
     plane, planep, planel, tank, bomb               : pointer;
     ch                                              : char;

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

//------------------------------------------------------------

procedure neupr (var x, y, dx, dy : integer; var plane : pointer);
begin
  putimage (x, y, plane^, xorput);
  x := x + dx;

  if (x>(getmaxx-100)) then // границы
    begin
      plane := planel;
      dx := -dx;
    end;

  if (x<1) then
    begin
      plane := planep;
      dx := -dx;
    end;

  putimage (x, y, plane^, xorput);
end;

//------------------------------------------------------------

procedure upr;
 begin
  ch := readkey;
  if ch = #0 then ch := readkey; // считываем след
  putimage (x2, y2, tank^, xorput);

  case ch of
  #77: if x2 < getmaxx-150 then x2 := x2 + 20;
  #75: if x2 > 0 then x2 := x2 - 20;

  #72: if y2 > 0 then y2 := y2 - 20;
  #80: if y2 < getmaxy-150 then y2 := y2 + 20;
 end;
 putimage (x2, y2, tank^, xorput);

 end;

//------------------------------------------------------------

procedure bombar (var x, y, dx, dy : integer; bomb : pointer);
begin
  putimage (x, y, bomb^, xorput);
  y := y + dy;

  if (y>(getmaxx-100)) then y := 0;


  putimage (x, y, bomb^, xorput);
end;

//------------------------------------------------------------

begin
 gd := detect;                       // подгрузка изображения
 initgraph (gd, gm, '');

 planep := loader ('planep.bmp');
 planel := loader ('planel.bmp');

 tank := loader ('tankp.bmp');

 bomb := loader ('bomb.bmp');

 x := 50; y := 50; dx := 10; dy := 10; bx := 100; by := 100; bdy := 20;
 x2 := 450; y2 := (getmaxy-100);
 plane := planep;

 putimage (x, y, plane^, xorput);
 putimage (x2, y2, tank^, xorput);
 putimage (bx, by, bomb^, xorput);


 repeat
   neupr (x, y, dx, dy, plane);
   bombar (bx, by, by, bdy, bomb);
   if keypressed then Upr;
   delay (50);
 until ch = #27;

keypressed;
closegraph;
end.
