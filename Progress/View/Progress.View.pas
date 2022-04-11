unit Progress.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.Samples.Gauges, Vcl.Imaging.GIFImg;

type
  TFrmProgressView = class(TForm)
    PanelBorder: TPanel;
    PanelBody: TPanel;
    PanelTop: TPanel;
    PanelStatus: TPanel;
    ImageProgress: TImage;
    LabelStatus: TLabel;
    LabelProgress: TLabel;
    Gauge: TGauge;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PanelTopMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
  private
  public
     procedure setMaxProgress(AMaxProgress: Integer);
     procedure setProgress(AProgress: Integer);
     procedure setStatus(AStatus:String);
  end;

var
  FrmProgressView: TFrmProgressView;

implementation

{$R *.dfm}

{ TFrmProcessandoIntegracao }
procedure TFrmProgressView.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Shift =[ssAlt]) and (key = Vk_F4) then
      key := Vk_Clear;
end;

procedure TFrmProgressView.FormShow(Sender: TObject);
begin
   TGIFImage(ImageProgress.Picture.Graphic).Animate := True;
   TGIFImage(ImageProgress.Picture.Graphic).AnimationSpeed:= 80;
end;

procedure TFrmProgressView.PanelTopMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
const
  SC_DRAGMOVE = $F012;
begin
   if Button = mbLeft then
   begin
      ReleaseCapture;
      Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
   end;
end;

procedure TFrmProgressView.setMaxProgress(AMaxProgress: Integer);
begin
   Gauge.MaxValue := AMaxProgress;
   LabelProgress.Visible := AMaxProgress > 0;
end;

procedure TFrmProgressView.setProgress(AProgress: Integer);
begin
   Gauge.Progress := AProgress;
   LabelProgress.Caption := IntToStr(Gauge.PercentDone)+'%';
   Application.ProcessMessages;
end;

procedure TFrmProgressView.setStatus(AStatus: String);
begin
   LabelStatus.Caption := AStatus;
   Application.ProcessMessages;
end;

end.
