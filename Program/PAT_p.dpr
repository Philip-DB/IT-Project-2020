program PAT_p;

uses
  Vcl.Forms,
  PAT_u in 'PAT_u.pas' {frmMainProj},
  dmHospital_u in 'dmHospital_u.pas' {DataModule1: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TfrmMainProj, frmMainProj);
  Application.CreateForm(TDmHospital, dmHospital);
  Application.Run;
end.
