unit Progress;

interface

uses
   Winapi.Windows, Winapi.Messages, System.Threading, System.SysUtils, System.Classes,
   Progress.View, Progress.Observer;

type
   {

   TViewProgress.New()
                .SetImageHeader()
                .SetImageProgress() ou
                .SetAnimationProgress()
                .SetOperation(ADownloadArquivos:TProc)
                .Show;

                function downloadArquivos(AProgress: Tproc<Long>; AOnException : TProc<String>)
                begin
                   while do
                   begin
                      AProgress()
                   end;
                end;  }
   IViewProgress = interface
      ['{5D33F4CE-445D-49B7-9966-16969D995041}']
      function setMaxProgress(AMaxProgress: Integer):IViewProgress;
      function setOnSuccess(AOnSuccess:TProc): IViewProgress;
      function setOnError(AOnError:TProc<String>): IViewProgress;
      function setOperation(AOperation: TProc<TObserverValue<Integer>,TObserverValue<String>>): IViewProgress;
      procedure show();
   end;

   TViewProgress = class(TInterfacedObject,IViewProgress)
   private
      FrmProgress : TFrmProgressView;
      FProgress : TObserverValue<Integer>;
      FStatus   : TObserverValue<String>;
      FOperation: TProc<TObserverValue<Integer>,TObserverValue<String>>;
      FOnSuccess : TProc;
      FOnError  : TProc<String>;
      procedure onTerminatedThread(sender: TObject);
   public
      constructor create;
      destructor Destroy; override;
      class function new:IViewProgress;
      function setMaxProgress(AMaxProgress: Integer):IViewProgress;
      function setOnSuccess(AOnSuccess:TProc): IViewProgress;
      function setOnError(AOnError:TProc<String>): IViewProgress;
      function setOperation(AOperation: TProc<TObserverValue<Integer>,TObserverValue<String>>): IViewProgress;
      procedure show();
   end;

implementation

{ TViewProgress }

constructor TViewProgress.create;
begin
   FrmProgress := TFrmProgressView.Create(nil);
   FProgress := TObserverValue<Integer>.Create(0);
   FProgress.onChange := procedure (AValue: Integer)
                         begin
                            FrmProgress.setProgress(AValue);
                         end;


   FStatus := TObserverValue<String>.Create('');
   FStatus.onChange := procedure (AValue: String)
                       begin
                          FrmProgress.setStatus(AValue);
                       end;
end;

destructor TViewProgress.Destroy;
begin
   FrmProgress.Free;
   FProgress.Free;
   FStatus.Free;
   inherited;
end;

class function TViewProgress.new: IViewProgress;
begin
   Result := Create;
end;

function TViewProgress.setMaxProgress(AMaxProgress: Integer): IViewProgress;
begin
   Result := Self;
   FrmProgress.setMaxProgress(AMaxProgress);
end;

function TViewProgress.setOnError(AOnError: TProc<String>): IViewProgress;
begin
   Result := Self;
   FOnError := AOnError;
end;

function TViewProgress.setOnSuccess(AOnSuccess: TProc): IViewProgress;
begin
   Result := Self;
   FOnSuccess := AOnSuccess;
end;

function TViewProgress.setOperation(AOperation: TProc<TObserverValue<Integer>,TObserverValue<String>>): IViewProgress;
begin
   Result := Self;
   FOperation := AOperation;
end;

procedure TViewProgress.show;
var
   Thread : TThread;
begin
   Thread := TThread.CreateAnonymousThread(
      procedure
      begin
         FOperation(FProgress,FStatus);
      end);
   Thread.OnTerminate := onTerminatedThread;
   Thread.Start;

   FrmProgress.ShowModal;
end;

procedure TViewProgress.onTerminatedThread(sender: TObject);
var
   mException: TObject;
begin
   FrmProgress.Close;
   FrmProgress.Hide;
   if (Sender is TThread) then
   begin
      mException := TThread(Sender).FatalException;
      if (Assigned(mException)) and (Assigned(FOnError)) then
      begin
         if mException is Exception then
            FOnError(Exception(mException).Message)
         else
            FOnError(mException.ClassName);
      end
      else
      if (Assigned(FOnSuccess)) then
         FOnSuccess;
   end;
end;

end.
