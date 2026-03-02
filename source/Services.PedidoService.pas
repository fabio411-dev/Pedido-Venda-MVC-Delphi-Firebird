unit Services.PedidoService;

interface

uses
  System.SysUtils,
  Models.Pedido,
  Models.PedidoItem,
  Models.Cliente,
  Models.Produto,
  Repositories.PedidoRepository,
  Repositories.ClienteRepository,
  Repositories.ProdutoRepository,
  FireDAC.Comp.Client, Data.DB;

type
  EPedidoException = class(Exception);

  TPedidoService = class
  private
    FConnection  : TFDConnection;
    FTransaction : TFDTransaction;
    FPedidoRepo  : TPedidoRepository;
    FClienteRepo : TClienteRepository;
    FProdutoRepo : TProdutoRepository;
    FPedido      : TPedido;
  published
    property Pedido: TPedido read FPedido;
  public
    constructor Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
    destructor Destroy; override;

    function  GetCliente(ACodigo: Integer): TCliente;
    function  GetProduto(ACodigo: Integer): TProduto;
    procedure InsertOrUpdateItem(APedidoItemID  : Integer;
                                 ACodigoProduto : Integer;
                                 AQuantidade    : Currency;
                                 AVlrUnitario   : Currency);
    procedure RemoveItem(Index: Integer);
    function  GetTotal: Currency;
    procedure SavePedido;
  end;

implementation

constructor TPedidoService.Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
begin
  FConnection  := AConnection;
  FTransaction := ATransaction;
  FPedidoRepo  := TPedidoRepository.Create(AConnection, ATransaction);
  FClienteRepo := TClienteRepository.Create(AConnection);
  FProdutoRepo := TProdutoRepository.Create(AConnection);
  FPedido      := TPedido.Create;
end;

destructor TPedidoService.Destroy;
begin
  FPedido.Free;
  FPedidoRepo.Free;
  FClienteRepo.Free;
  FProdutoRepo.Free;
  inherited;
end;

function TPedidoService.GetCliente(ACodigo: Integer): TCliente;
var
  LCliente: TCliente;
begin
  LCliente := FClienteRepo.FindByCodigo(ACodigo);
  if not Assigned(LCliente) then
  begin
    raise EPedidoException.Create('Cliente não encontrado.');
  end;

 Result := LCliente;
end;

function  TPedidoService.GetProduto(ACodigo: Integer): TProduto;
var
  LProduto: TProduto;
begin
  LProduto := FProdutoRepo.FindByCodigo(ACodigo);
  if not Assigned(LProduto) then
  begin
    raise EPedidoException.Create('Produto não encontrado.');
  end;

  Result := LProduto;
end;

procedure TPedidoService.InsertOrUpdateItem(APedidoItemID  : Integer;
                                            ACodigoProduto: Integer;
                                            AQuantidade   : Currency;
                                            AVlrUnitario  : Currency);
var
  LItem     : TPedidoItem;
  LExisting : TPedidoItem;
  LProduto  : TProduto;
  i         : Integer;
begin
  //Se existe item ID ja gravado, atualizar
  LExisting := nil;
  for i := 0 to FPedido.Items.Count - 1 do
  begin
    if FPedido.Items[I].ID = APedidoItemID then
    begin
      LExisting := FPedido.Items[I];
      Break;
    end;
  end;

  if Assigned(LExisting) then
  begin
    LExisting.Quantidade  := AQuantidade;
    LExisting.VlrUnitario := AVlrUnitario;
    LExisting.VlrTotal    := LExisting.Quantidade * LExisting.VlrUnitario;
  end
  else
  begin
    LItem := TPedidoItem.Create;
    LProduto := FProdutoRepo.FindByCodigo(ACodigoProduto);
    LItem.CodigoProduto := ACodigoProduto;
    LItem.Descricao     := LProduto.Descricao;
    LItem.Quantidade    := AQuantidade;
    LItem.VlrUnitario   := AVlrUnitario;
    LItem.VlrTotal      := LItem.Quantidade * LItem.VlrUnitario;
    FPedido.Items.Add(LItem);
  end;


end;

procedure TPedidoService.RemoveItem(Index: Integer);
begin
  if (Index >= 0) and (Index < FPedido.Items.Count) then
  begin
    FPedido.Items.Delete(Index);

  end;
end;

function TPedidoService.GetTotal: Currency;
var
  Total: Currency;
begin
  Result := FPedido.Total;
end;

procedure TPedidoService.SavePedido;
begin
  if FPedido.ClienteCodigo = 0 then
  begin
    raise EPedidoException.Create('Nenhum cliente selecionado.');
  end;

  if FPedido.Items.Count = 0 then
  begin
    raise EPedidoException.Create('Nenhum item no pedido.');
  end;

  FPedido.NumeroPedido := FPedidoRepo.NextPedidoNumero;

  try
    FTransaction.StartTransaction;
    FPedidoRepo.InsertPedido(FPedido);
    FTransaction.Commit;
  except
    on E: Exception do
    begin
      FTransaction.Rollback;
      raise EPedidoException.Create('Erro ao gravar Pedido: ' + E.Message);
    end;
  end;
end;

end.

