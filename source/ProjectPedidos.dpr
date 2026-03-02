program ProjectPedidos;

uses
  Vcl.Forms,
  UPrincipalPedidos in 'UPrincipalPedidos.pas' {FPrincipalPedidos},
  Models.Pedido in 'Models.Pedido.pas',
  Models.PedidoItem in 'Models.PedidoItem.pas',
  Models.Cliente in 'Models.Cliente.pas',
  Models.Produto in 'Models.Produto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipalPedidos, FPrincipalPedidos);
  Application.Run;
end.
