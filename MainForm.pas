unit MainForm;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ToolWin, ComCtrls, StdCtrls, ActnList, ImgList, Menus, Grids, contnrs,
  ExtCtrls, AppEvnts, Buttons;

type
  TForm1 = class(TForm)
    lstCommands: TListBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
		ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    imgMain: TImageList;
    ActionList1: TActionList;
    actFileNew: TAction;
    actFileOpen: TAction;
    actFileSave: TAction;
    MainMenu1: TMainMenu;
		N1: TMenuItem;
		N2: TMenuItem;
		N3: TMenuItem;
		N4: TMenuItem;
		OpenDialog1: TOpenDialog;
    ToolButton4: TToolButton;
    actFileExport: TAction;
    ToolButton5: TToolButton;
    N5: TMenuItem;
    N6: TMenuItem;
		actFileExit: TAction;
		SaveDialog1: TSaveDialog;
    N7: TMenuItem;
    N8: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    actHelpAbout: TAction;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    actEditSync: TAction;
    StatusBar1: TStatusBar;
    panAssembly: TPanel;
    txtAssembly: TMemo;
    panAssembly2: TPanel;
    Label1: TLabel;
    panBinary: TPanel;
    grid: TStringGrid;
    panBinary2: TPanel;
    Label2: TLabel;
    Splitter1: TSplitter;
    SaveDialog2: TSaveDialog;
    ApplicationEvents1: TApplicationEvents;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    actEditUndo: TAction;
    actEditRedo: TAction;
    actEditCut: TAction;
    actEditCopy: TAction;
    actEditPaste: TAction;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    panMessages: TPanel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    lvMessages: TListView;
    imgMessages: TImageList;
		procedure actFileOpenExecute(Sender: TObject);
		procedure FormCreate(Sender: TObject);
		procedure FormDestroy(Sender: TObject);
		procedure actFileExportExecute(Sender: TObject);
		procedure actFileExitExecute(Sender: TObject);
    procedure actHelpAboutExecute(Sender: TObject);
    procedure actEditSyncExecute(Sender: TObject);
    procedure actFileNewExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure txtAssemblyChange(Sender: TObject);
	private
		procedure DoOpenFile(const FileName: string);
		procedure DoExportCSV(const FileName: string);
		procedure DoExportTXT(const FileName: string);
		procedure ParseSource;
		procedure PrepareCommands;
	public
		{ Public declarations }
	end;

var
	Form1: TForm1;

implementation

uses Engine, AboutForm, ExportHTMLForm, ExtLabelsForm;

{$R *.DFM}

var
	cmdList: TObjectList;
	cmdhash: TStringList;
	KeyWordsHash: TStringList;
	LabelsHash: TStringList;
	ExtLabelsHash: TStringList;

procedure TForm1.DoOpenFile(const FileName: string);
begin
	txtAssembly.Lines.LoadFromFile(FileName);
	ParseSource;
end;

procedure TForm1.ParseSource;
var
	i, j, k: Integer;
	s, sComment: string;
	addr: Integer;
	c: T8085Command;
	nIndex: Integer;
	sLabel, sParam: string;
	addrLabel: Integer;

procedure SplitComment(s: string; var sCommand, sComment: string);
var
	i: Integer;
begin
	i := Pos(';', s);
	if i > 0 then
		begin
			sComment := Copy(s, i + 1, Length(s) - i);
			sCommand := Copy(s, 1, i - 1);
		end
	else
		begin
			sComment := '';
			sCommand := s;
		end;
end;

procedure SplitLabel(s: string; var sCommand, sLabel: string);
var
	i: Integer;
begin
	i := Pos(':', s);
	if i > 0 then
		begin
			sCommand := Trim(Copy(s, i + 1, Length(s) - i));
			sLabel := Trim(Copy(s, 1, i - 1));
		end
	else
		begin
			sLabel := '';
			sCommand := s;
		end;
end;


procedure NextAddr;
begin
	grid.Cells[0, j] := IntToHex(addr, 4);
	Inc(addr);
	Inc(j);
	grid.RowCount := grid.RowCount + 1;
	grid.Objects[1, j]:=nil;
	grid.Rows[j].Clear;
end;

