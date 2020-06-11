uses wingraph, wincrt;

const esc = #27; enter = #13; left = #75; right = #77;
      up = #72; down = #80;

var  gd, gm                          : integer; // grafika
     key, ch                         : char;    // klavisha

     sharx, shary, shardx, shardy    : integer; // koord shara
     platfbx, platfby                : integer; // koord platf bottom
     matrx, matry                    : integer; // koord matr
     //matr2x, matr2y                  : integer; // koord matr2
     choiser                         : integer; // koord menu

     shar, platfb,
     matr, matr2, matr3,
     head, play, help, eixt, choise,
     help_img,
     good, bad                       : pointer; // podgr img

     life, lose_or_win               : integer; // G-Y-R
     gameover                        : string; // 'GAME OVER or WIN'

     i, j                            : integer;

     mass : array [1..3, 1..15] of integer;
     bonusm : array [1..3, 1..15] of integer;

         yachbx, yachby : integer;
         ib, jb : integer;
         matrbx, matrby : integer;
         bonus : integer;
         

//-----------------------------------------------------------------

//---------------------------------------------------------- loader

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

//-----------------------------------------------------------------

//------------------------------------------------------------ menu

  function menu_proc : integer;
   begin
     ch := readkey;
      if ch = #0 then begin
       ch := readkey;
       putimage (200, choiser, choise^, xorput);

         case ch of
           up : if choiser>100 then choiser := choiser - 50;
           down : if choiser<200 then choiser := choiser + 50;
           //enter : menu_proc := choiser;
         end; {case}
   end;

   putimage (200, choiser, choise^, xorput);
  end; {function}

//-----------------------------------------------------------------

//------------------------------------------------------------ help

procedure help_proc;
  begin
    help_img := loader('img\help\help_img.bmp');
    cleardevice;
    putimage (0, 0, help_img^, xorput);
    readkey;
  end; {procedure}

//-----------------------------------------------------------------

//------------------------------------------------ game over or win

    procedure game_over_or_win_proc;
      begin
      { setfillstyle (1, black);
       bar (0, 0, getmaxx, getmaxy);}
       cleardevice;

        if (lose_or_win = 0) then gameover := 'GAME OVER';
        if (lose_or_win = 1) then gameover := 'YOU WIN';

        setcolor (white);
        outtextxy ((getmaxx div 2) - 100, getmaxy div 2, gameover);

      end; {procedure}

//-----------------------------------------------------------------

//------------------------------------------------------------ life

    procedure life_proc;
      begin
            if (life = 3) then
              begin
                setfillstyle (1, green);
                bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
              end;

            if (life = 2) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
                setfillstyle (1, yellow);
                bar (20, getmaxy-20, getmaxx div 2, getmaxy-15);
              end;

            if (life = 1) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
                setfillstyle (1, red);
                bar (20, getmaxy-20, getmaxx div 3, getmaxy-15);
              end;

            if (life = 0) then
              begin
                lose_or_win := 0;
                game_over_or_win_proc;
              end;
      end; {procedure}

//-----------------------------------------------------------------

//------------------------------------------------------ otr massiv

     procedure otr_massiv;
     var yachx, yachy : integer;
        begin
          matrx := 60; matry := (getmaxy div 3);// + 50;

          for i := 1 to 3 do begin
            for j := 1 to 15 do begin

            mass [i, j] := random(4);
            yachx := j*55;
            yachy := i*16 + 200;

                  case mass[i, j] of
                    0 : begin bonus := 0; matrx := matrx + 50; end;
                    1 : begin putimage (yachx, yachy, matr^, xorput);
                              matrx := matrx + 55; end;
                    2 : begin putimage (yachx, yachy, matr2^, xorput);
                              matrx := matrx + 55; end;
                    3 : begin putimage (yachx, yachy, matr3^, xorput);
                              matrx := matrx + 55; end;
                  end; {case}

             end; {for}
              matrx := 60; matry := matry + 22;
            end; {for}
        end; {procedure}

//-----------------------------------------------------------------

//----------------------------------------------------- good or bad

     procedure bonus_proc;
        begin
          matrbx := 60; matrby := (getmaxy div 3);

          for ib := 1 to 3 do begin
            for jb := 1 to 15 do begin

            bonusm [ib, jb] := random(3) + 4;
            yachbx := jb*55;
            yachby := ib*16 + 200;

                  if (mass[i, j]<>0) then begin
                  case bonusm[ib, jb] of
                    4 : begin matrbx := matrbx + 50; end;
                    5 : begin
                          bonus := 5;
                          putimage (yachbx, yachby, good^, xorput);
                          matrbx := matrbx + 55;
                        end;
                    6 : begin
                          bonus := 6;
                          putimage (yachbx, yachby, bad^, xorput);
                          matrbx := matrbx + 55;
                        end;
                  end; {case}
              end; {if}

             end; {for}
              matrbx := 60; matrby := matrby + 22;
            end; {for}
        end; {procedure}

//-----------------------------------------------------------------

