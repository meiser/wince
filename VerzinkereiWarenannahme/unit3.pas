unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, fphttpclient, unit2;

type

  { TCommissionForm }

  TCommissionForm = class(TForm)
    Button1: TButton;
    ButtonNext: TButton;
    CommissionEdit: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  CommissionForm: TCommissionForm;

implementation

uses unit1;


{$R *.lfm}

{ TCommissionForm }

procedure TCommissionForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  unit1.BundleStart.Timer1.Enabled:=True;
end;

procedure TCommissionForm.FormCreate(Sender: TObject);
begin
  unit1.BundleStart.Timer1.Enabled:=False;
end;

procedure TCommissionForm.ButtonNextClick(Sender: TObject);
var
  MyForm: TScanForm;
  c: integer;
  t: TFPHTTPClient;
  List: TStringList;
  MyResult: string;
  MyTime: TDateTime;

begin
  Try
    c:= StrToInt(CommissionEdit.Text);
    if (Length(CommissionEdit.Text) <> 5) then
     begin
          raise EConvertError.create('');
     end;
    if (c >= 30001) and (c <= 31999) and (c <> 30000) and (c <> 31000) then
     begin
           Commission:= CommissionEdit.Text;

           try
              begin
                        T:= TFPHttpClient.Create(Nil);
                        With T  do
                        try
                           MyResult:=Get(Settings.ServerURL+'scanner/wa/commission/check/'+Commission);

                           if MyResult = 'OK' then
                              begin
                                self.close;
                                MyForm:= TScanForm.create(nil);
                                MyForm.showmodal;
                              end

                           else
                              begin
                                   showmessage(MyResult);
                                   CommissionEdit.Clear;
                              end;

                        finally
                           Free;
                        end;

              end;
           Except
           on E: Exception do
           begin
               showmessage('Verbindungsprobleme. Bitte erneut versuchen');
               CommissionEdit.Text:='';
               CommissionEdit.SetFocus;
           end;
     end;






     end
    else
     begin
          raise EConvertError.create('');
     end;
  except
    On E : EConvertError do
     begin
      showmessage('Kommissionsnummer prüfen');
      CommissionEdit.Text:='';
      CommissionEdit.SetFocus;
     end;
  end;


end;

procedure TCommissionForm.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

