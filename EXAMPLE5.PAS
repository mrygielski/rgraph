
program scrool;

uses rgraph;

var
   x, y : integer;
   x2, y2 : integer;
   x3, y3 : integer;
   x4, y4 : integer;
   stx, sty : integer;
   stx2, sty2 : integer;
   stx3, sty3 : integer;
   stx4, sty4 : integer;
   texty : integer;

begin
     initgraph(2);
     x:=160;
     y:=100;
     x2:=160;
     y2:=100;
     x3:=160;
     y3:=100;
     x4:=160;
     y4:=100;
     stx:=3;
     sty:=3;
     stx2:=3;
     sty2:=3;
     stx3:=3;
     sty3:=3;
     stx4:=3;
     sty4:=3;
     texty:=-90;
     repeat
           texty:=texty+1;
           putpixel(x,y,random(11)+20,2);
           putpixel(x2,y2,random(11)+20,2);
           putpixel(x3,y3,random(11)+20,2);
           putpixel(x4,y4,random(11)+20,2);
           outtextxy(39,texty div 2-1,2,2,7,1,'RGRAPH by REGi',false);
           outtextxy(28,(texty+38) div 2,2,2,7,1,'MICHAL RYGIELSKI',false);
           outtextxy(28,(texty+38) div 2,2,2,7,1,'     -',false);
           outtextxy(40,texty div 2,2,2,8,1,'RGRAPH by REGi',false);
           outtextxy(29,(texty+40) div 2,2,2,8,1,'MICHAL RYGIELSKI',false);
           outtextxy(29,(texty+40) div 2,2,2,8,1,'     -',false);
           pokazgrafike;
           clearlayer(1);
           if (x>320) or (x<0) then stx:=-stx; x:=x+stx;
           if (y>200) or (y<0) then sty:=-sty; y:=y+sty;
           if (x2>320) or (x2<0) then stx2:=-stx2; x2:=x2-stx2;
           if (y2>200) or (y2<0) then sty2:=-sty2; y2:=y2-sty2;
           if (x3>320) or (x3<0) then stx3:=-stx3; x3:=x3+stx3;
           if (y3>200) or (y3<0) then sty3:=-sty3; y3:=y3-sty3;
           if (x4>320) or (x4<0) then stx4:=-stx4; x4:=x4-stx4;
           if (y4>200) or (y4<0) then sty4:=-sty4; y4:=y4+sty4;
           if texty=420 then texty:=-90;
     until keypressed;
     closegraph;
end.