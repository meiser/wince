unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpjson, jsonparser;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form4: TForm4;

implementation


uses unit1;

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  showmessage(ComboBox1.Items[ComboBox1.ItemIndex]);

  showmessage(IntToStr(Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex])));
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  //showmessage(IntToStr(J.Count));
  For I:=0 to J.Count-1 do
              begin

                 //showmessage('Datensatz: '+IntToStr(I));
                 //for N:=0 to J.Items[I].Count-1 do
                 //begin
                    //showmessage(TJSONObject(J.Items[I]).Names[N]+ ' mit '+ TJSONObject(J.Items[I].Items[N]).AsString);
                 //end;

                 ComboBox1.AddItem(TJSONObject(J.Items[I].Items[2]).AsString + '  '+TJSONObject(J.Items[I].Items[0]).AsString, TObject(I+1));

                 //showmessage(TJSONObject(J).Names[I]);
                 //for N:=0 to J.Items[I].Count do
                 //begin
                 //   showmessage(TJSONObject(J.Items[I]).Names[I]);
                 //end;
                 //DumpJSONData(J.Items[I],False);


              end;

end;

{$R *.lfm}

end.

