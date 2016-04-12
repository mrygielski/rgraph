
{$A+,B-,D+,E+,F-,G+,I+,L+,N-,O-,P-,Q-,R-,S+,T-,V+,X+,Y+}
{$M 65520,0,655360}

{*****************************}
{*   BIBLIOTEKA TP/BP 7.0    *}
{*     stworzona przez       *}
{*   MICHAùA RYGIELSKIEGO    *}
{*         2 0 0 1           *}
{* WSZELKIE ZMIANY ZBRONIONE *}
{*****************************}

Unit RGraph;

Interface

Uses Dos;

Const
      XORDRAW : Boolean = False;
      ResX = 320;
      ResY = 200;
      GetLayer : Byte = 1;
      _Long    : Longint = 1;

Type
    _VEkran = Array[1..200, 1..320] of Byte;
    PalType  = Array [0..255, 1..3] of Byte;
    StrType = (Normal, Hide);
    Stoper =
            Object
                  StH    :Word;
                  StM    :Word;
                  StS    :Word;
                  StHund :Word;
                  Procedure Start;
                  Function Stop : Longint;
            End;

Var
   Ekrany : Array[1..10] of ^_VEkran;

 {******************************** RGRAPH **********************************}

Function InitGraph(Ilosc : Byte) : Integer;
Procedure CloseGraph;
Function MemToStart(IleLayers : Integer) : Integer;
Procedure PokazGrafike;
Procedure HideLayer(L : Byte);
Procedure ShowLayer(L : Byte);
Procedure ClearLayer(L : Byte);
Procedure PutPixel(X, Y : Integer; C, L : Byte);
Function GetPixel(X, Y : Integer; L : Byte) : Byte;
Procedure Line(X1, Y1, X2, Y2 : Integer; C, L  : Byte);
Procedure Bar(X, Y, D, S : Word; C, L  : Byte);
Procedure Rectangle(X, Y, D, S : Word; C, L  : Byte);
Procedure Ellipse(Exc, Eyc, Ea, Eb : Integer; Color, L : Byte);
Procedure Circle(Exc, Eyc, E : Integer; Color, L : Byte);
Procedure WaitRetrace;
Procedure Flood(X, Y : Integer; Col, L : Byte);
Procedure OutTextXY(X, Y : Integer; Scx, Scy : Real; C, L : Byte; Str : String; M : Boolean);
Function FindColInPal(R, G, B : Byte; Pal : PalType) : Byte;
Procedure SetCol(Col : Byte; R, G, B : Byte);
Procedure GetCol(Col : Byte; Var R, G, B : Byte);
Procedure GetPal(Var Pal : PalType);

 {*********************************** INNE *********************************}

Procedure Blur(Xx, Yy, Dd, Ss, Ile : Integer; Shadow : Boolean; L : Byte);
Procedure StrText(Xx, Yy, Ods, Tlo, Kolor, Ile : Integer; Var Tekst : String; W : StrType; L : Byte);
Function Keypressed : Boolean;
Function ReadKey : Char;
Function EnterKey : Boolean;
Function NumStr(Number : Longint) : String;
Function CzyPlikIstnieje(Plik : String) : Boolean;

 {*********************************** MYSZ *********************************}

Function InitMouse : Boolean;
Procedure GetMousePos(Var X, Y, K : Integer);
Procedure SetMousePos(X, Y : Integer);
Procedure MouseWindow(X, Y, D, S : Integer);
Procedure MShow;
Procedure MHide;
Procedure ResetMouse;
Function Mousein(X, Y, X1, Y1, X2, Y2 : Integer) : Boolean;

Implementation

Const
     _Ilosc : Byte = 0;
     _Zadana_Ilosc : Byte = 0;
     DoubleBack : Word = $FFFF;
     Error : Array[1..2] of String[35] = ('LAYER ERROR: FOR MUCH LAYER''S',
                                          'LAYER ERROR: DIVISION BY ZERO');

Var
   _P : Pointer;
   _Visible : Array[0..10] of Boolean;
   IloscWarstw : Byte;

 {******************************** RGRAPH **********************************}

Procedure SetLayer(L : Byte);

Var
   Layer : Byte;

