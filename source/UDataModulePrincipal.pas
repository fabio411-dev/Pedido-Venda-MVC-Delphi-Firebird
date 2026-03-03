unit UDataModulePrincipal;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.Stan.Def, FireDAC.Stan.Async,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageXML,
  FireDAC.Phys.Intf, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  FireDAC.Phys.IBBase, FireDAC.Comp.DataSet, IniFiles, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.VCLUI.Wait, firedac.DApt;

type
  TDataModulePrincipal = class(TDataModule)
    cdsPedidoItem: TClientDataSet;
    cdsPedidoItemID: TIntegerField;
    cdsPedidoItemNUMERO_PEDIDO: TIntegerField;
    cdsPedidoItemCODIGO_PRODUTO: TIntegerField;
    cdsPedidoItemQUANTIDADE: TFloatField;
    cdsPedidoItemVLR_UNITARIO: TCurrencyField;
    cdsPedidoItemVLR_TOTAL: TCurrencyField;
    dsPedidoItem: TDataSource;
    cdsPedidoItemDESCRICAO: TStringField;
    FDConexao: TFDConnection;
    FDTrans: TFDTransaction;
    cdsPedidoItemControl: TAutoIncField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LoadConnectionFromIni;
  public
    { Public declarations }
  end;

var
  DataModulePrincipal: TDataModulePrincipal;

implementation

{$R *.dfm}

procedure TDataModulePrincipal.DataModuleCreate(Sender: TObject);
begin
  LoadConnectionFromIni;
end;

procedure TDataModulePrincipal.LoadConnectionFromIni;
var
  LIni: TIniFile;
  LSection: string ;
begin
  LSection := 'Database';
  LIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    FDConexao.Params.Clear;
    FDConexao.Params.Add('Database=' + LIni.ReadString(LSection, 'Database', ''));
    FDConexao.Params.Add('User_Name=' + LIni.ReadString(LSection, 'Username', ''));
    FDConexao.Params.Add('Password=' + LIni.ReadString(LSection, 'Password', ''));
    FDConexao.Params.Add('Server=' + LIni.ReadString(LSection, 'Server', ''));
    FDConexao.Params.Add('Port=' + IntToStr( LIni.ReadInteger(LSection, 'Port', 3050) ) );
    FDConexao.Params.Add('ClientLibrary=' + LIni.ReadString(LSection, 'ClientLibrary', '') );
    FDConexao.Params.Add('DriverID=IB');
    FDConexao.LoginPrompt := False;

    FDConexao.Open;
    FDTrans.Connection := FDConexao;
  finally
    LIni.Free;
  end;
end;

end.
