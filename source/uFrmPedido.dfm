object FrmPedido: TFrmPedido
  Left = 0
  Top = 0
  Caption = 'Pedido'
  ClientHeight = 461
  ClientWidth = 741
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Cliente: TLabel
    Left = 40
    Top = 29
    Width = 33
    Height = 13
    Caption = 'Cliente'
  end
  object Panel2: TPanel
    Left = 8
    Top = 8
    Width = 725
    Height = 65
    BevelInner = bvLowered
    TabOrder = 2
  end
  object edtClienteCodigo: TEdit
    Left = 79
    Top = 26
    Width = 33
    Height = 21
    TabOrder = 0
    OnExit = edtClienteCodigoExit
  end
  object Panel1: TPanel
    Left = 118
    Top = 23
    Width = 603
    Height = 25
    BevelInner = bvLowered
    TabOrder = 1
    object lblClienteNome: TLabel
      Left = 6
      Top = 6
      Width = 79
      Height = 13
      Caption = 'ClienteDescricao'
    end
  end
  object Panel3: TPanel
    Left = 8
    Top = 101
    Width = 725
    Height = 316
    BevelInner = bvLowered
    TabOrder = 3
    object Label1: TLabel
      Left = 27
      Top = 35
      Width = 38
      Height = 13
      Caption = 'Produto'
    end
    object Label2: TLabel
      Left = 27
      Top = 65
      Width = 34
      Height = 13
      Caption = 'Quant.'
    end
    object Label3: TLabel
      Left = 173
      Top = 65
      Width = 36
      Height = 13
      Caption = 'Vlr. Un.'
    end
    object Label4: TLabel
      Left = 393
      Top = 292
      Width = 74
      Height = 13
      Caption = 'Total do Pedido'
    end
    object edtProdutoCodigo: TEdit
      Left = 71
      Top = 32
      Width = 49
      Height = 21
      TabOrder = 0
      OnExit = edtProdutoCodigoExit
    end
    object Panel4: TPanel
      Left = 122
      Top = 29
      Width = 590
      Height = 25
      BevelInner = bvLowered
      TabOrder = 1
      object lblProdutoDescricao: TLabel
        Left = 6
        Top = 6
        Width = 84
        Height = 13
        Caption = 'ProdutoDescricao'
      end
    end
    object edtQuantidade: TEdit
      Left = 71
      Top = 62
      Width = 49
      Height = 21
      TabOrder = 2
    end
    object edtValorUnitario: TEdit
      Left = 215
      Top = 62
      Width = 106
      Height = 21
      TabOrder = 3
    end
    object btnIncluirItem: TButton
      Left = 352
      Top = 60
      Width = 75
      Height = 25
      Caption = 'Incluir'
      TabOrder = 4
      OnClick = btnIncluirItemClick
    end
    object grdItens: TDBGrid
      Left = 72
      Top = 89
      Width = 641
      Height = 192
      DataSource = DataModulePrincipal.dsPedidoItem
      ReadOnly = True
      TabOrder = 5
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = grdItensKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGO_PRODUTO'
          Title.Caption = 'Produto'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Title.Caption = 'Descr.'
          Width = 242
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QUANTIDADE'
          Title.Caption = 'Quant.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLR_UNITARIO'
          Title.Caption = 'Vr.Un.'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLR_TOTAL'
          Title.Caption = 'Vr.Total'
          Width = 72
          Visible = True
        end>
    end
    object edtTotalPedido: TEdit
      Left = 473
      Top = 287
      Width = 104
      Height = 21
      ReadOnly = True
      TabOrder = 6
    end
  end
  object btnGravar: TButton
    Left = 536
    Top = 428
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 4
    OnClick = btnGravarClick
  end
end
