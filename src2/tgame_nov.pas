uses wingraph, wincrt;

const esc=#27; probel=#13; left1=#75; right1=#77; left2=#59; right2=#60;

var  gd, gm                          : integer; // grafika
     key                             : char;    // klavisha

     sharx, shary, shardx, shardy    : integer; // koord shara
     platfbx, platfby                : integer; // koord platf bottom

     shar, platfb                    : pointer; // podgr img

     mass : array [1..2, 1..10] of integer = ((1,1,0,1,1,0,1,0,1,1),
                                              (1,1,0,1,1,0,1,0,1,1));

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

//---------------------------------------------------------------- images

    procedure images;
      begin
        shar := loader ('img\shar\shar.bmp');
        platfb := loader ('img\platf\platfb.bmp');
        
        sharx := 495;   shary := (getmaxy-62);
        platfbx := 450; platfby := (getmaxy-50);
                
        putimage (sharx, shary, shar^, xorput);
        putimage (platfbx, platfby, platfb^, xorput);
      end; {procedure}

//----------------------------------------------------------------------

//----------------------------------------------------------------- static

    procedure static (var sharx, shary, shardx, shardy,
                          platfbx, platfby : integer; shar, platfb : pointer);
      begin

      end; {procedure}

//----------------------------------------------------------------------

//--------------------------------------------------------------- dynamic

        procedure dynamic (var sharx, shary, shardx, shardy,
                               platfbx, platfby : integer; shar, platfb : pointer);
          begin
            putimage (sharx, shary, shar^, xorput);
            sharx := sharx + shardx;
            shary := shary + shardy;

            shardx := 10; shardy := 10;

            //-------------------------------------------- otbivanie ot kraev sprava sleva
            if (sharx>(getmaxx-10)) then shardx := -shardx;
            if (sharx<10) then shardx := -shardx;
            //-------------------------------------------- otbivanie ot kraya sverhu
            if (shary<10) then shardy := -shardy;
            //-------------------------------------------------- pri propuske shara snizu
            putimage (platfbx, platfby, platfb^, xorput);
              if (shary>(getmaxy-10)) then
                begin
                  shardy := -shardy;
                  platfby := platfby-80; // shag
                end;
            putimage (platfbx, platfby, platfb^, xorput);
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
              //---------------------------------------------- otbivanie ot nizhn paneli
              if ((sharx>platfbx-30) and (sharx<(platfbx+100))) and ((shary>platfby-10) and (shary<platfby)) then
                begin
                  shardy := -shardy;
                end;
              putimage (sharx, shary, shar^, xorput);
          end; {procedure}

//----------------------------------------------------------------------

//------------------------------------------------------------ platf bottom

procedure platf;
  begin
   key := readkey;
   if key = #0 then key := readkey; 

    putimage (platfbx, platfby, platfb^, xorput);
    case key of
      #77: if platfbx < getmaxx-150 then platfbx := platfbx + 50; // vpravo
      #75: if platfbx > 0 then platfbx := platfbx - 50;           // vlevo
    end;
    putimage (platfbx, platfby, platfb^, xorput);

   end; {procedure}

 //----------------------------------------------------------------------

//------------------------------------------------------------- main prog

begin
  gd := detect;                     
  initgraph (gd, gm, '');

  images;

  //dynamic (sharx, shary, shardx, shardy, platfbx, platfby, shar, platfb);


  repeat
    dynamic (sharx, shary, shardx, shardy, platfbx, platfby, shar, platfb);
   
   if keypressed then platf;
  until key = esc;

  closegraph;
end.
