uses wingraph, wincrt;
var gd, gm, x, y: integer;
begin
        randomize;
        gd:=detect;
        initgraph(gd,gm,'');

x:=random(getmaxx);
y:=random(getmaxy);

setfillstyle(1, white);
bar (300,200, getmaxx-100, getmaxy-100);

setfillstyle(1, red);
setcolor(red);
circle(x,y, 60);
floodfill(x,y, red);

if (x > 300+60) and (x < getmaxx-100-60)
 and  (y > 200+60) and (y < getmaxy-100-60) then outtextxy(10,10, 'strike') else
if (x < 300-60) or (x > getmaxx-300+60)
 or (y < 200-60) or (y > getmaxy-200+60) then outtextxy(10,10, 'miss') else
outtextxy(10,10,'Граница');




readkey;
closegraph;

end.
