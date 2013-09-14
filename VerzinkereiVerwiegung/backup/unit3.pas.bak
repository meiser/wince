unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;

implementation

uses unit1;

{$R *.lfm}

{ TForm3 }




procedure TForm3.Button1Click(Sender: TObject);

var

TaraConv: integer;

begin

  try
    TaraConv := StrToInt(Edit1.Text);
    w.tara:= IntToStr(TaraConv);
    Close;
  except
    on Exception : EConvertError do
    begin
       Edit1.Clear;
       Edit1.SetFocus;
       showMessage('Bitte Eingabe überprüfen');
    end;
  end;

end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form1.ButtonTara.Caption:='Tara: '+w.tara+'kg';
end;

end.

