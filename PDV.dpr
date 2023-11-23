program PDV;

uses
  Vcl.Forms,
  Login in 'Login.pas' {frm_login},
  Menu in 'Menu.pas' {frm_menu},
  Usuarios in 'Cadastros\Usuarios.pas' {frm_usuarios},
  Funcionarios in 'Cadastros\Funcionarios.pas' {frm_funcionarios},
  Cargos in 'Cargos.pas' {frm_cargos},
  Modulo in 'Modulo.pas' {dm: TDataModule},
  Fornecedores in 'Cadastros\Fornecedores.pas' {frm_fornecedores},
  Produtos in 'Cadastros\Produtos.pas' {frm_produtos},
  ImprimirBarras in 'Cadastros\ImprimirBarras.pas' {frm_imprimirBarras};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_login, frm_login);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_fornecedores, frm_fornecedores);
  Application.CreateForm(Tfrm_produtos, frm_produtos);
  Application.CreateForm(Tfrm_imprimirBarras, frm_imprimirBarras);
  Application.Run;
end.
