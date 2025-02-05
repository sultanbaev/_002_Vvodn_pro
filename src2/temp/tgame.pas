uses wingraph, wincrt;

//const up=#72; down=#80; esc=#27;

var  gd, gm                         : integer;
     menuy                          : integer; // koord menu y
     sharx, shary, shardx, shardy   : integer; // koord shara

     head, play, help, eixt, choise : pointer; // img menu
     shar, shar1, shar2             : pointer; // img shara

     ch                             : char;


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

//------------------------------------------------------------ neurp

procedure neupr (var sharx, shary, shardx, shardy : integer;
var shar : pointer);
begin
  putimage (sharx, shary, shar^, xorput);
  sharx := sharx + shardx;

  if (sharx>(getmaxx-100)) then
    begin
      shar := shar1;
      shardx := -shardx;
    end;

  if (sharx<1) then
    begin
      shar := shar2;
      shardx := -shardx;
    end;

  putimage (sharx, shary, shar^, xorput);
end;

//-------------------------------------------------------------- menu

procedure choisem;
begin
  ch := readkey;
  if ch = #0 then begin
  ch := readkey;
  putimage (200, menuy, choise^, xorput);

  case ch of
  #72: if menuy > 300 then menuy := menuy - 50;
  #80: if menuy < getmaxy-350 then menuy := menuy + 50;
  end;
                  end;
 putimage (200, menuy, choise^, xorput);
end;

//------------------------------------------------------------ images

begin
 gd := detect;
 initgraph (gd, gm, '');

 head   := loader ('menu\head.bmp');
 play   := loader ('menu\play.bmp');
 help   := loader ('menu\help.bmp');
 eixt   := loader ('menu\exit.bmp');
 choise := loader ('menu\choise.bmp');
 shar1  := loader ('shar\shar1.bmp');
 shar2  := loader ('shar\shar2.bmp');

 putimage (25, 20, head^, xorput);
 putimage (250, 300, play^, xorput);
 putimage (250, 350, help^, xorput);
 putimage (250, 400, eixt^, xorput);

 menuy := 297; putimage (200, menuy, choise^, xorput);

 shar := shar1; putimage (getmaxx-200, getmaxy, shar^, xorput);

//------------------------------------------------------------------

 repeat
 choisem;
 if keypressed then neupr;
 //delay (50);
 until ch = #27;

//------------------------------------------------------------------


//readkey;
keypressed;
closegraph;
end.
