program E09Compiler;

uses
  Forms,
  MainForm in 'MainForm.pas' {Form1},
  Engine in 'Engine.pas',
  AboutForm in 'AboutForm.pas' {frmAbout},
  ExtLabelsForm in 'ExtLabelsForm.pas' {frmExtLabels},
  ExportHTMLForm in 'ExportHTMLForm.pas' {frmExportHTMLWizard};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'E09 Compiler';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmExtLabels, frmExtLabels);
  Application.CreateForm(TfrmExportHTMLWizard, frmExportHTMLWizard);
  Application.Run;
end.
