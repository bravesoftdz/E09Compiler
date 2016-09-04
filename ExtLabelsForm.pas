unit ExtLabelsForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids;

type
  TfrmExtLabels = class(TForm)
    grid: TStringGrid;
    cmdAdd: TBitBtn;
    cmdDelete: TBitBtn;
    cmdOK: TBitBtn;
    cmdCancel: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmExtLabels: TfrmExtLabels;

implementation

{$R *.DFM}

end.
