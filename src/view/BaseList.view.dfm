object FrmBaseListView: TFrmBaseListView
  Left = 0
  Top = 0
  Caption = 'Lista'
  ClientHeight = 320
  ClientWidth = 543
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 286
    Width = 543
    Height = 34
    Align = alBottom
    TabOrder = 0
    object btnIncluir: TButton
      Left = 317
      Top = 1
      Width = 75
      Height = 32
      Align = alRight
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = ActNewRecordExecute
      ExplicitLeft = 313
    end
    object btnAlterar: TButton
      Left = 392
      Top = 1
      Width = 75
      Height = 32
      Align = alRight
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = ActUpdateRecordExecute
      ExplicitLeft = 388
    end
    object btnExcluir: TButton
      Left = 467
      Top = 1
      Width = 75
      Height = 32
      Align = alRight
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = ActDeleteRecordExecute
      ExplicitLeft = 463
    end
  end
  object sgList: TStringGrid
    Left = 0
    Top = 0
    Width = 543
    Height = 286
    Align = alClient
    TabOrder = 1
    OnDblClick = ActUpdateRecordExecute
    OnDrawCell = sgListDrawCell
    OnSelectCell = sgListSelectCell
    ExplicitLeft = -1
    ExplicitTop = -5
  end
  object DtsList: TDataSource
    Left = 105
    Top = 125
  end
  object ActionList1: TActionList
    Left = 105
    Top = 201
    object ActNewRecord: TAction
      Caption = 'Novo'
      OnExecute = ActNewRecordExecute
    end
    object ActUpdateRecord: TAction
      Caption = 'Alterar'
      OnExecute = ActUpdateRecordExecute
    end
    object ActDeleteRecord: TAction
      Caption = 'Remover'
      OnExecute = ActDeleteRecordExecute
    end
    object ActRefreshList: TAction
      Caption = 'Atualizar'
      OnExecute = ActRefreshListExecute
    end
  end
end
