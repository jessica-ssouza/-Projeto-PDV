unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

type
  Tfrm_login = class(TForm)
    pnl_img_fundo: TPanel;
    img_fundo: TImage;
    pnl_login: TPanel;
    img_login: TImage;
    txt_usuario: TEdit;
    txt_senha: TEdit;
    btn_login: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure btn_loginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    private
  { Private declarations }
    procedure centralizarPainel;
    procedure login;

    public
  { Public declarations }
end;

var
  frm_login: Tfrm_login;

implementation

uses
  Menu, Modulo;

{$R *.dfm}

procedure Tfrm_login.btn_loginClick(Sender: TObject);
begin
  if Trim(txt_usuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usuário!', mtInformation, mbOKCancel, 0);
    txt_usuario.SetFocus;
    exit;
  end;

  if Trim(txt_senha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
    txt_senha.SetFocus;
    exit;
  end;

  login;

end;

procedure Tfrm_login.centralizarPainel;
begin
  pnl_login.Top := (self.Height div 2) - (pnl_login.Height div 2);
  pnl_login.Left := (self.Width div 2) - (pnl_login.Width div 2);
end;

procedure Tfrm_login.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  centralizarPainel;
end;

procedure Tfrm_login.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key = 13 then
  login;
end;

procedure Tfrm_login.login;
begin
  //Aqui vira código de login
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add ('SELECT * from usuarios where usuario = :usuario and senha = :senha');
  dm.query_usuarios.ParamByName('usuario').Value := txt_usuario.Text;
  dm.query_usuarios.ParamByName('senha').Value := txt_senha.Text;
  dm.query_usuarios.Open;

  if not dm.query_usuarios.isEmpty then
  begin
    nomeUsuario := dm.query_usuarios ['usuario'];
    cargoUsuario := dm.query_usuarios ['cargo'];
    frm_menu := Tfrm_menu.Create(frm_login);
    txt_senha.Text := '';
    frm_menu.ShowModal;
  end
  else
  begin
    MessageDlg('Dados incorretos!', mtInformation, mbOKCancel, 0);
    txt_senha.Text := '';
    txt_senha.SetFocus;
  end;
end;

end.
