program funct;
uses wingraph,wincrt;
var  nap,gd,gm,x,y,dx,dy,del,x2,y2,dx2,dy2,bx,by,bdy:integer;
     pic,pic2,pic3:pointer;
     k:char;
const iter=50;
function loader(filename:string):pointer;
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









procedure neupr(var nx,ny,ndx,ndy:integer; nep:pointer);

 begin
  putimage(nx,ny,nep^,xorput);
  nx:=nx+ndx;
 // ny:=ny+ndy;

  if (nx>(getmaxx-100)) then ndx:=-ndx;
  if (nx<1) then ndx:=-ndx;

 { if (ny>(getmaxy-100)) then ndy:=-ndy;
  if (ny<1) then ndy:=-ndy;
 }
  putimage(nx,ny,nep^,xorput)

end;









procedure bomb(var nx,ny,ndy:integer; nep:pointer);

 begin
  putimage(nx,ny,nep^,xorput);
  ny:=ny+ndy;


  if (ny>(getmaxy-100)) then ny:=0;

  putimage(nx,ny,nep^,xorput)

end;









procedure upr;
begin
   k:=readkey;

   if (k=#0) then k:=readkey;
    putimage(x2,y2,pic2^,xorput);

    case k of
    #77:if x2<getmaxx-100 then  x2:=x2+iter;
    #75:if x2>0 then x2:=x2-iter;
    #72:if y2>0 then y2:=y2-iter;
    #80:if y2<getmaxy-100 then y2:=y2+iter;
   end;

   putimage(x2,y2,pic2^,xorput);

end;













begin


 gd:=detect;
 initgraph(gd,gm,'');
 pic:=loader('character.bmp');
 pic2:=loader('enemy.bmp');
 pic3:=loader('bomb.bmp');
  x:=50;
  y:=50;
  dx:=10;
  dy:=10;

  x2:=100;
  y2:=100;
  dx2:=20;
  dy2:=20;

  bx:=100;
  by:=100;
  bdy:=20;

 putimage(x,y,pic^,xorput);
 putimage(x2,y2,pic2^,xorput);

 repeat

  neupr(x,y,dx,dy,pic);
  bomb(bx,by,bdy,pic3);

  if keypressed then upr;
  delay(10
  );

 until k=#27;

// readkey;
 closegraph;

end.
