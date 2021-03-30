unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, ExtCtrls;

type TPoint = record
     x, y: integer;
end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1StartTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
    procedure Initialiser;
    procedure Marcher;
    function RandomLoc: TPoint;
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  dimension, pas: integer;
  Ivrogne: TPoint;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Initialiser;
var
  Point: TPoint;
  i: integer;
begin
     dimension := StrToInt(Edit1.Text);
     pas := 0;
     Edit3.Text := '0';
     StringGrid1.Clean;

     StringGrid1.ColCount := dimension;
     StringGrid1.RowCount := dimension;

     Point := RandomLoc;
     StringGrid1.Cells[Point.x, Point.y] := 'O';

     Ivrogne := RandomLoc;
     StringGrid1.Cells[Ivrogne.x, Ivrogne.y] := 'J';

     Edit4.Text := IntToStr(abs(Ivrogne.x-Point.x)+abs(Ivrogne.y-Point.y));

     for i := 1 to StrToInt(Edit2.Text) do
     begin
          Point := RandomLoc;
          StringGrid1.Cells[Point.x, Point.y] := 'N';
     end;

end;

procedure TForm1.Marcher;
var
  Point: TPoint;
  Direction: integer;
begin
     inc(Pas);
     Edit3.Text := IntToStr(Pas);
     StringGrid1.Cells[Ivrogne.x, Ivrogne.y] := '';
     Point := Ivrogne;

     while (Ivrogne.x = Point.x) and (Ivrogne.y = Point.y) do
     begin
          Direction := Random(4);
          if (Direction = 0) and (Ivrogne.y <> 0) then
          dec(Ivrogne.y)
          else if (Direction = 1) and (Ivrogne.x <> Dimension-1) then
          inc(Ivrogne.x)
          else if (Direction = 2) and (Ivrogne.y <> Dimension-1) then
          inc(Ivrogne.y)
          else if (Direction = 3) and (Ivrogne.x <> 0) then
          dec(Ivrogne.x)
          else Ivrogne := Point;

          if StringGrid1.Cells[Ivrogne.x,Ivrogne.y] = 'N' then Ivrogne := Point
     end;

     if StringGrid1.Cells[Ivrogne.x, Ivrogne.y] = 'O' then
     begin
          Timer1.Enabled := FALSE;
          StringGrid1.Cells[Ivrogne.x, Ivrogne.y] := 'J';
          Edit4.Text := IntToStr(abs(Ivrogne.x-Point.x)+abs(Ivrogne.y-Point.y));
          ShowMessage('L''ivrogne a rejoint sa maison apres ' + IntToStr(Pas) + ' pas.');
     end;
     StringGrid1.Cells[Ivrogne.x, Ivrogne.y] := 'J';
     Edit4.Text := IntToStr(abs(Ivrogne.x-Point.x)+abs(Ivrogne.y-Point.y));
end;

function TForm1.RandomLoc: TPoint;
var
  Point: TPoint;
  x, y: integer;
begin
     x := Random(dimension);
     y := Random(dimension);
     while StringGrid1.Cells[x,y] <> '' do
     begin
          x := Random(dimension);
          y := Random(dimension);
     end;
     Point.x := x;
     Point.y := y;
     Result := Point;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Randomize;
     Initialiser;
end;

procedure TForm1.Timer1StartTimer(Sender: TObject);
begin
     Marcher;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     Marcher;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     Initialiser;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
     Marcher;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     Timer1.Enabled := not Timer1.Enabled;
end;

end.
