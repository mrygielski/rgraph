
program layers;

uses rgraph;

begin
     initgraph(2);
     outtextxy(10,10,1,1,15,1,'TO JEST BAR NA STRONIE NR 2',false);
     bar(120,80,190,120,1,2);
     outtextxy(230,190,1,1,15,1,'ENTERKEY...',false);
     pokazgrafike;
     enterkey;
     outtextxy(10,10,1,1,0,1,'TO JEST BAR NA STRONIE NR 2',false);
     outtextxy(10,10,1,1,15,1,'TO JEST BAR NA STRONIE NR 1',false);
     bar(80,50,230,150,2,1);
     pokazgrafike;
     enterkey;
     outtextxy(10,10,1,1,0,1,'TO JEST BAR NA STRONIE NR 1',false);
     outtextxy(10,10,1,1,15,1,'TO JEST BAR O KOLORZE 255',false);
     bar(90,60,220,140,255,1);
     pokazgrafike;
     enterkey;
     closegraph;
end.