Begin
     If L<1 then
     Begin
          CloseGraph;
          Write(Error[2]);
          Halt;
     End;
     If L>IloscWarstw then
     Begin
          CloseGraph;
          Write(Error[1]);
          Halt;
     End;
     If IloscWarstw=1 then
     Begin
          If L=1 then Layer:=1;
     End;
     If IloscWarstw=2 then
     Begin
          If L=1 then Layer:=2;
          If L=2 then Layer:=1;
     End;
     If IloscWarstw=3 then
     Begin
          If L=1 then Layer:=3;
          If L=2 then Layer:=2;
          If L=3 then Layer:=1;
     End;
     If IloscWarstw=4 then
     Begin
          If L=1 then Layer:=4;
          If L=2 then Layer:=3;
          If L=3 then Layer:=2;
          If L=4 then Layer:=1;
     End;
     If IloscWarstw=5 then
     Begin
          If L=1 then Layer:=5;
          If L=2 then Layer:=4;
          If L=3 then Layer:=3;
          If L=4 then Layer:=2;
          If L=5 then Layer:=1;
     End;
     If IloscWarstw=6 then
     Begin
          If L=1 then Layer:=6;
          If L=2 then Layer:=5;
          If L=3 then Layer:=4;
          If L=4 then Layer:=3;
          If L=5 then Layer:=2;
          If L=6 then Layer:=1;
     End;
     If IloscWarstw=7 then
     Begin
          If L=1 then Layer:=7;
          If L=2 then Layer:=6;
          If L=3 then Layer:=5;
          If L=4 then Layer:=4;
          If L=5 then Layer:=3;
          If L=6 then Layer:=2;
          If L=7 then Layer:=1;
     End;
     If IloscWarstw=8 then
     Begin
          If L=1 then Layer:=8;
          If L=2 then Layer:=7;
          If L=3 then Layer:=6;
          If L=4 then Layer:=5;
          If L=5 then Layer:=4;
          If L=6 then Layer:=3;
          If L=7 then Layer:=2;
          If L=8 then Layer:=1;
     End;
     If IloscWarstw=9 then
     Begin
          If L=1 then Layer:=9;
          If L=2 then Layer:=8;
          If L=3 then Layer:=7;
          If L=4 then Layer:=6;
          If L=5 then Layer:=5;
          If L=6 then Layer:=4;
          If L=7 then Layer:=3;
          If L=8 then Layer:=2;
          If L=9 then Layer:=1;
     End;
     If IloscWarstw=10 then
     Begin
          If L=1 then Layer:=10;
          If L=2 then Layer:=9;
          If L=3 then Layer:=8;
          If L=4 then Layer:=7;
          If L=5 then Layer:=6;
          If L=6 then Layer:=5;
          If L=7 then Layer:=4;
          If L=8 then Layer:=3;
          If L=9 then Layer:=2;
          If L=10 then Layer:=1;
     End;
     GetLayer:=L;
     _P:=Ekrany[L];
End;

Procedure ClearViewPort;

Var
   I : Longint;

Begin
     For I:=1 to $FFFF do Mem[$0A000:I]:=0;
End;

Function InitGraph(Ilosc : Byte) : Integer;

Var
   I : Integer;
   Long : Longint;

Begin
     _Zadana_Ilosc:=Ilosc;
     Long:=1;
     IloscWarstw:=Ilosc;
     If Ilosc<1 then
     Begin
          CloseGraph;
          Write(Error[2]);
          Halt;
     End;
     If Ilosc>10 then InitGraph:=-2 else
     If Ilosc<1 then InitGraph:=-3 else
     If MemAvail<=((Long*Ilosc)*64000 + 32000) then InitGraph:=-1 else
     Begin
          Asm
             Mov Ax,13h
             Int 10h
          End;
          For I:= 1 to Ilosc do
          Begin
               New(Ekrany[I]);
               SetLayer(I);
               ClearLayer(I);
               _Visible[I]:=True;
          End;
          _Ilosc:=Ilosc;
          ClearViewPort;
          SetLayer(1);
     End;
End;

Procedure CloseGraph;

Var
   I : Integer;

Begin
     Asm
        Mov Ax,3h
        Int 10h
     End;
     For I:=1 to _Ilosc do Dispose(Ekrany[I]);
     _Ilosc := 0;
End;

Function MemToStart(IleLayers : Integer) : Integer;
Begin
     If IleLayers=0 then
     MemToStart:=(_Long*64000*_Zadana_Ilosc+32000) div 1024
     else
     MemToStart:=(_Long*64000*IleLayers+32000) div 1024;
End;

Procedure PokazGrafike;

Const
     Long : Longint = 1;

Type
    Half = Array[1..100, 1..320] of Byte;

Var
   I,X,Y : Word;
   Ekran : ^Half;
   Q : byte;
   P : pointer;

