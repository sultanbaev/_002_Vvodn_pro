uses wingraph,wincrt;
var gd,gm,x,c,x1 : integer;
begin
gd:= detect;
initgraph (gd,gm,'');

x:=40;
c:=0;
x1:=80;
repeat
c:=c+1;
setcolor(yellow);
if c = 1 then

         setfillstyle(1,red);
if c = 2 then

         setfillstyle(1,blue);
if c = 3 then

         setfillstyle(1,green);



circle(x,40,40);
floodfill (x,40,yellow);
x:=x+160;
bar(x1,0,x1+80,80);
x1:=x1+160;
if c =3 then c:= 0;

delay(100);
until (x >getmaxx);



readkey;
closegraph;
end.
