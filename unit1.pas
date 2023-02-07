unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  SizeablePanel;

type

  { TForm1 }

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FPnl: TSizeablePanel;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FPnl := TSizeablePanel.Create(Self);

  with FPnl do
  begin
    Parent := Self;
    Left := 10;
    Top := 10;
    Color:= clMoneyGreen;
    Caption := FPnl.ClassName;
    Constraints.MinWidth:= 70;
    Constraints.MinHeight:= 50;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  FPnl.MaxConstrX:= Self.ClientWidth - 50;
  FPnl.MaxConstrY:= Self.ClientHeight - 50;
end;

end.