Begin
     New(Ekran);
     If Not _Visible[_Ilosc] then
     Asm
        Mov Ax,0FFFFh
        Cld;
        Les Di, Ekran.Dword
        Mov Bx, Di
        Add Bx, 32000
        @Loop:
        Stosw
        Cmp DI, Bx
        Jnz @Loop
     End;
     Y:=_Ilosc;
     For I:=_Ilosc downto 1 do
     If _Visible[I] then
     Begin
          P:=Ekrany[I];
          Asm
             Mov X, 0
             @Loop:
             Les Di, P.Dword
             Add Di, X
             Mov Dh, Es:[Di]
             Mov Ax, Y
             Cmp I, Ax
             Jz @Woda
             Cmp Dh, 255
             Jz @Olej
             @Woda:
             Les Di, Ekran.Dword
             Add Di, X
             Mov Es:[Di], Dh
             @Olej:
             Inc X
             Cmp X, 32000
             Jnz @Loop
          End;
     End;
     Asm
        Push Ds
        Lds Bx, Ekran.Dword
        Mov Di, 0
        Mov Dx, 0A000h
        Mov Es, Dx
        Cld
        @Loop:
        Mov Ax, Word Ptr Ds:[Bx]
        Stosw
        Add Bx, 2
        Cmp Di, 32000
        Jnz @Loop
        Mov Ax, Word Ptr Ds:[Bx]
        Stosw
        Pop Ds
     End;
     If Not _Visible[_Ilosc] then
     Asm
        Mov Ax, 0FFFFh
        Cld;
        Les Di, Ekran.Dword
        Mov Bx, Di
        Add Bx, 32000
        @Loop:
        Stosw
        Cmp DI, Bx
        Jnz @Loop
     End;
     For I:=_Ilosc downto 1 do
     If _Visible[I] then
     Begin
          P:=Ekrany[I];
          Asm
             Mov X,0
             @Petla:
             Les Di, P.Dword
             Add Di, X
             Add Di, 32000
             Mov Dh, Es:[Di]
             Mov Ax, Y
             Cmp I, Ax
             Jz @Woda
             Cmp Dh, 255
             Jz @Olej
             @Woda:
             Les Di, Ekran.Dword
             Add Di, X
             Mov Es:[Di], Dh
             @Olej:
             Inc X
             Cmp X, 32000
             Jnz @Petla
          End;
     End;
     Asm
        Push Ds
        Lds Bx, Ekran.Dword
        Mov Di, 32000
        Mov Dx, 0A000h
        Mov Es, Dx
        Cld
        @Loop:
        Mov Ax, Word Ptr Ds:[Bx]
        Stosw
        Add Bx, 2
        Cmp Di, 64000
        Jnz @Loop
        Mov Ax, Word Ptr Ds:[Bx]
        Stosw
        Pop Ds
     End;
     Dispose(Ekran);
End;

Procedure HideLayer(L : Byte);

Var
   Layer : Byte;

Begin
     If L<1 then
     Begin
          CloseGraph;
          Write(Error[2]);
          Halt;
     End;
     If L>IloscWarstw then
     Begin
          CloseGraph;
          Write(Error[1]);
          Halt;
     End;
     If IloscWarstw=1 then
     Begin
          If L=1 then Layer:=1;
     End;
     If IloscWarstw=2 then
     Begin
          If L=1 then Layer:=2;
          If L=2 then Layer:=1;
     End;
     If IloscWarstw=3 then
     Begin
          If L=1 then Layer:=3;
          If L=2 then Layer:=2;
          If L=3 then Layer:=1;
     End;
     If IloscWarstw=4 then
     Begin
          If L=1 then Layer:=4;
          If L=2 then Layer:=3;
          If L=3 then Layer:=2;
          If L=4 then Layer:=1;
     End;
     If IloscWarstw=5 then
     Begin
          If L=1 then Layer:=5;
          If L=2 then Layer:=4;
          If L=3 then Layer:=3;
          If L=4 then Layer:=2;
          If L=5 then Layer:=1;
     End;
     If IloscWarstw=6 then
     Begin
          If L=1 then Layer:=6;
          If L=2 then Layer:=5;
          If L=3 then Layer:=4;
          If L=4 then Layer:=3;
          If L=5 then Layer:=2;
          If L=6 then Layer:=1;
     End;
     If IloscWarstw=7 then
     Begin
          If L=1 then Layer:=7;
          If L=2 then Layer:=6;
          If L=3 then Layer:=5;
          If L=4 then Layer:=4;
          If L=5 then Layer:=3;
          If L=6 then Layer:=2;
          If L=7 then Layer:=1;
     End;
     If IloscWarstw=8 then
     Begin
          If L=1 then Layer:=8;
          If L=2 then Layer:=7;
          If L=3 then Layer:=6;
          If L=4 then Layer:=5;
          If L=5 then Layer:=4;
          If L=6 then Layer:=3;
          If L=7 then Layer:=2;
          If L=8 then Layer:=1;
     End;
     If IloscWarstw=9 then
     Begin
          If L=1 then Layer:=9;
          If L=2 then Layer:=8;
          If L=3 then Layer:=7;
          If L=4 then Layer:=6;
          If L=5 then Layer:=5;
          If L=6 then Layer:=4;
          If L=7 then Layer:=3;
          If L=8 then Layer:=2;
          If L=9 then Layer:=1;
     End;
     If IloscWarstw=10 then
     Begin
          If L=1 then Layer:=10;
          If L=2 then Layer:=9;
          If L=3 then Layer:=8;
          If L=4 then Layer:=7;
          If L=5 then Layer:=6;
          If L=6 then Layer:=5;
          If L=7 then Layer:=4;
          If L=8 then Layer:=3;
          If L=9 then Layer:=2;
          If L=10 then Layer:=1;
     End;
  _Visible[L]:=False;
