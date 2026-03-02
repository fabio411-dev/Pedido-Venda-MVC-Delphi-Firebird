unit Repositories.ClienteRepository;

interface

uses
  System.SysUtils, Models.Cliente, Data.DB, FireDAC.Comp.Client;

type
  TClienteRepository = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function FindByCodigo(ACodigo: Integer): TCliente;
  end;

implementation

constructor TClienteRepository.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TClienteRepository.FindByCodigo(ACodigo: Integer): TCliente;
var
  LQryAux : TFDQuery;
begin
  LQryAux := TFDQuery.Create(nil);
  try
    LQryAux.Connection := FConnection;
    LQryAux.SQL.Text   := 'SELECT CODIGO,          '+
                          '       NOME,            '+
                          '       CIDADE,          '+
                          '       UF               '+
                          '  FROM CLIENTE          '+
                          ' WHERE CODIGO = :CODIGO ';
    LQryAux.ParamByName('CODIGO').AsInteger := ACodigo;
    LQryAux.Open;

    if LQryAux.Eof then
      Exit(nil);

    Result := TCliente.Create;
    Result.Codigo := LQryAux.FieldByName('CODIGO').AsInteger;
    Result.Nome   := LQryAux.FieldByName('NOME').AsString;
    Result.Cidade := LQryAux.FieldByName('CIDADE').AsString;
    Result.UF     := LQryAux.FieldByName('UF').AsString;
  finally
    LQryAux.Free;
  end;
end;

end.

