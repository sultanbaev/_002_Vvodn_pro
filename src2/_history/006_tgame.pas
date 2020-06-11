uses wingraph, wincrt;

const esc=#27; probel=#13; left1=#75; right1=#77; left2=#59; right2=#60;

matr : array [1..2, 1..10] of integer =
((1,1,0,1,1,0,1,0,1,1),
 (1,1,0,1,1,0,1,0,1,1));

var  gd, gm                          : integer; // grafika
     key                             : char;    // klavisha

     sharx, shary, shardx, shardy    : integer; // koord shara
     platfbx, platfby                : integer; // koord platf bottom
     platftx, platfty                : integer; // koord platf top

     shar, platfb, platft, matrimg   : pointer; // podgr img

     i, j                            : integer; //schetchiki

     x, y, dx, dy, matrx, matry, ik, jk : integer;
     {s : string;
     oh : integer;}

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
 end;

//----------------------------------------------------------------------



  {//----------------------------------------------------------------------
  procedure shar_stop (var sharx, shary, shardx, shardy : integer; shar : pointer);
  begin
  //putimage (sharx, shary, shar^, xorput);
  sharx := 495; shary := (getmaxy-65); shardx := 0; shardy := 0;
  putimage (sharx, shary, shar^, xorput);
  end;
  //----------------------------------------------------------------------}

  //----------------------------------------------------------------------
  procedure otr_matr (var ik, jk : integer; matrimg : pointer);
  var i, j, x, y : integer;
  begin
    //x := 10; y := 10;
    dx:=55;    dy:=getmaxy div 2;
    matrx:= 10;  matry:=getmaxy div 2;
    
    //setfillstyle (1, green);
    //bar (20, 30, 70, 60);
      for i := 1 to 10 do
        for j := 1 to 2 do
          begin
            //x := (j-1)*dx + matrx; y := (i-1)*dy + matry;
            putimage (matrx, matry, matrimg^, xorput);
             case matr[i,j] of
              0 : begin
                    {setfillstyle(8, brown);
                    bar (x, y, x+dx, y+dy);}

                  end;
              1 : begin
                    {setfillstyle(8, white);
                    bar (x, y, x+dx, y+dy);}
                    matrx:=10+dx; matry:=getmaxy div 2;
                    putimage (matrx, matry, matrimg^, xorput);
                  end;
             end; {case}
             putimage (matrx, matry, matrimg^, xorput);
          end;
  end;
  //----------------------------------------------------------------------



//------------------------------------------------------------------ shar

procedure shar_proc (var sharx, shary, shardx, shardy : integer; shar : pointer);

  begin
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
   putimage (sharx, shary, shar^, xorput);
   sharx := sharx + shardx;
   shary := shary + shardy;
   
   //-------------------------------------------- otbivanie ot kraev sprava sleva
   if (sharx>(getmaxx-10)) then shardx := -shardx;
   if (sharx<10) then shardx := -shardx;

   {//-------------------------------------------- otbivanie ot kraev snizu sverhu
   if (shary>(getmaxy-10)) then shardy := -shardy;
   if (shary<10) then shardy := -shardy;}

   //-------------------------------------------------- pri propuske shara snizu
   putimage (platfbx, platfby, platfb^, xorput);
   if (shary>(getmaxy-10)) then
    begin
     shardy := -shardy;
     platfby := platfby-80; // shag
     end;
   putimage (platfbx, platfby, platfb^, xorput);
   
   //---------------------------------------------------- pri propuske shara sverhu
   putimage (platftx, platfty, platft^, xorput);
   if (shary<10) then
    begin
     shardy := -shardy;
     platfty := platfty+80; // shag
     end;
   putimage (platftx, platfty, platft^, xorput);
   //-------------------------------------------------------------------
   {setcolor (white);
   line (0, getmaxy div 2, getmaxx, getmaxy div 2); // centr
   line (0, getmaxy-90, getmaxx, getmaxy-90); // 6
   line (0, getmaxy-150, getmaxx, getmaxy-150); // 5}

   //--------------------------------------------------------- zhizni u nizhnego
   setfillstyle (1, green);
   bar (20, getmaxy-20, getmaxx-20, getmaxy-15);

   if (platfby<(getmaxy-90)) then // kross 6
    begin
     setfillstyle (1, black);
     bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
     setfillstyle (1, yellow);
     bar (20, getmaxy-20, getmaxx div 2, getmaxy-15);
    end;

   if (platfby<(getmaxy-150)) then // kross 5
    begin
     setfillstyle (1, black);
     bar (20, getmaxy-20, getmaxx-20, getmaxy-15);
     setfillstyle (1, red);
     bar (20, getmaxy-20, getmaxx div 3, getmaxy-15);
    end;

     //------------------------------------------------------ zhizni u verhnego
     setfillstyle (1, green);
     bar (20, 15, getmaxx-20, 20);

     if (platfty>(90)) then
      begin
       setfillstyle (1, black);
       bar (20, 15, getmaxx-20, 20);
       setfillstyle (1, yellow);
       bar (20, 15, (getmaxx-20) div 2, 20);
      end;

     if (platfty>(150)) then
      begin
       setfillstyle (1, black);
       bar (20, 15, getmaxx-20, 20);
       setfillstyle (1, red);
       bar (20, 15, (getmaxx-20) div 3, 20);
      end;

   //-------------------------------------------------------------------
      
   //---------------------------------------------- otbivanie ot nizhn paneli
   if ((sharx>platfbx-30) and (sharx<(platfbx+100))) and ((shary>platfby-10) and (shary<platfby)) then
      begin
       shardy := -shardy;
      end;
    
    //--------------------------------------------- otbivanie ot verhn paneli 
    if ((sharx>platftx-30) and (sharx<(platftx+110))) and ((shary>platfty-10) and (shary<platfty)) then
      begin
       shardy := -shardy;
      end;   

   putimage (sharx, shary, shar^, xorput);
  end;

//----------------------------------------------------------------------

//------------------------------------------------------------ platf bottom

procedure platf_proc;
  begin
   key := readkey;
   if key = #0 then key := readkey; 

    putimage (platfbx, platfby, platfb^, xorput);
    case key of
      #77: if platfbx < getmaxx-150 then platfbx := platfbx + 50; // vpravo
      #75: if platfbx > 0 then platfbx := platfbx - 50;           // vlevo
    end;
    putimage (platfbx, platfby, platfb^, xorput);

         //----------------------------------------------------- esli f1-f2
              putimage (platftx, platfty, platft^, xorput);
              case key of
                #60: if platftx < getmaxx-150 then platftx := platftx + 50; // vpravo
                #59: if platftx > 0 then platftx := platftx - 50;           // vlevo
              end;
              putimage (platftx, platfty, platft^, xorput);
         // ------------------------------------------------------------------

   end;

 //----------------------------------------------------------------------

//------------------------------------------------------------------- main prog

begin
  gd := detect;                     
  initgraph (gd, gm, '');

  shar   := loader ('img\shar\shar.bmp');
  platfb := loader ('img\platf\platfb.bmp');
  platft := loader ('img\platf\platft.bmp');
  matrimg := loader ('img\matr\matr.bmp');

  sharx := 495; shary := (getmaxy-65); shardx := 10; shardy := 10;
  platfbx := 450; platfby := (getmaxy-50);
  platftx := 450; platfty := (getmaxy-500);

  putimage (sharx, shary, shar^, xorput);
  putimage (platfbx, platfby, platfb^, xorput);
  putimage (platftx, platfty, platft^, xorput);
  putimage (matrx, matry, matrimg^, xorput);    

  repeat
   shar_proc (sharx, shary, shardx, shardy, shar);

   otr_matr (ik, jk, matrimg);
   {//----------------------------------------------------
   shar_stop (sharx, shary, shardx, shardy, shar);
   key := readkey;
   //if key = #0 then key := readkey;
   case key of
     #13 : shar_proc (sharx, shary, shardx, shardy, shar);
   end;
   //----------------------------------------------------}
   if keypressed then platf_proc;
   delay (50);
  until key = #27;

  keypressed;
  closegraph;
  end.
