  uses wingraph, wincrt;
  var  gd, gm, x, y, dx, dy, oh, x2, y2, dx2, dy2, bx, by, bdy : integer;
       x3, y3, dx3, dy3                                         : integer;
       plane, planep, planel, tank, bomb                        : pointer;
       s                                                        : string;
       ch                                                       : char;

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

  //--------------------------------------------------------------- Samolet

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

  //----------------------------------------------------------------- Tank

  procedure upr;
   begin
    ch := readkey;
    if ch = #0 then ch := readkey; // считываем след
    putimage (x2, y2, tank^, xorput);

    case ch of
    #77: if x2 < getmaxx-150 then x2 := x2 + 50;
    #75: if x2 > 0 then x2 := x2 - 50;

    #72: if y2 > 0 then y2 := y2 - 50;
    #80: if y2 < getmaxy-150 then y2 := y2 + 50;
   end;
   putimage (x2, y2, tank^, xorput);

   end;

  //------------------------------------------------------------------ Bomba

  procedure bombar (var x3, y3, dx3, dy3 : integer; bomb : pointer);
  begin
    putimage (x3, y3, bomb^, xorput);


    if (y3>(getmaxy-200)) then
      begin
        y3 := y;
        x3 := x;
      end;

    if (x3>x2-70) and (x3<x2+100) and (y3>y2-100) and (y3<y2+100) then
      begin
        y3 := y;
        x3 := x;
        oh := oh + 1;
        str (oh, s);

        setfillstyle (1, red);
        bar (0, getmaxy-55, 55, getmaxy);

        setcolor (white);
        outtextxy (0, getmaxy-50, s);
      end;

    y3 := y3 + dy3;
    putimage (x3, y3, bomb^, xorput);
  end;

  //------------------------------------------------------------------- BMP

  begin
   gd := detect;                       // подгрузка изображения
   initgraph (gd, gm, '');

   planep := loader ('planep.bmp');
   planel := loader ('planel.bmp');

   tank := loader ('tankp.bmp');

   bomb := loader ('bomb.bmp');

   x := 50; y := 50; dx := 10; dy := 10; bx := 100; by := 100; bdy := 20;
   x2 := 450; y2 := (getmaxy-200);
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
