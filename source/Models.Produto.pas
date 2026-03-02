unit Models.Produto;

interface

uses
  System.SysUtils;

type
  TProduto = class
  private
    FCodigo     : Integer;
    FDescricao  : string;
    FPrecoVenda : Currency;
  published
    property Codigo     : Integer  read FCodigo     write FCodigo;
    property Descricao  : string   read FDescricao  write FDescricao;
    property PrecoVenda : Currency read FPrecoVenda write FPrecoVenda;
  end;

implementation

end.

