uses wingraph, wincrt;

const esc = #27; enter = #13; left = #75; right = #77;
      up = #72; down = #80; probel = #32;

var  gd, gm                          : integer; // grafika
     key, ch                         : char;    // klavisha

     sharx, shary, shardx, shardy    : integer; // koord shara
     platfbx, platfby                : integer; // koord platf
     matrx, matry                    : integer; // koord matr
     choiser                         : integer; // koord menu

     shar, platfb,
     matr, matr2, matr3,
     head, play, help, eixt, choise,
     help_img,
     good, bad,
     welcome, star, starznimg,
     starinact, heartinact           : pointer; // podgr img

     life, lose_or_win, starzn       : integer; // G-Y-R
     gameover                        : string; // 'GAME OVER or WIN'

     i, j                           : integer; // na massiv

     mass                 : array [1..3, 1..15] of integer; // yacheyki
     bonusm               : array [1..3, 1..15] of integer; // bonus
     cerdx, cerdy, cerddy : array [1..45] of integer; // pad bonus
     cherx, chery, cherdy : array [1..45] of integer;
     starx, stary, stardy : array [1..45] of integer;

     bb                              : boolean; // shar na paneli
     usl_vyigr                       : integer;
     ns, nc, nstr                    : integer;

     starotrbon, heartotrbon,
     starotrboninact, heartotrboninact          : integer;

         yachbx, yachby : integer;
         
         matrbx, matrby : integer;
         



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