End;

Procedure ShowLayer(L : Byte);

Var
   Layer : Byte;
Begin
     If L<1 then
     Begin
          CloseGraph;
          Write(Error[2]);
          Halt;
     End;
     If L>IloscWarstw then
     Begin
          CloseGraph;
          Write(Error[1]);
          Halt;
     End;
     If IloscWarstw=1 then
     Begin
          If L=1 then Layer:=1;
     End;
     If IloscWarstw=2 then
     Begin
          If L=1 then Layer:=2;
          If L=2 then Layer:=1;
     End;
     If IloscWarstw=3 then
     Begin
          If L=1 then Layer:=3;
          If L=2 then Layer:=2;
          If L=3 then Layer:=1;
     End;
     If IloscWarstw=4 then
     Begin
          If L=1 then Layer:=4;
          If L=2 then Layer:=3;
          If L=3 then Layer:=2;
          If L=4 then Layer:=1;
     End;
     If IloscWarstw=5 then
     Begin
          If L=1 then Layer:=5;
          If L=2 then Layer:=4;
          If L=3 then Layer:=3;
          If L=4 then Layer:=2;
          If L=5 then Layer:=1;
     End;
     If IloscWarstw=6 then
     Begin
          If L=1 then Layer:=6;
          If L=2 then Layer:=5;
          If L=3 then Layer:=4;
          If L=4 then Layer:=3;
          If L=5 then Layer:=2;
          If L=6 then Layer:=1;
     End;
     If IloscWarstw=7 then
     Begin
          If L=1 then Layer:=7;
          If L=2 then Layer:=6;
          If L=3 then Layer:=5;
          If L=4 then Layer:=4;
          If L=5 then Layer:=3;
          If L=6 then Layer:=2;
          If L=7 then Layer:=1;
     End;
     If IloscWarstw=8 then
     Begin
          If L=1 then Layer:=8;
          If L=2 then Layer:=7;
          If L=3 then Layer:=6;
          If L=4 then Layer:=5;
          If L=5 then Layer:=4;
          If L=6 then Layer:=3;
          If L=7 then Layer:=2;
          If L=8 then Layer:=1;
     End;
     If IloscWarstw=9 then
     Begin
          If L=1 then Layer:=9;
          If L=2 then Layer:=8;
          If L=3 then Layer:=7;
          If L=4 then Layer:=6;
          If L=5 then Layer:=5;
          If L=6 then Layer:=4;
          If L=7 then Layer:=3;
          If L=8 then Layer:=2;
          If L=9 then Layer:=1;
     End;
     If IloscWarstw=10 then
     Begin
          If L=1 then Layer:=10;
          If L=2 then Layer:=9;
          If L=3 then Layer:=8;
          If L=4 then Layer:=7;
          If L=5 then Layer:=6;
          If L=6 then Layer:=5;
          If L=7 then Layer:=4;
          If L=8 then Layer:=3;
          If L=9 then Layer:=2;
          If L=10 then Layer:=1;
     End;
     _Visible[L]:=True;
End;

Function Valid(X, Y : integer) : Boolean;
Begin
     If (X<=320) and (X>0) and (Y>0) and (Y<=200) then Valid:=True else Valid:=False;
