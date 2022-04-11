program CustomProgress;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FormMain},
  Progress.Observer in 'Progress\Progress.Observer.pas',
  Progress in 'Progress\Progress.pas',
  Progress.View in 'Progress\View\Progress.View.pas' {FrmProgressView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
