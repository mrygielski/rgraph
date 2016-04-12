
program blurtest;

uses rgraph;

var
   x, y : integer;

begin
     initgraph(2);
     for x:= 0 to 320 do
     for y:= 0 to 200 do
     begin
          putpixel(x,y,random(11)+20,2);
     end;
     line(160,0,160,200,0,2);
     outtextxy(50,20,1,1,0,1,'OBYDWIE STRONY SA TAKIE SAME',false);
     outtextxy(230,190,1,1,0,1,'ENTERKEY...',false);
     pokazgrafike;
     enterkey;
     clearlayer(1);
     outtextxy(0,20,1,1,0,1,'  TA JEST NORMALNA    TA JEST ROZMAZANA',false);
     outtextxy(230,190,1,1,0,1,'ENTERKEY...',false);
     blur(161,0,322,200,8,false,2);
     pokazgrafike;
     enterkey;
     closegraph;
end.