End;

Procedure ClearLayer(L : Byte);
Begin
     SetLayer(L);
     Asm
        Mov Ax,DoubleBack
        Cld;
        Les Di,_P.Dword
        Mov Bx,Di
        Add Bx,64000
        @Loop:
        Stosw
        Cmp Di,Bx
        Jnz @Loop
     End;
End;

Procedure PutPixel(X, Y : Integer; C, L : Byte);
Begin
     SetLayer(L);
     If XORDRAW then
     C:=GetPixel(X, Y, L) xor C;
     If Valid(X,Y) then
     Asm
        Dec X
        Dec Y
        Mov Ax, 320
        Mul Y
        Add Ax, X
        Les Di, _P.Dword
        Add Di, Ax
        Mov Al, C
        Mov Es:[Di], Al
     End;
End;

Function GetPixel(X, Y : Integer; L : Byte) : Byte;
Begin
     SetLayer(L);
     If Valid(X,Y) then
     Asm
        Dec X
        Dec Y
        Mov Ax, 320
        Mul Y
        Add Ax, X
        Les Di, _P.Dword
        Add Di, Ax
        Mov Ah, Es:[Di]
        Mov @Result, Ah
     End
     Else
     GetPixel:=255;
end;

Procedure Line(X1, Y1, X2, Y2 : Integer; C, L : Byte);

Function Sgn(X : Integer) : Integer;
Begin
     Sgn:=0;
     If x<0 Then Sgn:=-1  Else If x>0 Then Sgn:=1;
End;

Var
   Licznik, Xs, Ys, KierunekX, KierunekY : Integer;

Begin
     Xs:=X2-X1;
     Ys:=Y2-Y1;
     KierunekX:=Sgn(Xs);
     KierunekY:=Sgn(Ys);
     Xs:=Abs(Xs);
     Ys:=Abs(Ys);
     PutPixel(X1,Y1,C,L);
     If Xs>Ys Then
     Begin
          Licznik:=-(Xs div 2);
          While (X1 <> X2 ) do
          Begin
               Inc(Licznik,Ys);
               Inc(X1,KierunekX);
               IF Licznik>0 Then
               Begin
                    Inc(Y1,KierunekY);
                    Dec(Licznik,Xs);
               End;
               PutPixel(X1,Y1,C,L);
          End;
     End
     Else
         Begin
              Licznik:=-(Ys div 2);
              while (y1 <> y2 ) do
              Begin
                   Inc(Licznik,Xs);
                   Inc(Y1,KierunekY);
                   If Licznik>0 Then Begin
                   X1:=X1+KierunekX;
                   Dec(Licznik,Ys);
              End;
              PutPixel(X1,Y1,C,L);
         End;
     End;
End;

Procedure Bar(X, Y, D, S : Word; C, L : Byte);

Var
   Xx, Yy : Word;

Begin
     For Xx:= X to D do
     For Yy:= Y to S do
     Begin
          PutPixel(Xx,Yy,C,L);
     End;
End;

Procedure Rectangle(X, Y, D, S : Word; C, L : Byte);
Begin
     SetLayer(L);
     Line(X,Y,D,Y,C,L);
     Line(X,S,D,S,C,L);
     Line(X,Y,X,S,C,L);
     Line(D,Y,D,S,C,L);
End;

Procedure Ellipse(Exc, Eyc, Ea, Eb : Integer; Color, L : Byte);

Var
  elx, ely : Integer;
  aa, aa2, bb, bb2, d, dx, dy : LongInt;

BEGIN
  elx := 0; ely := eb; aa := LongInt(ea) * ea; aa2 := 2 * aa;
  bb := LongInt(eb) * eb; bb2 := 2 * bb;
  d := bb - aa * eb + aa DIV 4; dx := 0; dy := aa2 * eb;
  PutPixel(exc, eyc - ely, Color,L); PutPixel(exc, eyc + ely, Color,L);
  PutPixel(exc - ea, eyc, Color,L); PutPixel(exc + ea, eyc, Color,L);
  WHILE (dx < dy) DO BEGIN
    IF (d > 0) THEN BEGIN Dec(ely); Dec(dy, aa2); Dec(d, dy); END;
    Inc(elx); Inc(dx, bb2); Inc(d, bb + dx);
    PutPixel(exc + elx, eyc + ely, Color,L);
    PutPixel(exc - elx, eyc + ely, Color,L);
    PutPixel(exc + elx, eyc - ely, Color,L);
    PutPixel(exc - elx, eyc - ely, Color,L);
  END;
  Inc(d, (3 * (aa - bb) DIV 2 - (dx + dy)) DIV 2);
  WHILE (ely > 0) DO BEGIN
    IF (d < 0) THEN BEGIN Inc(elx); Inc(dx, bb2); Inc(d, bb + dx); END;
    Dec(ely); Dec(dy, aa2); Inc(d, aa - dy);
    PutPixel(exc + elx, eyc + ely, Color,L);
    PutPixel(exc - elx, eyc + ely, Color,L);
    PutPixel(exc + elx, eyc - ely, Color,L);
    PutPixel(exc - elx, eyc - ely, Color,L);
  END;
