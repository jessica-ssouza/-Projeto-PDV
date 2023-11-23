unit Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  Tfrm_menu = class(TForm)
    frm_menu1: TMainMenu;
    Cadastros1: TMenuItem;
    Produtos1: TMenuItem;
    Fornecedores1: TMenuItem;
    Estoque1: TMenuItem;
    Movimentaes1: TMenuItem;
    Relatrios1: TMenuItem;
    Sair1: TMenuItem;
    Usuarios1: TMenuItem;
    Funcionrios1: TMenuItem;
    Cargos1: TMenuItem;
    Sair2: TMenuItem;
    procedure Usuarios1Click(Sender: TObject);
    procedure Funcionrios1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Fornecedores1Click(Sender: TObject);
    procedure Sair2Click(Sender: TObject);
    procedure Produtos1Click(Sender: TObject);

    private
  { Private declarations }

    public
  { Public declarations }
end;

var
  frm_menu: Tfrm_menu;

implementation

uses
  Usuarios, Funcionarios, Cargos, Modulo, Fornecedores, Produtos;

{$R *.dfm}

procedure Tfrm_menu.Cargos1Click(Sender: TObject);
begin
  frm_cargos := TFrm_cargos.Create(self);
  frm_cargos.ShowModal;
end;

procedure Tfrm_menu.FormShow(Sender: TObject);
begin
if (nomeUsuario = 'admin') or (cargoUsuario = 'gerente') then
  Usuarios1.Enabled := True;
end;

procedure Tfrm_menu.Fornecedores1Click(Sender: TObject);
begin
  frm_fornecedores:= Tfrm_fornecedores.Create(self);
  frm_fornecedores.ShowModal;
end;

procedure Tfrm_menu.Funcionrios1Click(Sender: TObject);
begin
  frm_funcionarios:= TFrm_funcionarios.Create(self);
  frm_funcionarios.ShowModal;
end;

procedure Tfrm_menu.Produtos1Click(Sender: TObject);
begin
  frm_produtos := TFrm_produtos.Create(self);
  frm_produtos.ShowModal;
end;

procedure Tfrm_menu.Sair2Click(Sender: TObject);
begin
  Close;
end;

procedure TFrm_menu.Usuarios1Click(Sender: TObject);
begin
  frm_usuarios := TFrm_usuarios.Create(self);
  frm_usuarios.ShowModal;
end;

end.
