object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'FuelTrack Station Manager'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mMainMenu
  Position = poMainFormCenter
  TextHeight = 15
  object mMainMenu: TMainMenu
    Left = 568
    Top = 8
    object Cadastros1: TMenuItem
      Caption = 'Cadastros'
      object anques1: TMenuItem
        Caption = 'Tanques'
        OnClick = anques1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Bombas1: TMenuItem
        Caption = 'Bombas'
        OnClick = Bombas1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Abastecimentos1: TMenuItem
        Caption = 'Abastecimentos'
        OnClick = Abastecimentos1Click
      end
    end
    object Relatrios1: TMenuItem
      Caption = 'Relat'#243'rios'
      object otais1: TMenuItem
        Caption = 'Totais'
        OnClick = otais1Click
      end
    end
  end
end
