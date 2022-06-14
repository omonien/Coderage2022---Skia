unit Performance.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.Layouts, FMX.ListView, FMX.Controls.Presentation, FMX.StdCtrls, System.ImageList,
  FMX.ImgList, FMX.Objects, FMX.Ani;

type
  TForm81 = class(TForm)
    ListView1: TListView;
    Layout1: TLayout;
    Button1: TButton;
    ImageList1: TImageList;
    Button2: TButton;
    TimerScroll: TTimer;
    LabelFPS: TLabel;
    TimerFpsReset: TTimer;
    Label1: TLabel;
    Circle1: TCircle;
    LayoutTop: TLayout;
    FloatAnimation1: TFloatAnimation;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure TimerFpsResetTimer(Sender: TObject);
    procedure TimerScrollTimer(Sender: TObject);
  private
    FPaintCount: integer;
    FTotalPaintCount: integer;
    FStopWatch: TDateTime;
    FCurrentItem: integer;
    procedure FillListView;

  public
    { Public-Deklarationen }
  end;

var
  Form81: TForm81;

implementation

uses
  System.DateUtils
  , Performance.Forms.Shader;

{$R *.fmx}


procedure TForm81.FormCreate(Sender: TObject);
begin
{$IFDEF SKIA}
  Label1.Text := 'Skia enabled';
{$ELSE}
  Label1.Text := 'Skia NOT enabled';
{$ENDIF}

end;

procedure TForm81.Button1Click(Sender: TObject);
begin
  FillListView;
end;

procedure TForm81.Button2Click(Sender: TObject);
begin
  TimerScroll.Enabled := not TimerScroll.Enabled
end;

procedure TForm81.Button3Click(Sender: TObject);
begin
  TFormShader.Create(self).Show;
end;

procedure TForm81.Circle1Click(Sender: TObject);
begin
  FloatAnimation1.StartValue := 0;
  FloatAnimation1.StopValue := self.Width - Circle1.Width;
  FloatAnimation1.Enabled := not FloatAnimation1.Enabled;
end;

procedure TForm81.FillListView;
begin
  for var i := 1 to 1000 do
  begin
    var
    LItem := ListView1.Items.Add;
    LItem.Text := i.Tostring + ': Lorem Ipsum';

    if i mod 2 = 0 then
    begin
      LItem.Detail :=
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.';
      LItem.ImageIndex := 0;
    end
    else
    begin
      LItem.Detail :=
        'At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';
      LItem.ImageIndex := 1;
    end;
  end;
  FCurrentItem := ListView1.Items.Count - 1;
  ListView1.ScrollTo(FCurrentItem);
end;

procedure TForm81.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TForm81.FormPaint(Sender: TObject; Canvas: TCanvas; const ARect:
  TRectF);
begin
  inc(FTotalPaintCount);
  if FPaintCount = 0 then
  begin
    FStopWatch := now;
  end;
  inc(FPaintCount);
  var
  LFps := FPaintCount / ((now - FStopWatch) * (1 / OneSecond));
  LabelFPS.Text := Format('%d  %3.1f fps', [FTotalPaintCount, LFps]);
end;

procedure TForm81.TimerFpsResetTimer(Sender: TObject);
begin
  FPaintCount := 0;
end;

procedure TForm81.TimerScrollTimer(Sender: TObject);
begin
  inc(FCurrentItem);
  if FCurrentItem >= ListView1.Items.Count then
  begin
    FCurrentItem := 0;
  end;
  ListView1.ScrollTo(FCurrentItem);
end;

end.
