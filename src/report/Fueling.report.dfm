object FrmFuelingReport: TFrmFuelingReport
  Left = 0
  Top = 0
  Caption = 'Abastecimentos'
  ClientHeight = 834
  ClientWidth = 842
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object RepFuelings: TRLReport
    Left = 20
    Top = 18
    Width = 794
    Height = 1123
    DataSource = DtsFuelings
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 73
      BandType = btTitle
      object RLLabel1: TRLLabel
        Left = 3
        Top = 15
        Width = 270
        Height = 22
        Caption = 'Relat'#243'rio de Abastecimentos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel2: TRLLabel
        Left = 3
        Top = 51
        Width = 33
        Height = 16
        Caption = 'Data'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel3: TRLLabel
        Left = 153
        Top = 51
        Width = 52
        Height = 16
        Caption = 'Tanque'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel4: TRLLabel
        Left = 223
        Top = 51
        Width = 49
        Height = 16
        Caption = 'Bomba'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLLabel5: TRLLabel
        Left = 297
        Top = 51
        Width = 112
        Height = 16
        Caption = 'Valor Abastecido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 111
      Width = 718
      Height = 30
      object RLDBText1: TRLDBText
        Left = 3
        Top = 8
        Width = 144
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'DateOfFueling'
        DataSource = DtsFuelings
        DisplayMask = 'dd/MM/yyyy'
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 153
        Top = 8
        Width = 60
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'TankID'
        DataSource = DtsFuelings
        DisplayMask = '0000'
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 223
        Top = 8
        Width = 60
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'PumpID'
        DataSource = DtsFuelings
        DisplayMask = '0000'
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 297
        Top = 8
        Width = 103
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'TotalFueled'
        DataSource = DtsFuelings
        DisplayMask = ',#0.00'
        Text = ''
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 141
      Width = 718
      Height = 45
      BandType = btSummary
      object RLLabel6: TRLLabel
        Left = 177
        Top = 14
        Width = 82
        Height = 16
        Alignment = taRightJustify
        Caption = 'Valor Total :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDBResult1: TRLDBResult
        Left = 306
        Top = 14
        Width = 103
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'TotalFueled'
        DataSource = DtsFuelings
        DisplayMask = ',#0.00'
        Info = riSum
        Text = ''
      end
    end
  end
  object DtsFuelings: TDataSource
    DataSet = QryFuelings
    Left = 270
    Top = 305
  end
  object QryFuelings: TFDQuery
    Connection = DtmConnection.FDConnection1
    SQL.Strings = (
      'SELECT'
      '    Fueling.FuelingDate AS DateOfFueling,'
      '    Fueling.PumpID AS PumpID,'
      '    Pump.TankID AS TankID,'
      '    SUM(Fueling.FueledValue) AS TotalFueled'
      'FROM'
      '    Fueling AS Fueling'
      '    INNER JOIN Pump ON Pump.ID = Fueling.PumpID'
      'GROUP BY'
      '    Fueling.FuelingDate,'
      '    Fueling.PumpID,'
      '    Pump.TankID'
      '')
    Left = 270
    Top = 244
    object QryFuelingsDateOfFueling: TDateTimeField
      FieldName = 'DateOfFueling'
      Origin = 'FuelingDate'
      Required = True
    end
    object QryFuelingsPumpID: TIntegerField
      FieldName = 'PumpID'
      Origin = 'PumpId'
      Required = True
    end
    object QryFuelingsTankID: TIntegerField
      AutoGenerateValue = arDefault
      FieldName = 'TankID'
      Origin = 'TankID'
      ProviderFlags = []
      ReadOnly = True
    end
    object QryFuelingsTotalFueled: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'TotalFueled'
      Origin = 'TotalFueled'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
