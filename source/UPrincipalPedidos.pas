unit UPrincipalPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFPrincipalPedidos = class(TForm)
    btnNovo: TButton;
    procedure btnNovoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipalPedidos: TFPrincipalPedidos;

implementation

{$R *.dfm}

uses uFrmPedido;

procedure TFPrincipalPedidos.btnNovoClick(Sender: TObject);
var FrmPedido : TFrmPedido;
begin
  FrmPedido := TFrmPedido.Create(Self);
  FrmPedido.ShowModal;
end;

end.
