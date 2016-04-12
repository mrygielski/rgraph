
program picture;

uses rgraph;

var
   tx, ty : integer;
   x, y : integer;
   rx, ry : integer;
   znak : char;

begin
     initgraph(2);
     rx:=135;
     ry:=85;
     for tx:= 0 to 320 do
     for ty:= 0 to 200 do
     begin
          putpixel(tx,ty,random(11)+20,2);
     end;
     repeat
           for x:= 1 to 50 do
           for y:= 1 to 50 do
           begin
                putpixel(x+rx,y+ry,x xor y,1);
           end;
           pokazgrafike;
           znak:=readkey;
           clearlayer(1);
           if znak='d' then rx:=rx+5;
           if znak='a' then rx:=rx-5;
           if znak='s' then ry:=ry+5;
           if znak='w' then ry:=ry-5;
           if rx<0 then rx:=rx+5;
           if rx>270 then rx:=rx-5;
           if ry<0 then ry:=ry+5;
           if ry>150 then ry:=ry-5;
     until znak=#27; {ESC}
     closegraph
end.