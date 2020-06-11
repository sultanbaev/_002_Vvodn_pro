    uses wingraph,wincrt;
    var gd,gm,i,i1:integer;
    begin
    gd:= detect;
    initgraph (gd,gm, '');


    for i:=1 to 18 do
   begin

    setcolor(red);
    if i mod 3=0 then setfillstyle(1,red) else
    if i mod 3=2 then setfillstyle(1,green) else   setfillstyle(1,brown);

     if i mod 2=0 then begin
    circle(i*50-25,25,25);
   floodfill(i*50-25,25,red);
   end else
   if i mod 1=0 then begin
   bar(i*50-49,0,i*50-1,50);
   end;


   for i:=18 to 1 do

   if i mod 2=0 then begin
   bar(i*50-49,70,i*50-1,130);
      end;

   if i mod 1=0 then begin
   circle(i*50-25,95,25);
   floodfill(i*50-25,95,red);




   end;





  //  circle(i*50-25,25,25);




  //  floodfill(i*50-20,25,red);
   // circle((i*3-2)*50-25,25,25);
   // floodfill((i*3-2)*50-25,25,red);
  {

    setcolor(blue);
    setfillstyle(1,blue);
    circle((i*3-1)*50-25,25,25);
    floodfill((i*3-1)*50-25,25,blue);


    setcolor(yellow);
    setfillstyle(1,yellow);
    circle(i*3*50-25,25,25);
    floodfill(i*3*50-25,25,yellow);
   }
    delay(200);
    end;












    readkey;
    closegraph;
 end.
