unit VCL.Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, VCL.Graphics,
  VCL.Controls, VCL.Forms, VCL.Dialogs, VCL.StdCtrls, VCL.ExtCtrls, Skia, Skia.VCL;

type
  TForm82 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Image1: TImage;
    FileOpenDialog1: TFileOpenDialog;
    Button1: TButton;
    Button2: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Loader: TSkAnimatedImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form82: TForm82;

implementation

uses
  System.IOUtils, System.Threading;

{$R *.dfm}


procedure TForm82.FormCreate(Sender: TObject);
begin
{$IFDEF SKIA}
  Label1.Caption := 'Skia enabled';
{$ELSE}
  Label1.Caption := 'Skia not enabled';
{$ENDIF}

end;

procedure TForm82.Button1Click(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(FileOpenDialog1.FileName);
  end;
end;

procedure TForm82.Button2Click(Sender: TObject);
begin
  // https://lottiefiles.com/category/loading/animations

  Loader.Visible := true;
  TTask.Run(
    procedure
    begin
      try
        sleep(5000);
      finally
        TThread.Synchronize(nil,
          procedure
          begin
            Loader.Visible := false;
          end);
      end;
    end
    )

end;

end.
