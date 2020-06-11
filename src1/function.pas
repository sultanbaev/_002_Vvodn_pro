uses wingraph,wincrt;
var gd,gm,x,y,dx,dy,x2,y2,dx2,dy2:integer;
     q1:pointer;
     q2:pointer;

     ch:char;
function loader (Filename:string):pointer;
    var sz:longint;
        p:pointer;
        f:file;

begin
        assign(f,filename);
        reset(f,1);
        sz:=filesize(f);
        getmem(p,sz);
        blockread(f,p^,sz);
        close(f);
        loader:=p;
        end;


procedure Upr;

     begin

     ch:=readkey;
     if ch = #0 then ch:=readkey;
     putimage(x2,y2,q2^,xorput);

     case ch of
     #77: if x2<getmaxx-150 then x2:=x2+20;
     #75: if x2>0 then x2:=x2-20;
     #72: if y2>0 then y2:=y2-20;
     #80: if y2<getmaxy-150 then y2:=y2+20;
     end;

     putimage(x2,y2,q2^,xorput);



    end;


    procedure Neupr(q1:pointer; var x,y,dx,dy:integer);
begin


putimage(x,y,q1^,xorput);

x:=x+dx;
//y:=y+dy;

if x> getmaxx-150 then dx:=-dx;
if x< 1 then dx:=-dx;

if y> getmaxy-150 then dy:=-dy;
if y< 1 then dy:=-dy;
   putimage(x,y,q1^,xorput);


end;

begin
        gd:=detect;
        initgraph(gd,gm,'');

        q1:=loader('qq.bmp');
        q2:=loader('qq2.bmp');
        x:=420;
        y:=250;
        dx:=5;
        dy:=5;

        putimage(x,y,q1^,xorput);
       putimage(x2,y2,q2^,xorput);
    //    x2:=420;
   //     y2:=250;
   //     dx2:=6;
   //     dy2:=6;

   //     putimage(x2,y2,q1^,xorput);

      repeat
        neupr(q1,x,y,dx,dy);
        if keypressed then Upr;
        delay (1);
        until ch = #27;


      //  neupr(q1,x2,y2,dx2,dy2);
    //    delay(5);
   //     until keypressed;
   //     readkey;



  closegraph;


end.
