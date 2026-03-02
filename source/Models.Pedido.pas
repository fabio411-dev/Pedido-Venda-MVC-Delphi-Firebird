unit Models.Pedido;

interface

uses
  System.SysUtils, System.Generics.Collections, Models.PedidoItem;

type
  TPedido = class
  private
    FNumeroPedido  : Integer;
    FDataEmissao   : TDateTime;
    FClienteCodigo : Integer;
    FItems         : TObjectList<TPedidoItem>;
  published
    property NumeroPedido  : Integer                  read FNumeroPedido  write FNumeroPedido;
    property DataEmissao   : TDateTime                read FDataEmissao   write FDataEmissao;
    property ClienteCodigo : Integer                  read FClienteCodigo write FClienteCodigo;
    property Items         : TObjectList<TPedidoItem> read FItems;
    function Total         : Currency; inline;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

implementation

constructor TPedido.Create;
begin
  inherited;
  //tipo TObjectList -> AutoDelete itens/objetos da lista onFree da lista
  FItems := TObjectList<TPedidoItem>.Create(True);
  FDataEmissao := Now;
end;

destructor TPedido.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TPedido.Total: Currency;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FItems.Count - 1 do
    Result := Result + FItems.Items[I].VlrTotal;
end;

end.

