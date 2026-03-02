unit Models.PedidoItem;

interface

uses
  System.SysUtils;

type
  TPedidoItem = class
  private
    FID            : Integer;
    FNumeroPedido  : Integer;
    FCodigoProduto : Integer;
    FDescricao     : string;
    FQuantidade    : Integer;
    FVlrUnitario   : Currency;
    FVlrTotal      : Currency;
  published
    property ID            : Integer  read FID            write FID;
    property NumeroPedido  : Integer  read FNumeroPedido  write FNumeroPedido;
    property CodigoProduto : Integer  read FCodigoProduto write FCodigoProduto;
    property Descricao     : string   read FDescricao     write FDescricao;
    property Quantidade    : Integer  read FQuantidade    write FQuantidade;
    property VlrUnitario   : Currency read FVlrUnitario   write FVlrUnitario;
    property VlrTotal      : Currency read FVlrTotal      write FVlrTotal;
  end;

implementation

end.