function FindCommand(const s: string; var sParam: string): T8085Command;
var	i: Integer;
	s1, s3: string;
	nKWIndex, nIndex: Integer;
begin
	Result := nil;
	s1 := s;
	sParam := '';
	SplitList(s1, s1, s3);
	s3 := s;
	if KeyWordsHash.Find(s1, nKWIndex) then
		begin
			repeat
				if cmdHash.Find(s3, nIndex) then (* MOV A,B *)
					Result := cmdHash.Objects[nIndex] as T8085Command
				else
					begin
						i := LastDelimiter(' ,', s3);
						if i > 0 then begin  (* MVI A,param --> MVI A *)
							sParam := Copy(s3, i + 1, Length(s3) - i);
							s3 := Copy(s3, 1, i - 1)
						end
						else
							s3 := '';
					end;
			until (Result <> nil) or (s3 = '');
		end;
end;

procedure ShowMsg(const msg: string; Img: Integer);
begin
	with lvMessages.Items.Add do begin
		Caption := msg;
		ImageIndex := Img;
	end;
end;

procedure ShowError(const msg: string; LineNumber: Integer);
begin
	ShowMsg('[Σφάλμα] ' + '(' + IntToStr(LineNumber) + '): ' + msg, 0);
end;

procedure ShowWarning(const msg: string; LineNumber: Integer);
begin
	ShowMsg('[Προειδοποίηση] ' + '(' + IntToStr(LineNumber) + '): ' + msg, 1);
end;

begin
	lvMessages.Items.Clear;
	grid.RowCount := 2;
	grid.Rows[1].Clear;
	i := 0; // assembly line
	j := 1; // grid row
	addr := $0800;
	LabelsHash.Clear;
	sLabel := '';

	while i < txtAssembly.Lines.Count do begin
		s:= txtAssembly.Lines[i];
		s := SingleSpaces(Trim(s));
		SplitLabel(s, s, sLabel);
		SplitComment(s, s, sComment);

		if (Length(sLabel) > 0) and (Length(s) = 0) then (* LABEL: *)
			s := 'NOP';

		if Length(s) > 0 then begin
			c := FindCommand(s, sParam);
			if c <> nil then begin
				grid.Cells[1, j] := IntToHex(c.Code, 2);
				grid.Cells[2, j] := sLabel;
				if sLabel <> '' then
					LabelsHash.AddObject(sLabel, TObject(addr));
				grid.Cells[3, j] := c.Format(sParam);
				grid.Cells[4, j] := sComment;
				NextAddr;

				if c.Address then
					begin
						if sParam = '' then
							ShowError('Η εντολή ' + c.Name + ' απαιτεί διεύθυνση για όρισμα', i+1)
						else if IsHexNumber(sParam, 4) then
							begin
								addrLabel := StrToInt('$' + sParam);
								grid.Cells[1, j] := IntToHex(Lo(addrLabel), 2);
								NextAddr;
								grid.Cells[1, j] := IntToHex(Hi(addrLabel), 2);
								NextAddr;
							end
						else
							begin
								grid.Cells[1, j] := sParam;
								grid.Objects[1, j] := c;
								NextAddr;
								grid.Cells[1, j] := sParam;
								NextAddr;
							end
					end
				else if c.Bytes = 2 then (* one parameter *)
					begin
						grid.Cells[1, j] := sParam;
						NextAddr;
					end;
			end
			else
				ShowError('’γνωστη εντολή: ' + txtAssembly.Lines[i], i+1);
		end;
		Inc(i);
	end;

	(* parse labels *)
	for k:=1 to grid.RowCount - 1 do
		if grid.Objects[1, k] <> nil then begin
			if LabelsHash.Find(grid.Cells[1, k], nIndex) then
				addrLabel := Integer(LabelsHash.Objects[nIndex])
			else if ExtLabelsHash.Find(grid.Cells[1, k], nIndex) then
				addrLabel := Integer(ExtLabelsHash.Objects[nIndex])
			else
				nIndex := -1;
			if nIndex <> -1 then begin
				grid.Cells[1, k] := IntToHex(Lo(addrLabel), 2);
				grid.Cells[1, k+1] := IntToHex(Hi(addrLabel), 2);
				grid.Objects[1,k] := nil;
			end
			else
				ShowWarning('Η ετικέτα ' + grid.Cells[1, k] + ' δεν έχει οριστεί', 0); 
		end;


