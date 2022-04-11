unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Progress, Progress.Observer, Vcl.ComCtrls, Vcl.Imaging.GIFImg, Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
begin
   TViewProgress.New()
                .setMaxProgress(100)
                .setOperation(procedure(AProgress: TObserverValue<Integer>; AStatus: TObserverValue<String>)
                              var
                                 i : Integer;
                              begin
                                 for i := 0 to 100 do
                                 begin
                                    AProgress.value := i;
                                    AStatus.value   := IntToStr(i)+'/100';
                                    sleep(10);
                                 end;
                              end)
                .Show;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
   TViewProgress.New()
                .setOperation(procedure(AProgress: TObserverValue<Integer>; AStatus: TObserverValue<String>)
                              begin
                                 AStatus.value := 'Loading error...';
                                 sleep(1000);
                                 raise Exception.Create('Error Message');
                              end)
                .setOnError(procedure (AErrorMessage:String)
                            begin
                               ShowMessage(AErrorMessage);
                            end)
                .Show;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
   TViewProgress.New()
                .setOperation(procedure(AProgress: TObserverValue<Integer>; AStatus: TObserverValue<String>)
                              begin
                                 AStatus.value := 'Loading operation...';
                                 sleep(1000);
                              end)
                .setOnSuccess(procedure
                              begin
                                 ShowMessage('Operation completed');
                              end)
                .Show;
end;

procedure TFormMain.Button4Click(Sender: TObject);
begin
   TViewProgress.New()
                .setMaxProgress(100)
                .setOperation(procedure(AProgress: TObserverValue<Integer>; AStatus: TObserverValue<String>)
                              var
                                 i : Integer;
                              begin
                                 AStatus.value := 'Loading operation...';
                                 for i := 0 to 100 do
                                 begin
                                    AProgress.value := i;
                                    sleep(10);
                                 end;
                              end)
                .setOnError(procedure (AErrorMessage:String)
                            begin
                               ShowMessage(AErrorMessage);
                            end)
                .setOnSuccess(procedure
                              begin
                                 ShowMessage('Operation completed');
                              end)
                .Show;
end;

end.
