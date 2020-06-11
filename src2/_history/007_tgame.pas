uses wingraph, wincrt;

const esc = #27; probel = #13; left = #75; right = #77;
      //green = 3003; yellow = 2002; red = 1001;

var  gd, gm                          : integer; // grafika
     key                             : char;    // klavisha

     sharx, shary, shardx, shardy    : integer; // koord shara
     platfbx, platfby                : integer; // koord platf bottom
     matrx, matry                    : integer; // koord matr
     //matr2x, matr2y                  : integer; // koord matr2

     shar, platfb, matr, matr2       : pointer; // podgr img

     life                            : integer; // G-Y-R
     gameover                        : string; // 'GAME OVER'

     i, j                            : integer;

     mass : array [1..3, 1..15] of integer = ((1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
                                              (2,2,2,2,2,2,2,2,2,2,2,2,2,2,2),
                                              (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1));

//----------------------------------------------------------------------

//--------------------------------------------------------------- loader

function loader (filename : string) : pointer;
var sz                              : longint;
p                                   : pointer;
f                                   : file;

begin
  assign (f, filename);
  reset (f, 1);
  sz := filesize (f);
  getmem (p, sz);
  blockread (f, p^, sz);
  close (f);
  loader := p;
 end; {function}

//----------------------------------------------------------------------

//----------------------------------------------------------- game over

    procedure game_over_proc;
      begin
        setfillstyle (1, black);
        bar (0, 0, getmaxx, getmaxy);

        gameover := 'GAME OVER';
        setcolor (white);
        outtextxy ((getmaxx div 2) - 100, getmaxy div 2, gameover);
      end; {procedure}

//----------------------------------------------------------------------

//----------------------------------------------------------------- life

    procedure life_proc;
      begin
            setfillstyle (1, green);
            bar (20, getmaxy-20, getmaxx-20, getmaxy-15);

            if (life = 2002) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
                setfillstyle (1, yellow);
                bar (20, getmaxy-20, getmaxx div 2, getmaxy-15);
              end;

            if (life = 1001) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
                setfillstyle (1, red);
                bar (20, getmaxy-20, getmaxx div 3, getmaxy-15);
              end;
      end; {procedure}

//----------------------------------------------------------------------

//---------------------------------------------------------- otr massiv

     procedure otr_massiv;
        begin
          matrx := 60; matry := (getmaxy div 9)+50;

          for i := 1 to 3 do begin
            for j := 1 to 15 do begin

                  case mass[i, j] of
                    0 : begin matrx:=matrx + 50; end;
                    1 : begin putimage (matrx, matry, matr^, xorput); matrx := matrx + 55; end;
                    2 : begin putimage (matrx, matry, matr2^, xorput); matrx := matrx + 55; end;
                  end; {case}
                
             end; {for}
              matrx := 60; matry := matry + 22;  
            end; {for}
        end; {procedure}

//----------------------------------------------------------------------

//------------------------------------------------------------------ shar

procedure shar_proc (var sharx, shary, shardx, shardy : integer;
                         shar : pointer);

  begin
   putimage (sharx, shary, shar^, xorput);
   sharx := sharx + shardx;
   shary := shary + shardy;

   //-------------------------------------------- otbivanie ot kraev sprava sleva
   if (sharx>(getmaxx-10)) then shardx := -shardx;
   if (sharx<10) then shardx := -shardx;

   //-------------------------------------------- otbivanie ot kraev snizu sverhu
   if (shary<10) then shardy := -shardy;

   //-------------------------------------------------------- otbivanie ot matr
   if ((sharx>matrx-30) and (sharx<(matrx+50))) and ((shary>matry-30) and (shary<matry)) then
      begin
       shardy := -shardy;
      end;
   //----------------------------------------------------------------------

   //-------------------------------------------------- pri propuske shara snizu
   putimage (platfbx, platfby, platfb^, xorput);
   if (shary>(getmaxy-10)) then
    begin
      if (life = 2002) then
        begin
          shardy := -shardy;
          life := 1001;
          // -----------------------------------------------------------------
          //begin game_over_proc; end;
          // -----------------------------------------------------------------
        end
      else
        begin
          shardy := -shardy;
          life := 2002;
        end;
    end;
   putimage (platfbx, platfby, platfb^, xorput);

   //---------------------------------------------- otbivanie ot nizhn paneli
   if ((sharx>platfbx-30) and (sharx<(platfbx+100))) and ((shary>platfby-10) and (shary<platfby)) then
      begin
       shardy := -shardy;
      end;

   putimage (sharx, shary, shar^, xorput);
  end; {procedure}

//----------------------------------------------------------------------

//------------------------------------------------------------ platf bottom

procedure platf_proc;
  begin
   key := readkey;
   if key = #0 then key := readkey;

    putimage (platfbx, platfby, platfb^, xorput);
    case key of
      right : if platfbx < getmaxx-150 then platfbx := platfbx + 50; // vpravo
      left : if platfbx > 0 then platfbx := platfbx - 50;           // vlevo
    end; {case}
    putimage (platfbx, platfby, platfb^, xorput);
   end; {procedure}

 //----------------------------------------------------------------------

//------------------------------------------------------------------- main prog

begin
  gd := detect;
  initgraph (gd, gm, '');

  shar   := loader ('img\shar\shar.bmp');
  platfb := loader ('img\platf\platfb.bmp');
  matr   := loader ('img\matr\matr.bmp');
  matr2  := loader ('img\matr\matr2.bmp');

  sharx := 495; shary := (getmaxy-65); shardx := 10; shardy := 10;
  platfbx := 450; platfby := (getmaxy-50);

  putimage (sharx, shary, shar^, xorput);
  putimage (platfbx, platfby, platfb^, xorput);
  
  otr_massiv;
  
  repeat
   shar_proc (sharx, shary, shardx, shardy, shar);
   life_proc;
   
   if keypressed then platf_proc;
   delay (10);
  until key = esc;

  keypressed;
  closegraph;
end.