END;

Procedure Circle(Exc, Eyc, E : Integer; Color, L : Byte);
Begin
     Ellipse(exc,eyc,e,e,color,L);
End;

Procedure WaitRetrace; Assembler;
Asm
   Mov Dx, 3DAh
@L1:
  In  Al, Dx
  And Al, 08h
  Jnz @L1
@L2:
  In  Al, DX
  And Al, 08h
  Jz  @L2
End;

Var
   Fc, Fbak : Byte;
   Kolejka : Array [0..3000] of Record X,Y : Integer; End;
   Ilosc, Kolpos : Integer;

Procedure Usun(Pos : Integer);
Begin
     Kolejka[Pos]:=Kolejka[Ilosc];
     Dec(Ilosc);
End;

Procedure Dodaj(X, Y : Integer);
Var
   I : Integer;
   Bylo : Boolean;

Begin
     Bylo:=False;
     If Ilosc>0 then
     For I:= 1 to Ilosc do
     Begin
          If (Kolejka[I].X=X) and (Kolejka[I].Y=Y) then Bylo:=True;
     End;
     If Not Bylo then
     Begin
          Inc(Ilosc);
          Kolejka[Ilosc].X:=X;
          Kolejka[Ilosc].Y:=Y;
     End;
End;

Procedure Ffill(L : Byte);

Var
   X, Y : Integer;

Begin
     X:=Kolejka[Kolpos].X;
     Y:=Kolejka[Kolpos].Y;
     PutPixel(X,Y,Fc,L);
     Usun(Kolpos);
     If (x>1) and (y>0) and (x<resx) and (y<resy) then
     Begin
          If GetPixel(X+1,Y,L)=Fbak then Dodaj(X+1,Y);
          If GetPixel(X,Y-1,L)=Fbak then Dodaj(X,Y-1);
          If GetPixel(X,Y+1,L)=Fbak then Dodaj(X,Y+1);
          If GetPixel(X-1,Y,L)=Fbak then Dodaj(X-1,Y);
     End;
End;

Procedure Flood(X, Y : Integer; Col, L : Byte);

Var
   I : Integer;
   A, B : Integer;

Begin
     Fbak:=GetPixel(X,Y,L);
     Fc:=Col;
     Kolejka[1].X:=X;
     Kolejka[1].Y:=Y;
     Ilosc:=1;
     Kolpos:=1;
     Repeat
           Kolpos:=(Round(Kolpos*5.2) + 113) mod Ilosc +1;
           Ffill(L);
     Until (Ilosc=0) or (Ilosc=12999);
End;

Procedure OutTextXY(X, Y : Integer; Scx, Scy : Real; C, L : Byte; Str : String; M : Boolean);

Var
  StrPos : Byte;
  FontChr : Byte;
  FontPos : Byte;
  BitPos : Byte;

Begin
     If M=False then
     Begin
          For StrPos:= 1 to Length(Str) do
          For FontPos:= 0 to 7 do
          Begin
               FontChr:=Mem[$FFA6:$E+(Ord(Str[StrPos]) shl 3)+FontPos];
               For BitPos:= 7 downto 0 do
               If (FontChr and (1 shl BitPos)) <> 0 then
               PutPixel(Round(x+(StrPos*(8*ScX))+(ScX*(8-BitPos))-8),Round(Y+(ScY*FontPos)),C,L);
          End;
     End;
     If M=True then
     Begin
          For StrPos:= 1 to Length(Str) do
          For FontPos:= 0 to 7 do
          Begin
               FontChr:=Mem[$FFA6:$E+(Ord(Str[StrPos]) shl 3)+FontPos];
               For BitPos:= 7 downto 0 do
               If (FontChr and (1 shl BitPos)) <> 0 then
               PutPixel(Round(x+(StrPos*(8*ScX))+(ScX*(BitPos))-8),Round(Y+(ScY*FontPos)),C,L);
          End;
     End;
