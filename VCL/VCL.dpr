program VCL;

uses
  VCL.Forms,
{$IFDEF SKIA}
  Skia.VCL,
{$ENDIF }
  VCL.Forms.Main in 'VCL.Forms.Main.pas' {Form82};

{$R *.res}


begin

{$REGION HIDDEN}
  TSkTypefaceManager.RegisterTypeface('..\..\..\fonts\Montserrat-Medium.ttf');

  TSkTypefaceManager.RegisterTypeface('..\..\..\fonts\BigShouldersStencilText-Regular.ttf');
  TSkTypefaceManager.RegisterTypeface('..\..\..\fonts\BigShouldersStencilText-Medium.ttf');
  TSkTypefaceManager.RegisterTypeface('..\..\..\fonts\BigShouldersStencilText-Bold.ttf');
{$ENDREGION}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm82, Form82);
  Application.Run;

end.
