unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  INIFiles, fphttpclient, unit2, Unit3;


type

  { TBundleStart }

  ClientConfig = Record
    Username, Password, ServerIP, ServerURL : string;
  end;

  TBundleStart = class(TForm)
    Button1: TButton;
    ButtonExisting: TButton;
    ButtonNext: TButton;
    Label1: TLabel;
    KommHeader1: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure ButtonExistingClick(Sender: TObject);
    procedure ButtonNextClick(Sender: TObject);
    procedure CommissionInputChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  BundleStart: TBundleStart;
  INI: TINIFile;
  Settings: ClientConfig;

implementation

{$R *.lfm}

{ TBundleStart }


procedure TBundleStart.Button1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TBundleStart.ButtonExistingClick(Sender: TObject);
var
  MyForm: TCommissionForm;

begin
  MyForm:= TCommissionForm.create(nil);
  MyForm.showmodal;
end;

procedure TBundleStart.ButtonNextClick(Sender: TObject);
var
  T: TFPHTTPClient;
  MyResult: string;
  MyForm: TScanForm;

begin
  if MessageDlg('Bestätigung', 'Neue Kommission anlegen?', mtConfirmation,
                       [mbYes, mbNo],0) = mrYes
  then
  begin
       try
     begin
          T:= TFPHttpClient.Create(Nil);
          With T  do
               try
                  MyResult:=Post(Settings.ServerURL+'scanner/wa/commission/new');
                  if Length(MyResult) = 5 then
                  begin
                       Commission:=MyResult;
                       MyForm:= TScanForm.create(nil);
                       MyForm.showmodal;
                  end;
               finally
                      Free;
               end;
     end;
     Except
     on E: Exception do
           begin
               showmessage('Server nicht erreichbar');
               ButtonNext.Caption:='NEUE KOMMISSION';
           end;

   end
  end;


end;

procedure TBundleStart.CommissionInputChange(Sender: TObject);
var
  c: integer;
begin
  {Try

    if Length(CommissionInput.Text) > 0 then
    begin
     c:= StrToInt(CommissionInput.Text);

    end;
  except
    On E : EConvertError do
     begin
      showmessage('Nur mumerische Zeichen erlaubt');
      CommissionInput.Text:='';
      CommissionInput.SetFocus;
     end;
  end; }
  //if TBundleStart.Commission.Text;
end;

procedure TBundleStart.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //if '3' <> (IntToHex(Key,16)) then
  //   begin
  //        CommissionInput.Text:='';
  //        CommissionInput.SetFocus;
  //        showmessage('Nur Zahlentasten verwenden');
  //   end;
end;

procedure TBundleStart.Timer1Timer(Sender: TObject);

var

  T: TFPHTTPClient;
  MyResult: string;

begin
     try
     begin
          T:= TFPHttpClient.Create(Nil);
          With T  do
               try
                  MyResult:=Get(Settings.ServerURL+'scanner/wa/commission/last');
                  ButtonNext.Caption:='NEUE KOMMISSION (nach '+MyResult +')';
               finally
                      Free;
               end;

     end;
     Except
     on E: Exception do
           begin
               ButtonNext.Caption:='NEUE KOMMISSION';
           end;

   end

end;


initialization
  INI:= TINIFile.Create(Application.Location+'\config.ini');
  Settings.ServerIP:=INI.ReadString('Server','ServerIP','');
  Settings.Username:=INI.ReadString('Server','Username','');
  Settings.Password:=INI.ReadString('Server','Password','');
  Settings.ServerURL:='http://'+Settings.Username+':'+Settings.Password+'@'+Settings.ServerIP+'/';
end.

