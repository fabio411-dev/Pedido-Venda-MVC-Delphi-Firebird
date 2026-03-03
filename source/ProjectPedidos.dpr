program ProjectPedidos;

uses
  Vcl.Forms,
  UPrincipalPedidos in 'UPrincipalPedidos.pas' {FPrincipalPedidos},
  Models.Pedido in 'Models.Pedido.pas',
  Models.PedidoItem in 'Models.PedidoItem.pas',
  Models.Cliente in 'Models.Cliente.pas',
  Models.Produto in 'Models.Produto.pas',
  Repositories.ClienteRepository in 'Repositories.ClienteRepository.pas',
  Repositories.ProdutoRepository in 'Repositories.ProdutoRepository.pas',
  Repositories.PedidoRepository in 'Repositories.PedidoRepository.pas',
  Services.PedidoService in 'Services.PedidoService.pas',
  UDataModulePrincipal in 'UDataModulePrincipal.pas' {DataModulePrincipal: TDataModule},
  uFrmPedido in 'uFrmPedido.pas' {FrmPedido};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincipalPedidos, FPrincipalPedidos);
  Application.CreateForm(TDataModulePrincipal, DataModulePrincipal);
  Application.Run;
end.
