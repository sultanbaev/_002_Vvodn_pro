uses wingraph, wincrt;
var gd, gm, x, y: integer;
begin
        randomize;
        gd:=detect;
        initgraph(gd,gm,'');

x:=random(getmaxx-50);
y:=random(getmaxy-50);

setcolor(yellow);
line(getmaxx div 2, 0, getmaxx div 2, getmaxy);






setfillstyle(1, red);
circle(x,y,30);
floodfill(x,y,yellow);

if (x < getmaxx div 2-30) then outtextxy ( 20, 20, 'лево') else
if (x > getmaxx div 2+30) then outtextxy ( 700, 30, 'право') else
 outtextxy (450,450, 'граница');










readkey;
closegraph;

end.

