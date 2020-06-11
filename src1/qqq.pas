uses wingraph, wincrt;
var gd, gm : integer;

begin
 gd := detect;
 initgraph (gd, gm, '');

//  putpixel (950, 700, red);
//  setcolor (darkgray);
//  line (500, 300, 700, 100);
//  circle (200, 400, 20);
//  rectangle (100, 200, 300, 400);

  setfillstyle (7, darkgray); //dom
  bar (300, 600, 600, 300);

  setcolor (yellow);
  line (300, 300, 450, 200); //skaty kryshi
  line (450, 200, 600, 300);
  line (300, 300, 600, 300);
  setfillstyle (3, yellow);
  floodfill (350, 280, yellow);

  setfillstyle (1, blue); //okno
  bar (350, 550, 550, 350);
  line (450, 550, 450, 350);
  line (350, 450, 550, 450);

  setcolor (green);
  circle (450, 260, 30); //okno v kryshe
  setfillstyle (1, green);
  floodfill (450, 260, green);

  line (520, 245, 520, 180); //truba
  line (520, 180, 580, 180);
  line (580, 180, 580, 285);


  setfillstyle (1, red);   //stupenki
  bar (600, 600, 680, 550);
  bar (680, 600, 750, 580);

  line (600, 400, 680, 430); //krulco


 readkey;
 closegraph;
end.
