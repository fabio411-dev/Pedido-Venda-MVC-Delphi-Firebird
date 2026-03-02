unit Repositories.PedidoRepository;

interface

uses
  System.SysUtils, Models.Pedido, Models.PedidoItem, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  TPedidoRepository = class
  private
    FConnection : TFDConnection;
    FTransaction: TFDTransaction;
  public
    constructor Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
    function NextPedidoNumero: Integer;
    procedure InsertPedido(AItem: TPedido);
  end;

implementation

constructor TPedidoRepository.Create(AConnection: TFDConnection; ATransaction: TFDTransaction);
begin
  FConnection := AConnection;
  FTransaction := ATransaction;
end;

function TPedidoRepository.NextPedidoNumero: Integer;
var
  LQryAux: TFDQuery;
begin
  LQryAux := TFDQuery.Create(nil);
  try
    LQryAux.Connection := FConnection;
    LQryAux.SQL.Text   := 'SELECT GEN_ID(GEN_PEDIDO, 1) AS NR '+
                          '  FROM RDB$DATABASE                ';
    LQryAux.Open;

    Result := LQryAux.FieldByName('NR').AsInteger;
  finally
    LQryAux.Free;
  end;
end;

procedure TPedidoRepository.InsertPedido(AItem: TPedido);
var
  LQryAux: TFDQuery;
  i : Integer;
begin
  LQryAux := TFDQuery.Create(nil);

  try
    LQryAux.Connection  := FConnection;
    LQryAux.Transaction := FTransaction;
    LQryAux.SQL.Text := 'INSERT INTO PEDIDO (NUMERO_PEDIDO,   '+
                        '                    DATA_EMISSAO,    '+
                        '                    CODIGO_CLIENTE,  '+
                        '                    VALOR_TOTAL,     '+
                        '                    OBSERVACAO)      '+
                        '            VALUES (:NUMERO_PEDIDO,  '+
                        '                    :DATA_EMISSAO,   '+
                        '                    :CODIGO_CLIENTE, '+
                        '                    :VALOR_TOTAL,    '+
                        '                    :OBSERVACAO)     ';
    LQryAux.ParamByName('NUMERO_PEDIDO').AsInteger   := AItem.NumeroPedido;
    LQryAux.ParamByName('DATA_EMISSAO').AsDateTime   := AItem.DataEmissao;
    LQryAux.ParamByName('CODIGO_CLIENTE').AsInteger  := AItem.ClienteCodigo;
    LQryAux.ParamByName('VALOR_TOTAL').AsCurrency    := AItem.Total;
    LQryAux.ParamByName('OBSERVACAO').AsString       := AItem.Observacao;

    LQryAux.ExecSQL;
  finally
    LQryAux.Free;
  end;


  for i := 0 to AItem.Items.Count - 1 do
  begin
    LQryAux := TFDQuery.Create(nil);

    try
      LQryAux.Connection := FConnection;
      LQryAux.Transaction := FTransaction;
      LQryAux.SQL.Text := 'INSERT INTO PEDIDO_ITEM (ID,             '+
                          '                         NUMERO_PEDIDO,  '+
                          '                         CODIGO_PRODUTO, '+
                          '                         QUANTIDADE,     '+
                          '                         VLR_UNITARIO,   '+
                          '                         VLR_TOTAL)      '+
                          '                 VALUES ( NULL,          '+
                          '                         :NUMERO_PEDIDO, '+
                          '                         :CODIGO_PRODUTO,'+
                          '                         :QUANTIDADE,    '+
                          '                         :VLR_UNITARIO,  '+
                          '                         :VLR_TOTAL)     ';
      LQryAux.ParamByName('NUMERO_PEDIDO').AsInteger  := AItem.NumeroPedido;
      LQryAux.ParamByName('CODIGO_PRODUTO').AsInteger := AItem.Items[I].CodigoProduto;
      LQryAux.ParamByName('QUANTIDADE').AsInteger     := AItem.Items[I].Quantidade;
      LQryAux.ParamByName('VLR_UNITARIO').AsCurrency  := AItem.Items[I].VlrUnitario;
      LQryAux.ParamByName('VLR_TOTAL').AsCurrency     := AItem.Items[I].VlrTotal;
      LQryAux.ExecSQL;
    finally
      LQryAux.Free;
    end;
  end;
end;



end.

