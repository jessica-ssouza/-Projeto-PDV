object frm_imprimirBarras: Tfrm_imprimirBarras
  Left = 0
  Top = 0
  Caption = 'Imprimir C'#243'digo de Barras'
  ClientHeight = 297
  ClientWidth = 783
  Color = clWhite
  Enabled = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 783
    Height = 41
    Align = alTop
    TabOrder = 0
    object Image6: TImage
      AlignWithMargins = True
      Left = 654
      Top = 4
      Width = 124
      Height = 33
      Align = alLeft
      ExplicitLeft = 450
      ExplicitTop = 2
    end
    object Image1: TImage
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 124
      Height = 33
      Align = alLeft
      ExplicitLeft = 0
      ExplicitTop = 2
    end
    object Image2: TImage
      AlignWithMargins = True
      Left = 134
      Top = 4
      Width = 124
      Height = 33
      Align = alLeft
      ExplicitLeft = 0
      ExplicitTop = 2
    end
    object Image3: TImage
      AlignWithMargins = True
      Left = 264
      Top = 4
      Width = 124
      Height = 33
      Align = alLeft
      ExplicitLeft = 450
      ExplicitTop = 2
    end
    object Image4: TImage
      AlignWithMargins = True
      Left = 394
      Top = 4
      Width = 124
      Height = 33
      Align = alLeft
      ExplicitLeft = 450
      ExplicitTop = 2
    end
    object Image5: TImage
      AlignWithMargins = True
      Left = 524
      Top = 4
      Width = 124
      Height = 33
      Align = alLeft
      ExplicitLeft = 450
      ExplicitTop = 2
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 728
    Top = 64
  end
end
