object FormMain: TFormMain
  Left = 0
  Top = 0
  ClientHeight = 157
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 64
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Progress'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Error'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 256
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Success'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 160
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Complete'
    TabOrder = 3
    OnClick = Button4Click
  end
end
