object DataModulePrincipal: TDataModulePrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 258
  Width = 385
  object cdsPedidoItem: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_PEDIDO'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_PRODUTO'
        DataType = ftInteger
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftFloat
      end
      item
        Name = 'VLR_UNITARIO'
        DataType = ftCurrency
      end
      item
        Name = 'VLR_TOTAL'
        DataType = ftCurrency
      end
      item
        Name = 'CONTROL'
        DataType = ftAutoInc
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 72
    Top = 136
    object cdsPedidoItemID: TIntegerField
      FieldName = 'ID'
    end
    object cdsPedidoItemNUMERO_PEDIDO: TIntegerField
      FieldName = 'NUMERO_PEDIDO'
    end
    object cdsPedidoItemCODIGO_PRODUTO: TIntegerField
      FieldName = 'CODIGO_PRODUTO'
    end
    object cdsPedidoItemQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
    end
    object cdsPedidoItemVLR_UNITARIO: TCurrencyField
      FieldName = 'VLR_UNITARIO'
    end
    object cdsPedidoItemVLR_TOTAL: TCurrencyField
      FieldName = 'VLR_TOTAL'
    end
    object cdsPedidoItemDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object cdsPedidoItemControl: TAutoIncField
      FieldName = 'Control'
    end
  end
  object dsPedidoItem: TDataSource
    DataSet = cdsPedidoItem
    Left = 72
    Top = 184
  end
  object FDConexao: TFDConnection
    Left = 96
    Top = 24
  end
  object FDTrans: TFDTransaction
    Connection = FDConexao
    Left = 192
    Top = 24
  end
end
