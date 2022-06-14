unit Performance.Forms.Shader;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia, Skia.FMX, FMX.Memo.Types,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.StdCtrls;

type
  TFormShader = class(TForm)
    SkAnimatedPaintBox1: TSkAnimatedPaintBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure SkAnimatedPaintBox1AnimationDraw(ASender: TObject; const ACanvas:
      ISkCanvas; const ADest: TRectF; const AProgress: Double; const AOpacity:
      Single);
  private
    FEffect: ISkRuntimeEffect;
    FPaint: ISkPaint;
  public
    procedure RunShader;
  end;

var
  FormShader: TFormShader;

implementation

uses
  System.IOUtils;

{$R *.fmx}


procedure TFormShader.FormCreate(Sender: TObject);
begin
   RunShader
end;

procedure TFormShader.RunShader;
begin
  SkAnimatedPaintBox1.Enabled := False;
  FEffect := nil;
  FPaint := nil;
  var
  LError := '';
  FEffect := TSkRuntimeEffect.MakeForShader(Memo1.Text, LError);
  if LError > '' then
    raise Exception.Create(LError);

  FPaint := TSkPaint.Create;
  FPaint.Shader := FEffect.MakeShader(True);
  SkAnimatedPaintBox1.Enabled := True;
end;

procedure TFormShader.SkAnimatedPaintBox1AnimationDraw(ASender: TObject; const
  ACanvas: ISkCanvas; const ADest: TRectF; const AProgress: Double; const
  AOpacity: Single);
begin
  if Assigned(FEffect) and Assigned(FPaint) then
  begin
    if FEffect.UniformExists('iResolution') then
    begin
      if FEffect.UniformType['iResolution'] = TSkRuntimeEffectUniformType.Float3 then
        FEffect.SetUniform('iResolution', [ADest.Width, ADest.Height, 0])
      else
        FEffect.SetUniform('iResolution', PointF(ADest.Width, ADest.Height));
    end;
    if FEffect.UniformExists('iTime') then
      FEffect.SetUniform('iTime', AProgress * SkAnimatedPaintBox1.Duration);
    ACanvas.DrawRect(ADest, FPaint);
  end;
end;

end.
