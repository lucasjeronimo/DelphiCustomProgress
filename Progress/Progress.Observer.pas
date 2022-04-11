unit Progress.Observer;

interface

uses
   System.SysUtils;

type
   TObserverValue<T> = class
   private
      FValue: T;
      FObserver: TProc<T>;
      procedure setValue(const Value: T);
      function getValue: T;
   public
      constructor Create(AValue: T);
      property value: T read getValue write setValue;
      property onChange: TProc<T> write FObserver;
   end;

implementation

{ TObserverValue<T> }

constructor TObserverValue<T>.Create(AValue: T);
begin
   inherited Create;
   value := AValue;
end;

function TObserverValue<T>.getValue: T;
begin
   result := FValue;
end;


procedure TObserverValue<T>.setValue(const Value: T);
begin
   FValue := Value;
   if assigned(FObserver) then
      FObserver(value);
end;

end.
