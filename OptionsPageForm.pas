unit OptionsPageForm;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
	TOptionsPage = class(TForm)
	protected
		function GetLogicalPath: string; virtual;
	public
		property LogicalPath: string read GetLogicalPath;
	end;

implementation

{$R *.DFM}

function TOptionsPage.GetLogicalPath: string;
begin
	Result := '';
end;

end.