end;

procedure TForm1.actFileOpenExecute(Sender: TObject);
begin
	with OpenDialog1 do if Execute then
		DoOpenFile(FileName);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	grid.Cells[0, 0] := 'Διεύθυνση';
	grid.Cells[1, 0] := 'Περιεχόμενο';
	grid.Cells[2, 0] := 'Ετικέτα';
	grid.Cells[3, 0] := 'Εντολή';
	grid.Cells[4, 0] := 'Σχόλια';
	PrepareCommands;
end;

procedure TForm1.PrepareCommands;
var
	i: Integer;
	c: T8085Command;
begin
	cmdList := TObjectList.Create;
	cmdHash := TStringList.Create;
	KeyWordsHash := TStringList.Create;
	KeyWordsHash.Sorted := True;
	KeyWordsHash.Duplicates := dupIgnore;
	LabelsHash := TStringList.Create;
	LabelsHash.Sorted := True;
	LabelsHash.Duplicates := dupIgnore;
	ExtLabelsHash := TStringList.Create;
	ExtLabelsHash.Sorted := True;
	ExtLabelsHash.Duplicates := dupIgnore;
	ExtLabelsHash.AddObject('DELB', TObject($0430));

	for i := 0 to lstCommands.Items.Count - 1 do begin
		c := T8085Command.Create(lstCommands.Items[i], i);
		cmdList.Add(c);
		cmdHash.AddObject(c.Name, c);
		if Pos(' ', c.Name) = 0 then
			KeyWordsHash.Add(c.Name)
		else
			KeyWordsHash.Add(Copy(c.Name, 1, Pos(' ', c.Name) - 1));
	end;
	cmdHash.Sort;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
	cmdHash.Free;
	cmdList.Free;
	KeyWordsHash.Free;
	LabelsHash.Free;
	ExtLabelsHash.Free;
end;

procedure TForm1.actFileExportExecute(Sender: TObject);
begin
	with SaveDialog2 do if Execute then
		case FilterIndex of
			1:
				begin
					frmExportHTMLWizard.HTMLFile := FileName;
					frmExportHTMLWizard.Grid := grid;
					frmExportHTMLWizard.ShowModal;
				end;
			2: DoExportCSV(FileName);
			3: DoExportTXT(FileName);
		end;
end;

procedure TForm1.actFileExitExecute(Sender: TObject);
begin
	Close;
end;

procedure TForm1.DoExportCSV(const FileName: string);
var
	f: TextFile;
	i, j: Integer;
begin
	AssignFile(f, FileName);
	Rewrite(f);

	for i := 0 to grid.RowCount - 1 do begin
		for j := 0 to grid.ColCount - 2 do
			Write(f, grid.Cells[j, i] + #9);
		WriteLn(f, grid.Cells[grid.ColCount - 1, i]);
	end;
	CloseFile(f);
end;

procedure TForm1.DoExportTXT(const FileName: string);
var
	f: TextFile;
	i, j: Integer;
begin
	AssignFile(f, FileName);
	Rewrite(f);

	for i := 0 to grid.RowCount - 1 do begin
		for j := 0 to grid.ColCount - 2 do
			Write(f, grid.Cells[j, i] + #9);
		WriteLn(f, grid.Cells[grid.ColCount - 1, i]);
	end;
	CloseFile(f);
end;

procedure TForm1.actHelpAboutExecute(Sender: TObject);
begin
	frmAbout.ShowModal;
end;

procedure TForm1.actEditSyncExecute(Sender: TObject);
begin
	ParseSource;
end;

procedure TForm1.actFileNewExecute(Sender: TObject);
begin
	txtAssembly.Lines.Clear;
	ParseSource;
end;

procedure TForm1.actFileSaveExecute(Sender: TObject);
begin
	with SaveDialog1 do if Execute then
		txtAssembly.Lines.SaveToFile(FileName);
end;

procedure TForm1.ApplicationEvents1Hint(Sender: TObject);
begin
	StatusBar1.SimpleText := Application.Hint;
end;

procedure TForm1.txtAssemblyChange(Sender: TObject);
begin
	ParseSource;
end;

end.
