unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation

uses unit1;

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
  if Length(Edit1.Text) = 0 then
  begin
       showmessage('Personalkennung darf nicht leer sein');
       Edit1.Clear;
       Edit1.SetFocus;
  end
  else
  begin
       w.pid:= Edit1.Text;
       Form1.ButtonPID.Caption:= 'Personalkennung: '+w.pid;
       Close;
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
end;

{$R *.lfm}

end.