End;

Function FindColInPal(R, G, B : Byte; Pal : PalType) : Byte;

Var
   X, L, I : Integer;

Begin
     X:=3*255+1;
     For I:=0 to 255 do
     Begin
          L:=Abs(Integer(B)-Pal[I,3])+
          Abs(Integer(G)-Pal[I,2])+
          Abs(Integer(R)-Pal[I,1]);
          If L<X then
          Begin
               FindColinPal:=I;
               X:=L;
          End;
     End;
End;
Procedure SetCol(Col : Byte; R, G, B : Byte);
Begin
     Port[$3C8] := Col;
     Port[$3C9] := R;
     Port[$3C9] := G;
     Port[$3C9] := B;
End;

Procedure GetCol(Col : Byte; Var R, G, B : Byte);
Begin
     Port[$3C7] := Col;
     R := Port[$3C9];
     G := Port[$3C9];
     B := Port[$3C9];
End;
Procedure GetPal(Var Pal : PalType);

Var
   X, R, G, B : Byte;

Begin
     For X:= 0 to 255 do
     Begin
          GetCol(X,R,G,B);
          Pal[X,1]:=R;
          Pal[X,2]:=G;
          Pal[X,3]:=B;
     End;
End;

 {*********************************** INNE *********************************}

Procedure Blur(Xx, Yy, Dd, Ss, Ile : Integer; Shadow : Boolean; L : Byte);

Type
    TCol =
          Record
                R, G, B : Byte;
          End;

Var
   ResX, ResY : Integer;
   X, Y : Integer;
   Pal : PalType;
   A, B, C, D, E, F, G, H, I : TCol;
   Pix : Integer;
   Rr, Gg, Bb : Byte;

Begin
     A.R:=0; B.R:=0; C.R:=0;
     A.G:=0; B.G:=0; C.G:=0;
     A.B:=0; B.B:=0; C.B:=0;
     D.R:=0; E.R:=0; F.R:=0;
     D.G:=0; E.G:=0; F.G:=0;
     D.B:=0; E.B:=0; F.B:=0;
     G.R:=0; H.R:=0; I.R:=0;
     G.G:=0; H.G:=0; I.G:=0;
     G.B:=0; H.B:=0; I.B:=0;
     GetPal(Pal);
     ResX:=320;
     ResY:=200;
     If Shadow=True Then
     Begin
          Rr:=1;
          Gg:=1;
          Bb:=1;
     End;
     If Shadow=False Then
     Begin
          Rr:=1;
          Gg:=2;
          Bb:=3;
     End;
     For Y:=Yy to Ss do
     Begin
          X:=Xx;
          Repeat
                A:=B; B:=C;
                Pix:=GetPixel(X+1,Y-1,L);
                C.R:=Pal[Pix,Rr];
                C.G:=Pal[Pix,Gg];
                C.B:=Pal[Pix,Bb];
                D:=E; E:=F;
                Pix:=GetPixel(X+1,Y,L);
                F.R:=Pal[Pix,Rr];
                F.G:=Pal[Pix,Gg];
                F.B:=Pal[Pix,Bb];
                G:=H; H:=I;
                Pix:=GetPixel(X+1,Y+1,L);
                I.R:=Pal[Pix,Rr];
                I.G:=Pal[Pix,Gg];
                I.B:=Pal[Pix,Bb];
                Pix:=FindColInPal(
                ((A.R+B.R+C.R+D.R+E.R+F.R+G.R+H.R+I.R) div Ile),
                ((A.G+B.G+C.G+D.G+E.G+F.G+G.G+H.G+I.G) div Ile),
                ((A.B+B.B+C.B+D.B+E.B+F.B+G.B+H.B+I.B) div Ile),Pal);
                PutPixel(X,Y,Pix,L);
                Inc(X);
          Until X>=Dd;
     End;
End;

Procedure StrText(Xx, Yy, Ods, Tlo, Kolor, Ile : Integer; Var Tekst : String; W : StrType; L : Byte);

Var
   X, Y, T : Integer;
   Z : Char;

