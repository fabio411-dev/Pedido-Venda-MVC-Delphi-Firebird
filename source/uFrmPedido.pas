unit uFrmPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  UDataModulePrincipal,
  Services.PedidoService,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmPedido = class(TForm)
    edtClienteCodigo: TEdit;
    Cliente: TLabel;
    Panel1: TPanel;
    lblClienteNome: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    edtProdutoCodigo: TEdit;
    Label1: TLabel;
    Panel4: TPanel;
    lblProdutoDescricao: TLabel;
    edtQuantidade: TEdit;
    Label2: TLabel;
    edtValorUnitario: TEdit;
    Label3: TLabel;
    btnIncluirItem: TButton;
    grdItens: TDBGrid;
    btnGravar: TButton;
    Label4: TLabel;
    edtTotalPedido: TEdit;



    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtClienteCodigoExit(Sender: TObject);
    procedure edtProdutoCodigoExit(Sender: TObject);
    procedure btnIncluirItemClick(Sender: TObject);
    procedure grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
  private
    FDService    : TPedidoService;
    FItemControl : Integer;

    procedure IncluirGridItem( ACodProd : Integer;
                               ADescricao : String;
                               AQuant : Currency;
                               AVlrUnit : Currency);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses Models.Cliente, Models.Produto;


procedure TFrmPedido.btnGravarClick(Sender: TObject);
begin
  if (not DataModulePrincipal.cdsPedidoItem.Active) or
     (DataModulePrincipal.cdsPedidoItem.IsEmpty) then
    raise EPedidoException.Create('Pedido sem Itens.');

  try
    FDService.SavePedido;
    ShowMessage('Pedido gravado com sucesso!');

    // Zera a tela para próximo pedido
    edtClienteCodigo.Clear;
    lblClienteNome.Caption   := '';
    edtProdutoCodigo.Clear;
    lblProdutoDescricao.Caption := '';
    edtQuantidade.Clear;
    edtValorUnitario.Clear;

    DataModulePrincipal.cdsPedidoItem.EmptyDataSet;

  except
    on E: EPedidoException do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmPedido.btnIncluirItemClick(Sender: TObject);
var
  LCodProd : Integer;
  LQuant   : Currency;
  LVlrUnit : Currency;
begin
  if not TryStrToInt(edtProdutoCodigo.Text, LCodProd) then
    raise EPedidoException.Create('Código do produto inválido.');
  if not TryStrToCurr(edtQuantidade.Text, LQuant) then
    raise EPedidoException.Create('Quantidade inválida.');
  if not TryStrToCurr(edtValorUnitario.Text, LVlrUnit) then
    raise EPedidoException.Create('Valor unitário inválido.');

  IncluirGridItem( LCodProd, lblProdutoDescricao.Caption, LQuant, LVlrUnit);
  FItemControl := DataModulePrincipal.cdsPedidoItem.FieldByName('Control').AsInteger;
  FDService.InsertOrUpdateItem(FItemControl, LCodProd, LQuant, LVlrUnit);


  edtTotalPedido.Text := FormatFloat('R$ #,##0.00', FDService.Pedido.Total);

  edtProdutoCodigo.Text       := '';
  lblProdutoDescricao.Caption := '';
  edtQuantidade.Text          := '';
  edtValorUnitario.Text       := '';
  FItemControl                := 0;
end;

procedure TFrmPedido.edtClienteCodigoExit(Sender: TObject);
var
  LCliente: TCliente;
  LCodigo: Integer;
begin
  if TryStrToInt(edtClienteCodigo.Text, LCodigo) then
  begin
    LCliente := FDService.GetCliente(LCodigo);
    if Assigned(LCliente) then
    begin
      FDService.Pedido.ClienteCodigo := LCodigo;
      lblClienteNome.Caption   := LCliente.Nome + ' - ' +
                                  LCliente.Cidade + '/' + LCliente.UF;
      LCliente.Free;
    end
    else
      ShowMessage('Cliente não encontrado.');
  end;
end;

procedure TFrmPedido.edtProdutoCodigoExit(Sender: TObject);
var
  LProduto: TProduto;
   LCodigo: Integer;
begin
  if TryStrToInt(edtProdutoCodigo.Text, LCodigo) then
  begin
    LProduto := FDService.GetProduto(LCodigo);
    if Assigned(LProduto) then
    begin
      lblProdutoDescricao.Caption := LProduto.Descricao;
      edtValorUnitario.Text := FormatFloat('0.00', LProduto.PrecoVenda);
      LProduto.Free;
      FItemControl := 0;
    end
    else
      ShowMessage('Produto não encontrado.');
  end;
end;

procedure TFrmPedido.FormCreate(Sender: TObject);
begin
  FDService := TPedidoService.Create(DataModulePrincipal.FDConexao, DataModulePrincipal.FDTrans);

  DataModulePrincipal.cdsPedidoItem.Close;
  DataModulePrincipal.cdsPedidoItem.CreateDataSet;
end;

procedure TFrmPedido.FormDestroy(Sender: TObject);
begin
  DataModulePrincipal.cdsPedidoItem.Close;
  FDService.Free;
end;

procedure TFrmPedido.grdItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  SelIndex: Integer;
begin
  if (not DataModulePrincipal.cdsPedidoItem.active) or
     (DataModulePrincipal.cdsPedidoItem.IsEmpty) then
    Exit;


  SelIndex := grdItens.SelectedIndex;  // index do item na lista
  if Key = VK_DELETE then
  begin
    if MessageDlg('Excluir item selecionado?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      FDService.RemoveItem(SelIndex);
      DataModulePrincipal.cdsPedidoItem.Delete;
      FItemControl := 0;
    end;
  end
  else
  if Key = VK_RETURN then
  begin
    FItemControl                := DataModulePrincipal.cdsPedidoItem.FieldByName('Control').AsInteger;
    edtProdutoCodigo.Text       := DataModulePrincipal.cdsPedidoItem.FieldByName('CODIGO_PRODUTO').AsString;
    lblProdutoDescricao.Caption := DataModulePrincipal.cdsPedidoItem.FieldByName('DESCRICAO').AsString;
    edtQuantidade.Text          := DataModulePrincipal.cdsPedidoItem.FieldByName('QUANTIDADE').AsString;
    edtValorUnitario.Text       := DataModulePrincipal.cdsPedidoItem.FieldByName('VLR_UNITARIO').AsString;
  end;
end;

procedure TFrmPedido.IncluirGridItem(ACodProd: Integer; ADescricao: String; AQuant, AVlrUnit: Currency);
begin
  if FItemControl = 0 then
    DataModulePrincipal.cdsPedidoItem.Append
  else
    DataModulePrincipal.cdsPedidoItem.Edit;

  DataModulePrincipal.cdsPedidoItemCODIGO_PRODUTO.AsInteger := ACodProd;
  DataModulePrincipal.cdsPedidoItemDESCRICAO.AsString := ADescricao;
  DataModulePrincipal.cdsPedidoItemQUANTIDADE.AsFloat := AQuant;
  DataModulePrincipal.cdsPedidoItemVLR_UNITARIO.AsFloat := AVlrUnit;
  DataModulePrincipal.cdsPedidoItemVLR_TOTAL.AsFloat := AQuant * AVlrUnit;
  DataModulePrincipal.cdsPedidoItem.Post;
end;

end.
