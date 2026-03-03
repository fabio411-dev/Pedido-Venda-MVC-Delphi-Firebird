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
    FQuantidade    : Currency;
    FVlrUnitario   : Currency;
    FVlrTotal      : Currency;
    FControl       : Integer;
  published
    property Control       : Integer  read FControl       write FControl;
    property ID            : Integer  read FID            write FID;
    property NumeroPedido  : Integer  read FNumeroPedido  write FNumeroPedido;
    property CodigoProduto : Integer  read FCodigoProduto write FCodigoProduto;
    property Descricao     : string   read FDescricao     write FDescricao;
    property Quantidade    : Currency read FQuantidade    write FQuantidade;
    property VlrUnitario   : Currency read FVlrUnitario   write FVlrUnitario;
    property VlrTotal      : Currency read FVlrTotal      write FVlrTotal;
  end;

implementation

end.

