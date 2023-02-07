unit SizeablePanel;

////////////////////////////////////////////////////////////////////////////////////////////
//                 Author Kazantsev Alexey ©                                              //
//                 Modified by Док aka zoltanleo                                          //
//     http://www.sql.ru/forum/actualutils.aspx?action=gotomsg&tid=1276014&msg=20931114   //
//     Nov, 8, 2017                                                                       //
////////////////////////////////////////////////////////////////////////////////////////////


interface

uses
 SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls, LclType, LCLIntf;

type

  { TSizeablePanel }

  TSizeablePanel = class(TPanel)
  private
    Fdx: Integer;//Distance from right boundary of a component to X
    Fdy: Integer;//Distance from lower boundary of a component to Y
    FMaxConstrX: Integer;//maximum value X
    FMaxConstrY: Integer;//maximum value Y
    FResize : boolean;
    procedure SetMaxConstrX(AValue: Integer);
    procedure SetMaxConstrY(AValue: Integer);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift:
      TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(TheOwner: TComponent); override;
    property MaxConstrX: Integer read FMaxConstrX write SetMaxConstrX default 200;
    property MaxConstrY: Integer read FMaxConstrY write SetMaxConstrY default 100;
  end;


implementation

const
 sizeGripSize = 12;

procedure TSizeablePanel.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Fdx:= Self.ClientWidth - X;
  Fdy:= Self.ClientHeight - Y;

  FResize:= (Fdx < sizeGripSize) and (Fdy < sizeGripSize);
end;

procedure TSizeablePanel.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  Self.DisableAutoSizing;

  if (GetCaptureControl = Self) and FResize then
    begin
      if (X >= MaxConstrX) and (Y >= MaxConstrY)
        then Self.SetBounds(Self.Left, Self.Top, MaxConstrX, MaxConstrY)
        else if (X >= MaxConstrX)
          then Self.SetBounds(Self.Left, Self.Top, MaxConstrX, y + Fdy)
          else if (Y >= MaxConstrY)
            then Self.SetBounds(Self.Left, Self.Top, x + Fdx, MaxConstrY)
            else Self.SetBounds(Self.Left, Self.Top, x + Fdx, y + Fdy);
    end;

  Self.EnableAutoSizing;

  if (x > Self.ClientWidth - sizeGripSize) and (y > Self.ClientHeight - sizeGripSize)
  then
    Self.Cursor := crSizeNWSE
  else
    Self.Cursor:= crDefault;
end;

procedure TSizeablePanel.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
end;

constructor TSizeablePanel.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  MaxConstrX:= 200;
  MaxConstrY:= 100;

  Width:= 200;
  Height:= 100;

  Constraints.MinWidth:= 50;
  Constraints.MinHeight:= 30;
end;

procedure TSizeablePanel.SetMaxConstrX(AValue: Integer);
begin
  if FMaxConstrX = AValue then Exit;
  FMaxConstrX:= AValue;
end;

procedure TSizeablePanel.SetMaxConstrY(AValue: Integer);
begin
  if FMaxConstrY = AValue then Exit;
  FMaxConstrY:= AValue;
end;

procedure TSizeablePanel.Paint;
var
  EdgeMarg: Integer;
begin
  inherited Paint;
  with Canvas do
  begin
    Pen.Style:= psSolid;
    Pen.Width:= 1;
    Pen.Color:= clGray;
    EdgeMarg:= 3;
    MoveTo(Self.ClientWidth - 5,Self.ClientHeight - EdgeMarg);
    LineTo(Self.ClientWidth - EdgeMarg,Self.ClientHeight - 5);
    MoveTo(Self.ClientWidth - 8,Self.ClientHeight - EdgeMarg);
    LineTo(Self.ClientWidth - EdgeMarg,Self.ClientHeight - 8);
    MoveTo(Self.ClientWidth - 11,Self.ClientHeight - EdgeMarg);
    LineTo(Self.ClientWidth - EdgeMarg,Self.ClientHeight - 11);
  end;
end;

end.