Begin
     If W=Normal then
     Begin
          X:=Xx;
          Y:=Yy;
          Tekst:='';
          For T:=1 to Ile+1 do
          begin
               If T=Ile+1 then
               begin
                    repeat
                          Z:=ReadKey;
                    Until (Ord(Z)=8) or (Z=#13);
               end else Z:=ReadKey;
               If (Z=#8) and (Tekst<>'') then
               begin
                    Bar(X-1-Ods+1,Y,X-1-Ods+8,Y+7,Tlo,L);
                    X:=X-Ods;
                    T:=T-1;
                    Delete(Tekst,T,1);
                    PokazGrafike;
               end;
               If Ord(Z) in [32..128] then
               begin
                    OutTextXY(X,Y,1,1,Kolor,L,Z,False);
                    X:=X+Ods;
                    Tekst:=Tekst+Z;
                    PokazGrafike;
               end
               else
               T:=T-1;
               If Z=#13 then T:=Ile+1;
          End;
     End;
     If W=Hide then
     Begin
          X:=Xx;
          Y:=Yy;
          Tekst:='';
          For T:=1 to Ile+1 do
          begin
               If T=Ile+1 then
               begin
                    repeat
                          Z:=ReadKey;
                    Until (Ord(Z)=8) or (Z=#13);
               end else Z:=ReadKey;
               If (Z=#8) and (Tekst<>'') then
               begin
                    Bar(X-1-Ods+10,Y,X-1-Ods+17,Y+7,Tlo,L);
                    X:=X-Ods;
                    T:=T-1;
                    Delete(Tekst,T,1);
                    PokazGrafike;
               end;
               If Ord(Z) in [32..128] then
               begin
                    OutTextXY(X,Y,1,1,Kolor,L,'*',False);
                    X:=X+Ods;
                    Tekst:=Tekst+Z;
                    PokazGrafike;
               end
               else
               T:=T-1;
               If Z=#13 then T:=Ile+1;
          End;
     End;
End;

Function Keypressed : Boolean; Assembler;
Asm
   Mov Ah, 01h
   Int 16h
   Jnz @Ok
   Mov Ax, 0
   Jmp @Fini
   @Ok:
   Mov Ax, 1
   @Fini:
End;

Function ReadKey : Char; Assembler;
Asm
   Mov Ah, 00h
   Int 16h
End;

Function EnterKey : Boolean;

Var
   Key : Char;

Begin
     Repeat
           Key:=ReadKey;
     Until Key=#13;
End;

Procedure Stoper.Start;
Begin
     GetTime(StH, StM, StS, StHund);
End;

Function Stoper.Stop : Longint;

Var
   H, M, S, Hund : Word;

Begin
     GetTime(H, M, S, Hund);
     Stop:=((H-StH)*60*60)+((M-StM)*60)+((S-StS));
End;

Function NumStr(Number : Longint) : String;

Var
   Tekst : String;

Begin
     Str(Number,Tekst);
     NumStr:=Tekst;
End;

Function CzyPlikIstnieje(Plik : String) : Boolean;

Var
   F : File of Byte;

Begin
     {$I-}
     Assign(F,Plik);
     Reset(F);
     Close(F);
     {$I+}
     CzyPlikIstnieje:=IOResult=0;
End;

 {*********************************** MYSZ *********************************}

Function InitMouse : Boolean; Assembler;
Asm
   Xor Ax, Ax
   Int $33
   Not Ax
   Xor Ax, 1
   And Ax, 1
End;

Procedure GetMousePos(Var X, Y, K : Integer);

Var
   R : Registers;

Begin
     R.Ax:=$0003;
     Intr($33,R);
     X:=R.Cx;
     Y:=R.Dx;
     K:=R.Bx;
End;

Procedure SetMousePos(X, Y : Integer); Assembler;
Asm
   Mov Ax, $0004
   Mov Cx, X
   Mov Dx, Y
   Int $33
End;

Procedure MouseWindow(X, Y, D, S : Integer);

Var
   R : Registers;

Begin
     R.Ax:=$0007;
     R.Cx:=X;
     R.Dx:=D;
     Intr($33,R);
     R.Ax:=$0008;
     R.Cx:=Y;
     R.Dx:=S;
     Intr($33,r);
End;

Procedure MShow;

Var
   R : Registers;

Begin
     R.Ax:=$0001;
     Intr($33,R);
End;

Procedure MHide;

Var
   R : Registers;

Begin
     R.Ax:=$0002;
     Intr($33,R);
End;

Procedure ResetMouse;
Begin
     MShow;
     MHide;
End;

Function Mousein(X, Y, X1, Y1, X2, Y2 : Integer) : Boolean;
Begin
     Mousein:=False;
     If (X>X1-1) and (X<X2+1) and (Y>Y1-1) and (Y<Y2+1) then
     Mousein:=True;
End;

End.