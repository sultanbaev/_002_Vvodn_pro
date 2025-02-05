uses wingraph, wincrt;

//const up=#72; down=#80; esc=#27;

var  gd, gm                         : integer;
     menuy                          : integer;

     head, play, help, eixt         : pointer;
     choise                         : pointer;

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

//-------------------------------------------------------- menu images

begin
 gd := detect;
 initgraph (gd, gm, '');

 head := loader ('menu\head.bmp');
 putimage (25, 20, head^, xorput);

 play := loader ('menu\play.bmp');
 putimage (250, 300, play^, xorput);

 help := loader ('menu\help.bmp');
 putimage (250, 350, help^, xorput);

 eixt := loader ('menu\exit.bmp');
 putimage (250, 400, eixt^, xorput);

 choise := loader ('menu\choise.bmp');

 menuy:=297;

 putimage (200, menuy, choise^, xorput);

//------------------------------------------------------------------

 repeat
   if keypressed then choisem;
   delay (50);
 until ch = #27;

//------------------------------------------------------------------


//readkey;
keypressed;
closegraph;
end.
