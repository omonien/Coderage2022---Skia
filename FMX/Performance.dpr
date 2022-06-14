program Performance;

uses
  System.StartUpCopy,
  FMX.Forms,
  FMX.Types,
  {$IFDEF SKIA}
  Skia.FMX,
  {$ENDIF }
  Performance.Forms.Main in 'Performance.Forms.Main.pas' {Form81},
  Performance.Forms.Shader in 'Performance.Forms.Shader.pas' {FormShader};

{$R *.res}


begin
{$IFDEF SKIA}
  // Pull in Skia Canvas
  GlobalUseSkia := True;
  // Windows only - use CPU vs. GPU
  GlobalUseSkiaRasterWhenAvailable := false;
{$ENDIF}
  // Mac / iOS
  GlobalUseMetal := True;

  Application.Initialize;
  Application.CreateForm(TForm81, Form81);
  Application.Run;

end.
