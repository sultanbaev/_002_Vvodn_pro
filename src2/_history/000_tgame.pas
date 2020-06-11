    uses wingraph, wincrt;
    var  gd, gm                       : integer; // grafika
         key                          : char;    // klavisha

         sharx, shary, shardx, shardy : integer; // koord shara
         platfbx, platfby             : integer; // koord platf bottom
         platftx, platfty             : integer; // koord platf top

         shar, platfb, platft         : pointer; // podgr img



         {oh, dx2, dy2, bx, by, bdy : integer;
         x3, y3, dx3, dy3                                         : integer;
         planep, planel, bomb                        : pointer;
         s                                                        : string;}

    //--------------------------------------------------------------- loader

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

    //------------------------------------------------------------------ shar

  procedure shar_proc (var sharx, shary, shardx, shardy : integer; shar : pointer);

    begin
      putimage (sharx, shary, shar^, xorput);
      sharx := sharx + shardx;
      shary := shary + shardy;

      if (sharx>(getmaxx-10)) then shardx := -shardx; // £à ­¨æë
      if (sharx<10) then shardx := -shardx;

      if (shary>(getmaxy-10)) then shardy := -shardy;
      if (shary<10) then shardy := -shardy;
      putimage (sharx, shary, shar^, xorput);
    
      //
      //begin
          //putimage (sharx, shary, shar^, xorput);
         // if (shary>platfby) and (sharx<platfbx) {and (shary>platfby-10) and (shary<platfby-10)} then
           //begin
              //sharx := -sharx;
             // shary := -shary;
               //end;

         //putimage (sharx, shary, shar^, xorput);
       //end;
      //
    end;

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

             // -------------------------------------------------- esli f1-f2
                putimage (platftx, platfty, platft^, xorput);
                case key of
                  #60: if platftx < getmaxx-150 then platftx := platftx + 50; // vpravo
                  #59: if platftx > 0 then platftx := platftx - 50;           // vlevo
                end;
                  putimage (platftx, platfty, platft^, xorput);
             // ------------------------------------------------------------------

     end;

  {  //------------------------------------------------------------ platf top
     procedure platf_top_proc;
      begin
       key := readkey;
       if key = #0 then key := readkey; 
       putimage (platftx, platfty, platft^, xorput);

        case key of
          #60: if platftx < getmaxx-150 then platftx := platftx + 50; // vpravo
          #59: if platftx > 0 then platftx := platftx - 50;           // vlevo
        end;
         putimage (platftx, platfty, platft^, xorput);

       end;}

    //----------------------------------------------------------- prov popad

   { procedure prov_popad_shar_platf;// (var x3, y3, dx3, dy3 : integer; bomb : pointer);
    begin
      putimage (x3, y3, bomb^, xorput);
      if (sharx>platfbx-70) and (sharx<platfbx+100) and (shary>platfby-10) and (shary<platfby-10) then
        begin
          sharx := platfbx;
          shary := platfby;
        end;

      putimage (platfbx, platfby, platfb^, xorput);
    end;}

    //------------------------------------------------------------------- BMP

    begin
     gd := detect;                     
     initgraph (gd, gm, '');

     //planep := loader ('planep.bmp');
     //planel := loader ('planel.bmp');

     shar   := loader ('img\shar\shar.bmp');
     platfb := loader ('img\platf\platfb.bmp');
     platft := loader ('img\platf\platft.bmp');

     sharx := 50; shary := 50; shardx := 10; shardy := 10;
     platfbx := 450; platfby := (getmaxy-50);
     platftx := 450; platfty := (getmaxy-500);

     putimage (sharx, shary, shar^, xorput);
     putimage (platfbx, platfby, platfb^, xorput);
     putimage (platftx, platfty, platft^, xorput);   





     {bomb := loader ('bomb.bmp');
     bx := 100; by := 100; bdy := 20;
     //plane := planep;
     putimage (bx, by, bomb^, xorput);}





     repeat
       shar_proc (sharx, shary, shardx, shardy, shar);
       //prov_popad_shar_platf (platfbx, platfby, platfb);
       if keypressed then platf_proc;
       delay (50);
     until key = #27;

    keypressed;
    closegraph;
    end.