{//----------------------------------------------------------------
procedure stop_proc;
  begin
   any := readkey;
   if any = #0 then any := readkey;

    case any of
      probel : begin end;
    end;

   putimage (sharx, shary, shar^, xorput);
   sharx := 495;
   shary := (getmaxy-65);
  end;
//-----------------------------------------------------------------}

//------------------------------------------------------------- shar

procedure shar_proc (var sharx, shary, shardx, shardy : integer;
                         shar : pointer);

  var i0, j0, yachx, yachy : integer;
  //s : string;

  begin
   putimage (sharx, shary, shar^, xorput);
   sharx := sharx + shardx;
   shary := shary + shardy;

   //------------------------------- otbivanie ot kraev sprava sleva
   if (sharx>(getmaxx-10)) then shardx := -shardx;
   if (sharx<10) then shardx := -shardx;

   //------------------------------- otbivanie ot kraev snizu sverhu
   if (shary<10) then shardy := -shardy;

   //--------------------------------------------- otbivanie ot matr

     i0 := (shary-200) div 16;
     j0 := sharx div 55;

     if(i0>0) and (i0<4) and (j0>0) and (j0<16) then
        begin
          if mass[i0, j0]<>0 then
                begin
                  shardy := -shardy;
                  yachx := j0*55;
                  yachy := i0*16 + 200;
                   case mass[i0, j0] of
                     0 : begin matrx := matrx + 50; end;
                     1 : begin putimage (yachx, yachy, matr^, xorput);
                               matrx := matrx + 55; end;
                     2 : begin putimage (yachx, yachy, matr2^, xorput);
                               matrx := matrx + 55; end;
                     3 : begin putimage (yachx, yachy, matr3^, xorput);
                               matrx := matrx + 55; end;
                   end; {case}

                   mass[i0, j0] := 0;

                end;

        end;

        {if (mass[i0,j0] = 0) then
                    begin
                      lose_or_win := 1;
                      game_over_or_win_proc;
                    end;}

   //-----------------------------------------------------------------

   {//--------------------------------------------------- stolk s bonus

   ib := (shary-200) div 16;
     jb := sharx div 55;

     if(ib>0) and (ib<4) and (jb>0) and (jb<16) then
        begin
          if bonusm[ib, jb]<>0 then
                begin
                  shardy := -shardy;
                  yachbx := jb*55;
                  yachby := ib*16 + 200;
                   case bonusm[ib, jb] of
                     4 : begin matrx := matrx + 50; end;
                     5 : begin putimage (yachbx, yachby, good^, xorput);
                               matrx := matrx + 55; end;
                     6 : begin putimage (yachbx, yachby, bad^, xorput);
                               matrx := matrx + 55; end;
                     
                   end;

                   bonusm[ib, jb] := 0;

                end;

        end;

   //-----------------------------------------------------------------}

   //---------------------------------------- pri propuske shara snizu
   putimage (platfbx, platfby, platfb^, xorput);
   if (shary>(getmaxy-30)) then
    begin
      shardy := -shardy;
      life := life - 1;
    end;
   putimage (platfbx, platfby, platfb^, xorput);

   //--------------------------------------- otbivanie ot nizhn paneli
   if ((sharx>platfbx-30) and (sharx<(platfbx+100))) and
      ((shary>platfby-11) and (shary<platfby)) then
      begin
       shardy := -shardy;
      end;

   putimage (sharx, shary, shar^, xorput);
  end; {procedure}

//-----------------------------------------------------------------

//----------------------------------------------------------- platf

procedure platf_proc;
  begin
   key := readkey;
   if key = #0 then key := readkey;

    putimage (platfbx, platfby, platfb^, xorput);

    case key of
      right : if platfbx < getmaxx-150 then platfbx := platfbx + 50;
      left : if platfbx > 0 then platfbx := platfbx - 50;
    end; {case}

    putimage (platfbx, platfby, platfb^, xorput);
   end; {procedure}

 //-----------------------------------------------------------------

//-------------------------------------------------------- main prog

begin
  gd := detect;
  initgraph (gd, gm, '');

  randomize;

  shar   := loader ('img\shar\shar.bmp');
  platfb := loader ('img\platf\platfb.bmp');
  matr   := loader ('img\matr\matr.bmp');
  matr2  := loader ('img\matr\matr2.bmp');
  matr3  := loader ('img\matr\matr3.bmp');

  head   := loader ('img\menu\head.bmp');
  play   := loader ('img\menu\play.bmp');
  help   := loader ('img\menu\help.bmp');
  eixt   := loader ('img\menu\exit.bmp');
  choise := loader ('img\menu\choise.bmp');

  good   := loader ('img\bonus\good.bmp');
  bad    := loader ('img\bonus\bad.bmp');

repeat
  choiser := 100;

  putimage (150, 20, head^, xorput);
  putimage (250, 100, play^, xorput);
  putimage (250, 150, help^, xorput);
  putimage (250, 200, eixt^, xorput);
  putimage (200, choiser, choise^, xorput);

  repeat
    //cleardevice;
    menu_proc;
  until ch = enter;
    case choiser of
     100 :  begin
             cleardevice;
             sharx := 495; shary := (getmaxy-65);
             shardx := 10; shardy := 10;
             platfbx := 450; platfby := (getmaxy-50);
             life := 3;
             putimage (sharx, shary, shar^, xorput);
             putimage (platfbx, platfby, platfb^, xorput);

             otr_massiv;
             bonus_proc;

                repeat
                 shar_proc (sharx, shary, shardx, shardy, shar);

                 life_proc;

                 if keypressed then platf_proc;
                 delay (40);
                until key = esc;

             end; {begin}
     150 : begin cleardevice; help_proc; end;
    end; {case}
  until choiser = 200;

  closegraph;
end.
