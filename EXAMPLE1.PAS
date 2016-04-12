
program benchmark;

uses rgraph;

var
   time : stoper;
   rp, rl, rb, rr, re, rc : longint; {random}
   p, l, b, r, e, c : longint; {normal}

begin
     initgraph(2);
     bar(0,0,320,200,1,1);
     outtextxy(110,90,1,1,15,1,'BENCHMARK',false);
     pokazgrafike;
     {*RANDOM*}
     outtextxy(10,10,1,1,12,1,'RANDOM:',false);
     outtextxy(10,20,1,1,0,1,'PUTPIXEL',false);
     pokazgrafike;
     time.start;
     repeat
           inc(rp);
           putpixel(random(resx-1),random(resy-1),random(255),2);
     until time.stop=1;
     outtextxy(10,20,1,1,0,1,'PUTPIXEL - '+numstr(rp),false);
     outtextxy(10,30,1,1,0,1,'LINE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(rl);
           line(random(resx-1),random(resy-1),random(resx-1),random(resy-1),random(255),2);
     until time.stop=1;
     outtextxy(10,30,1,1,0,1,'LINE - '+numstr(rl),false);
     outtextxy(10,40,1,1,0,1,'BAR',false);
     pokazgrafike;
     time.start;
     repeat
           inc(rb);
           bar(random(resx-1),random(resy-1),random(resx-1),random(resy-1),random(255),2);
     until time.stop=1;
     outtextxy(10,40,1,1,0,1,'BAR - '+numstr(rb),false);
     outtextxy(10,50,1,1,0,1,'RECTANGLE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(rr);
           rectangle(random(resx-1),random(resy-1),random(resx-1),random(resy-1),random(255),2);
     until time.stop=1;
     outtextxy(10,50,1,1,0,1,'RECTANGLE - '+numstr(rr),false);
     outtextxy(10,60,1,1,0,1,'ELLIPSE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(re);
           ellipse(random(resx-1),random(resy-1),random(resx-1),random(resy-1),random(255),2);
     until time.stop=1;
     outtextxy(10,60,1,1,0,1,'ELLIPSE - '+numstr(re),false);
     outtextxy(10,70,1,1,0,1,'CIRCLE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(rc);
           circle(random(resx-1),random(resy-1),random(resx-1),random(255),2);
     until time.stop=1;
     outtextxy(10,70,1,1,0,1,'CIRCLE - '+numstr(rc),false);
     {*NORMAL*}
     outtextxy(10,120,1,1,12,1,'NORMAL:',false);
     outtextxy(10,130,1,1,0,1,'PUTPIXEL',false);
     pokazgrafike;
     time.start;
     repeat
           inc(p);
           putpixel(1,1,1,2);
     until time.stop=1;
     outtextxy(10,130,1,1,0,1,'PUTPIXEL - '+numstr(p),false);
     outtextxy(10,140,1,1,0,1,'LINE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(l);
           line(0,0,320,200,10,2);
     until time.stop=1;
     outtextxy(10,140,1,1,0,1,'LINE - '+numstr(l),false);
     outtextxy(10,150,1,1,0,1,'BAR',false);
     pokazgrafike;
     time.start;
     repeat
           inc(b);
           bar(0,0,319,199,1,2);
     until time.stop=1;
     outtextxy(10,150,1,1,0,1,'BAR - '+numstr(b),false);
     outtextxy(10,160,1,1,0,1,'RECTANGLE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(r);
           rectangle(0,0,319,199,1,2);
     until time.stop=1;
     outtextxy(10,160,1,1,0,1,'RECTANGLE - '+numstr(r),false);
     outtextxy(10,170,1,1,0,1,'ELLIPSE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(e);
           ellipse(160,100,100,100,1,2);
     until time.stop=1;
     outtextxy(10,170,1,1,0,1,'ELLIPSE - '+numstr(e),false);
     outtextxy(10,180,1,1,0,1,'CIRCLE',false);
     pokazgrafike;
     time.start;
     repeat
           inc(c);
           circle(160,100,100,1,2);
     until time.stop=1;
     outtextxy(10,180,1,1,0,1,'CIRCLE - '+numstr(c),false);
     outtextxy(230,190,1,1,9,1,'ENTERKEY...',false);
     pokazgrafike;
     enterkey;
     closegraph;
end.