//--------------------------------------------------------- zastavk

  procedure welcome_proc;

      begin
      cleardevice;
          welcome := loader ('img\welcome\001.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(1000);
        cleardevice;
          welcome := loader ('img\welcome\002.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(1000);
        cleardevice;
          welcome := loader ('img\welcome\003.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(300);
        cleardevice;
          welcome := loader ('img\welcome\004.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(300);
        cleardevice;
          welcome := loader ('img\welcome\005.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(350);
        cleardevice;
          welcome := loader ('img\welcome\006.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(200);
        cleardevice;
          welcome := loader ('img\welcome\007.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(900);
        cleardevice;
          welcome := loader ('img\welcome\008.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(200);
        cleardevice;
          welcome := loader ('img\welcome\009.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(200);
        cleardevice;
          welcome := loader ('img\welcome\010.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(300);
        cleardevice;
          welcome := loader ('img\welcome\011.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(300);
        cleardevice;
          welcome := loader ('img\welcome\012.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(300);
        cleardevice;
          welcome := loader ('img\welcome\013.bmp');
          putimage (50, 50, welcome^, xorput);
          delay(300);
        cleardevice;
          welcome := loader ('img\welcome\014.bmp');
          putimage (50, 50, welcome^, xorput);
        repeat
        until keypressed;
        cleardevice;
      end;

//-----------------------------------------------------------------

//------------------------------------------------------------ menu

  function menu_proc : integer;
   begin
     ch := readkey;
      if ch = #0 then begin
       ch := readkey;
       putimage (200, choiser, choise^, xorput);

         case ch of
           up   : if choiser>100 then choiser := choiser - 50;
           down : if choiser<200 then choiser := choiser + 50;
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
       cleardevice;

        if (lose_or_win = 0) then
          begin
            gameover := 'GAME OVER'; // potracheno

          end;
        if (lose_or_win = 1) then gameover := 'YOU WIN';

        setcolor (white);
        outtextxy ((getmaxx div 2) - 100, getmaxy div 2, gameover);
        delay(900);
        cleardevice;

            starotrbon := (getmaxx div 2);
            heartotrbon := (getmaxx div 2);
            starotrboninact := (getmaxx div 2);
            heartotrboninact := (getmaxx div 2);
            life := 3;
            starzn := 0;
            choiser := 100;
            bb := false;
            key := #0;

            

      end; {procedure}

//-----------------------------------------------------------------

//------------------------------------------------------------ life

    {procedure life_proc;
      begin
            if (life = 3) then
              begin
                setfillstyle (1, green);
                bar (20, getmaxy-50, getmaxx-20, getmaxy-45);
              end;

            if (life = 2) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-50, getmaxx-20, getmaxy-45);
                setfillstyle (1, yellow);
                bar (20, getmaxy-50, getmaxx div 2, getmaxy-45);
              end;

            if (life = 1) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-50, getmaxx-20, getmaxy-45);
                setfillstyle (1, red);
                bar (20, getmaxy-50, getmaxx div 3, getmaxy-45);
              end;

            if (life = 0) then
              begin
                setfillstyle (1, black);
                bar (20, getmaxy-50, getmaxx-20, getmaxy-45);
                lose_or_win := 0;
                game_over_or_win_proc;
              end;
      end; procedure}

//-----------------------------------------------------------------

//-----------------------------------------------------------------
  
    procedure star_heart_inact;
    var x : integer;
      begin
      x := 0;

        for x := 1 to 10 do
          begin
            starotrboninact := starotrboninact-35;
            heartotrboninact := heartotrboninact+35;
            putimage (starotrboninact, getmaxy-30, starinact^, xorput);
            putimage (heartotrboninact, getmaxy-30, heartinact^, xorput);
          end;
      end;

    procedure star_plus;
      begin
        starotrbon := starotrbon-35;
        setfillstyle(1, black);
        putimage (starotrbon, getmaxy-30, starinact^, xorput);
        putimage (starotrbon, getmaxy-30, star^, xorput);

        if (starzn = 10) then
          begin
            lose_or_win := 1;
            //game_over_or_win_proc;
          end;
      end;

    procedure heart_plus;
    
      begin
        if (life<10) then
          begin
          
            heartotrbon := heartotrbon+35;
            putimage (heartotrbon, getmaxy-30, heartinact^, xorput);
            putimage (heartotrbon, getmaxy-30, good^, xorput);
          end;
      end;

    procedure heart_minus;
    var xx : integer;
      begin
        xx := ((getmaxx div 2)+35*life);
        heartotrbon := heartotrbon-35;
        putimage (xx, getmaxy-30, good^, xorput);
        putimage (xx, getmaxy-30, heartinact^, xorput);
      end;

//-----------------------------------------------------------------

//------------------------------------------------------ otr massiv

     procedure otr_massiv;
     var yachx, yachy : integer;
        begin
          matrx := 60; matry := 10;

          for i := 1 to 3 do begin
            for j := 1 to 15 do begin

            mass [i, j] := random(4);
            yachx := j*55;
            yachy := i*16 + 100;

                  case mass[i, j] of
                    0 : begin matrx := matrx + 50; end;
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
     {var i0, j0 : integer;}
        begin
          matrbx := 60; matrby := 10;

          for i := 1 to 3 do begin
            for j := 1 to 15 do begin

            bonusm [i, j] := random(3) + 4;
          // bonusm [i, j] := 6;
            yachbx := j*55;
            yachby := i*16 + 100;

              if (mass[i, j]<>0) then begin
                  case bonusm[i, j] of
                    4 : begin matrbx := matrbx + 50; end;
                    5 : begin
                          //bonus := good;
                          //putimage (yachbx + 15, yachby, good^, xorput);
                          matrbx := matrbx + 55;
                        end;
                    6 : begin
                          //bonus := bad;
                          //putimage (yachbx + 15, yachby, bad^, xorput);
                          
                          matrbx := matrbx + 55;
                        end;
                  end;
              end; 

             end; {for}
              matrbx := 60; matrby := matrby + 22;
            end; {for}
            
        end; {procedure}

//-----------------------------------------------------------------

//-----------------------------------------------------------------

 {procedure dvizh_cerd (var dx, dy, ddy : integer);
    begin 
       putimage (dx, dy, good^, xorput);
       
       dy := dy + 23;

      if dy>(getmaxy-70) then
          begin
            ddy := 0;
            dy := -100;
          end;

        if ((dx>platfbx-15) and (dx<platfbx+100) and (dy>platfby-15)) then
          begin
           
            life := life + 1;
            heart_plus;
            ddy := 0;
            dy := -100;
          end;

       
       putimage (dx, dy, good^, xorput);
    end; procedure}

  procedure dvizh_cerd (var cerdx, cerdy, cerddy : integer);
    begin  
       putimage (cerdx+15, cerdy, good^, xorput);

       cerdy := cerdy + cerddy;
       if cerdy>(getmaxy-70) then
          begin
            cerddy := 0;
            cerdy := -100;
          end;

        if ((cerdx>platfbx-15) and (cerdx<platfbx+100) and (cerdy>platfby-15)) then
          begin
            
            if (life<10) then life := life + 1;
            heart_plus;
            cerddy := 0;
            cerdy := -100;
          end;

      
       putimage (cerdx+15, cerdy, good^, xorput);
    end;

//-----------------------------------------------------------------

//-----------------------------------------------------------------

  procedure dvizh_cher (var cherx, chery, cherdy : integer);
    begin
       putimage (cherx+15, chery, bad^, xorput);
     
       chery := chery + cherdy;
       if chery>(getmaxy-70) then
          begin
            cherdy := 0;
            chery := -100;
          end;

        if ((cherx>platfbx-15) and (cherx<platfbx+100) and (chery>platfby-15)) then
          begin
            heart_minus; 
            if (life<10) then life := life - 1;
            cherdy := 0;
            chery := -100;
            
          end;

       {setfillstyle (1, green);
       bar (cherx, chery-5, cherx + 22, chery + 17);}
       putimage (cherx+15, chery, bad^, xorput);
    end; {procedure}

//-----------------------------------------------------------------

//-----------------------------------------------------------------

  procedure dvizh_star (var starx, stary, stardy : integer);
    begin
       putimage (starx+15, stary, star^, xorput);
     
       stary := stary + stardy;
       if stary>(getmaxy-70) then
          begin
            stardy := 0;
            stary := -100;
          end;

        if ((starx>platfbx-15) and (starx<platfbx+100) and (stary>platfby-15)) then
          begin
            starzn := starzn + 1;
            star_plus;
            stardy := 0;
            stary := -100;
          end;

       {setfillstyle (1, green);
       bar (cherx, chery-5, cherx + 22, chery + 17);}
       putimage (starx+15, stary, star^, xorput);
    end; {procedure}

//-----------------------------------------------------------------

//------------------------------------------------------------- shar

procedure shar_proc (var sharx, shary, shardx, shardy : integer;
                         shar : pointer);

  var i0, j0, yachx, yachy : integer;
      

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

     i0 := (shary-100) div 16;
     j0 := sharx div 55;

     if(i0>0) and (i0<4) and (j0>0) and (j0<16) then
        begin
          if mass[i0, j0]<>0 then
                begin
                  shardy := -shardy;
                  yachx := j0*55;
                  yachy := i0*16 + 100;
                 

                   case mass[i0, j0] of
                     0 : begin matrx := matrx + 55; end;
                     1 : begin putimage (yachx, yachy, matr^, xorput);
                               matrx := matrx + 55; end;
                     2 : begin putimage (yachx, yachy, matr2^, xorput);
                               matrx := matrx + 55; end;
                     3 : begin putimage (yachx, yachy, matr3^, xorput);
                               matrx := matrx + 55; end;
                   end; {case}

                   mass[i0, j0] := 0;
                  // bonusm[i, j] := 4;


                   case bonusm[i0, j0] of
                   4 : begin
                         nstr := nstr + 1;
                         starx[nstr] := j0*55;
                         stary[nstr] := i0*16 + 100;
                         stardy[nstr] := 5;
                         putimage(starx[nstr]+15, stary[nstr], star^, xorput);
                         
                       end;

                   5 : begin
                         ns := ns + 1;
                         cerdx[ns] := j0*55;
                         cerdy[ns] := i0*16 + 100;
                         cerddy[ns] := 5;
                         putimage(cerdx[ns]+15, cerdy[ns], good^, xorput);
                         
                       end;

                   6 : begin
                         nc := nc + 1;
                         cherx[nc] := j0*55;
                         chery[nc] := i0*16 + 100;
                         cherdy[nc] := 5;
                         putimage(cherx[nc]+15, chery[nc], bad^, xorput);
                        
                       end;

                   end; {case}

                end;

        end;

    //--------------------------------------------- uslovie vyigrysha
       usl_vyigr := 0;
      for i := 1 to 3 do begin
            for j := 1 to 15 do begin
              

                if (mass[i, j] = 0) then usl_vyigr := usl_vyigr + 1;
                

                  
            end;
      end;

      if (usl_vyigr = 45) then
                begin
                  lose_or_win := 1;
                  //me_over_or_win_proc;
                  key := esc;
                  cleardevice;
                end;
      //------
      {usl_vyigr := false;
       for i := 1 to 3 do begin
            for j := 1 to 15 do begin
              if (usl_vyigr = false) then
                begin
                  if (mass[i, j] = 0) then usl_vyigr := true;
                end;
            end;
       end;

       if (usl_vyigr = true) then
        begin
          lose_or_win := 1;
          game_over_or_win_proc;
          key := esc;
        end;}

   //-----------------------------------------------------------------

   //---------------------------------------- pri propuske shara snizu
   putimage (platfbx, platfby, platfb^, xorput);
   if (shary>(getmaxy-65)) then
    begin
      shardy := -shardy;
      heart_minus;
      if (life<10) then life := life - 1;
      bb := false;
      sharx := platfbx + 45;
      shary := (getmaxy-95);
      
    end;
   putimage (platfbx, platfby, platfb^, xorput);

   //--------------------------------------- otbivanie ot nizhn paneli
   if ((sharx>platfbx-15) and (sharx<(platfbx+100))) and
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
      right : if platfbx < getmaxx-150 then

        begin
          platfbx := platfbx + 50;
            if (bb = false) then
              begin
                putimage (sharx, shary, shar^, xorput);
                sharx := sharx + 50;
                putimage (sharx, shary, shar^, xorput);
              end;
        end;

      left : if (platfbx > 0) then

        begin
          platfbx := platfbx - 50;
            if (bb = false) then
              begin
                putimage (sharx, shary, shar^, xorput);
                sharx := sharx - 50;
                putimage (sharx, shary, shar^, xorput);
              end;
        end;

       probel : bb := true;
    end; {case}

    putimage (platfbx, platfby, platfb^, xorput);
   end; {procedure}

 //-----------------------------------------------------------------

//-------------------------------------------------------- main prog

begin
  gd := detect;
  initgraph (gd, gm, '');

  welcome_proc;
  randomize;

  

  bb := false;

  starotrbon := (getmaxx div 2);
  heartotrbon := (getmaxx div 2);
  starotrboninact := (getmaxx div 2);
  heartotrboninact := (getmaxx div 2);

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

  good   := loader ('img\bonus\heart.bmp');
  bad    := loader ('img\bonus\skull.bmp');
  star   := loader ('img\bonus\star.bmp');

  starinact := loader ('img\bonus\starinact.bmp');
  heartinact := loader ('img\bonus\heartinact.bmp');

  

repeat
  choiser := 100;

  putimage (150, 20, head^, xorput);
  putimage (250, 100, play^, xorput);
  putimage (250, 150, help^, xorput);
  putimage (250, 200, eixt^, xorput);
  putimage (200, choiser, choise^, xorput);

  repeat
    menu_proc;
  until ch = enter;
    case choiser of
     100 :  begin
             cleardevice;
             sharx := 495; shary := (getmaxy-95);
             //---------
             shardx := 10; shardy := 10;
             //----------------
             platfbx := 450; platfby := (getmaxy-80);
             life := 3;
             starzn := 0;
            // lose_or_win := 3;
             putimage (sharx, shary, shar^, xorput);
             putimage (platfbx, platfby, platfb^, xorput);

             otr_massiv;
             bonus_proc;
             ns := 0;
             nc := 0;
             nstr := 0;

             star_heart_inact;
             heart_plus; heart_plus; heart_plus;
                //g:=1;
                repeat
                 if bb then shar_proc (sharx, shary, shardx, shardy, shar);

                 {for i := 1 to 3 do begin
                  for j:=1 to 15 do begin 
                  if (bonusm[i,j]<>0) then  begin
                    if (bonusm[i,j] = 4) then begin 
                    if (g<2) then begin putimage (cerdx[i*j], cerdy[i*j], good^, xorput);
                    putimage (cerdx[i*j], cerdy[i*j], good^, xorput); end;
                      dvizh_cerd (cerdx[i*j], cerdy[i*j], cerddy[i*j]);
                     end;  
                    if (bonusm[i,j] = 5) then dvizh_cher (cherx[i*j], chery[i*j], cherdy[i*j]);
                    if (bonusm[i,j] = 6) then dvizh_star (starx[i*j], stary[i*j], stardy[i*j]);
                    end;
                  end;
                  end;
                  g:=2;
                for i := 1 to ns do begin 
                 if (j<2) then putimage (cerdx[i], cerdy[i], good^, xorput);
                 dvizh_cerd (cerdx[i], cerdy[i], cerddy[i]);  end;
                 j:=j+1;}
                for i := 1 to ns do dvizh_cerd (cerdx[i], cerdy[i], cerddy[i]);
                for i := 1 to nc do dvizh_cher (cherx[i], chery[i], cherdy[i]);
                for i := 1 to nstr do dvizh_star (starx[i], stary[i], stardy[i]);

                 //life_proc; 

                 if keypressed then platf_proc;
                 delay (40);
                until (key = esc) or (life = 0) or (starzn = 10);// or (usl_vyigr = true);
                game_over_or_win_proc;
                lose_or_win := 0;
                bonus_proc;
                key := #0;


             end; {begin}
     150 : begin cleardevice; help_proc; cleardevice; end;
    end; {case}
  until choiser = 200;

  closegraph;
end.
