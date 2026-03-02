unit Repositories.ProdutoRepository;

interface

uses
  System.SysUtils, Models.Produto, Data.DB, FireDAC.Comp.Client;

type
  TProdutoRepository = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function FindByCodigo(ACodigo: Integer): TProduto;
  end;

implementation

constructor TProdutoRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TProdutoRepository.FindByCodigo(ACodigo: Integer): TProduto;
var
  LQryAux : TFDQuery;
begin
  LQryAux := TFDQuery.Create(nil);
  try
    LQryAux.Connection := FConnection;
    LQryAux.SQL.Text   := 'SELECT CODIGO,         '+
                          '       DESCRICAO,      '+
                          '       PRECO_VENDA     '+
                          '  FROM PRODUTO         '+
                          ' WHERE CODIGO = :CODIGO';
    LQryAux.ParamByName('CODIGO').AsInteger := ACodigo;
    LQryAux.Open;

    if LQryAux.Eof then
      Exit(nil);

    Result := TProduto.Create;
    Result.Codigo     := LQryAux.FieldByName('CODIGO').AsInteger;
    Result.Descricao  := LQryAux.FieldByName('DESCRICAO').AsString;
    Result.PrecoVenda := LQryAux.FieldByName('PRECO_VENDA').AsCurrency;
  finally
    LQryAux.Free;
  end;
end;

end.

