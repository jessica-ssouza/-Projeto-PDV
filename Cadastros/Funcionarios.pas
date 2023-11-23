unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons;

type
  Tfrm_funcionarios = class(TForm)
    edt_buscarNome: TEdit;
    rb_nome: TRadioButton;
    rb_cpf: TRadioButton;
    edt_buscarCpf: TMaskEdit;
    edt_endereco: TEdit;
    edt_nome: TEdit;
    lb_nome: TLabel;
    edt_telefone: TMaskEdit;
    cb_cargo: TComboBox;
    lb_endereco: TLabel;
    lb_telefone: TLabel;
    lb_buscar: TLabel;
    lb_cargo: TLabel;
    DBGrid1: TDBGrid;
    btn_novo: TSpeedButton;
    edt_cpf: TMaskEdit;
    lb_cpf: TLabel;
    btn_salvar: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_excluir: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure edt_buscarCpfChange(Sender: TObject);
    procedure edt_buscarNomeChange(Sender: TObject);
    procedure rb_nomeClick(Sender: TObject);
    procedure rb_cpfClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);

    private
  { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure carregarCombobox;
    procedure buscarNome;
    procedure buscarCpf;

    public
  { Public declarations }
end;

var
  frm_funcionarios: Tfrm_funcionarios;
  id: string;
  cpfAntigo: string;
implementation

uses
  Modulo;

{$R *.dfm}

{ Tfrm_funcionarios }

procedure Tfrm_funcionarios.associarCampos;
begin
  dm.tb_func.FieldByName('nome').Value := edt_nome.Text;
  dm.tb_func.FieldByName('cpf').Value := edt_cpf.Text;
  dm.tb_func.FieldByName('telefone').Value := edt_telefone.Text;
  dm.tb_func.FieldByName('endereco').Value := edt_endereco.Text;
  dm.tb_func.FieldByName('cargo').Value := cb_cargo.Text;
  dm.tb_func.FieldByName('data').Value := DateToStr(Date);
end;

procedure Tfrm_funcionarios.btn_editarClick(Sender: TObject);
var
  cpf: string ;
begin
  if Trim(edt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    edt_nome.SetFocus;
    exit;
  end;

  if Trim(edt_cpf.Text) = '' then
  begin
    MessageDlg('Preencha o cpf!', mtInformation, mbOKCancel, 0);
    edt_cpf.SetFocus;
    exit;
  end;

  if cpfAntigo <> edt_cpf.Text then
  begin
    //Verificar se o cpf j� est� cadastrado
    dm.query_func.Close;
    dm.query_func.SQL.Clear;
    dm.query_func.SQL.Add ('SELECT * from funcionarios where cpf = ' + QuotedStr(Trim(edt_cpf.Text)));
    dm.query_func.Open;

    if not dm.query_func.isEmpty then
    begin
      cpf := dm.query_func ['cpf'];
      MessageDlg('O cpf '  + cpf + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
      edt_cpf.Text := '';
      edt_cpf.SetFocus;
      exit;
    end;
  end;

  associarCampos;

  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add('UPDATE funcionarios set nome = :nome, cpf = :cpf, endereco = :endereco, telefone = :telefone, cargo = :cargo where id = :id');
  dm.query_func.ParamByName('nome').Value := edt_nome.Text;
  dm.query_func.ParamByName('cpf').Value := edt_cpf.Text;
  dm.query_func.ParamByName('endereco').Value := edt_endereco.Text;
  dm.query_func.ParamByName('telefone').Value := edt_telefone.Text;
  dm.query_func.ParamByName('cargo').Value := cb_cargo.Text;
  dm.query_func.ParamByName('id').Value := id;
  dm.query_func.ExecSQL;

  //Editar o cargo do usu�rio
  dm.query_usuarios.Close;
  dm.query_usuarios.SQL.Clear;
  dm.query_usuarios.SQL.Add('UPDATE usuarios set cargo = :cargo where id_funcionario = :id');
  dm.query_usuarios.ParamByName('cargo').Value := cb_cargo.Text;
  dm.query_usuarios.ParamByName('id').Value := id;
  dm.query_usuarios.ExecSQL;

  listar;

  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btn_editar.Enabled := False;
  btn_excluir.Enabled := False;

  limpar;
  desabilitarCampos;
end;

procedure Tfrm_funcionarios.btn_excluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_func.Delete;
    MessageDlg('Exclu�do com sucesso!', mtInformation, mbOKCancel, 0);

    btn_editar.Enabled := False;
    btn_excluir.Enabled := False;
    edt_nome.Text := '';

    //Deletar tamb�m o usu�rio associado a ele
    dm.query_usuarios.Close;
    dm.query_usuarios.SQL.Clear;

    dm.query_usuarios.ParamByName('id').Value := id;;
    dm.query_usuarios.Execute;

  end;
end;

procedure Tfrm_funcionarios.btn_novoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tb_func.Insert;
  btn_salvar.Enabled := True;
end;

procedure Tfrm_funcionarios.btn_salvarClick(Sender: TObject);
 var
cpf: string ;
begin
  if Trim(edt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    edt_nome.SetFocus;
    exit;
  end;

  if Trim(edt_cpf.Text) = '' then
  begin
    MessageDlg('Preencha o cpf!', mtInformation, mbOKCancel, 0);
    edt_cpf.SetFocus;
    exit;
  end;

  //Verificar se o cpf j� est� cadastrado
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add ('SELECT * from funcionarios where cpf = ' + QuotedStr(Trim(edt_cpf.Text)));
  dm.query_func.Open;

  if not dm.query_func.isEmpty then
  begin
    cpf := dm.query_func ['cpf'];
    MessageDlg('O cpf '  + cpf + ' j� est� cadastrado!', mtInformation, mbOKCancel, 0);
    edt_cpf.Text := '';
    edt_cpf.SetFocus;
    exit;
  end;

  associarCampos;

  dm.tb_func.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);

  limpar;
  desabilitarCampos;

  btn_salvar.Enabled := False;

  listar;
end;

procedure Tfrm_funcionarios.buscarCpf;
begin
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add ('SELECT * from funcionarios where cpf = :cpf order by nome asc');
  dm.query_func.ParamByName('cpf').Value := edt_buscarCpf.Text;
  dm.query_func.Open;
end;

procedure Tfrm_funcionarios.buscarNome;
begin
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add ('SELECT * from funcionarios where nome LIKE :nome order by nome asc');
  dm.query_func.ParamByName('nome').Value := edt_buscarNome.Text + '%' ;
  dm.query_func.Open;
end;

procedure Tfrm_funcionarios.carregarCombobox;
begin
  dm.query_cargos.Close;
  dm.query_cargos.Open;
  if not dm.query_cargos.isEmpty then
  begin
    while not dm.query_cargos.Eof do
    begin
      cb_cargo.Items.Add(dm.query_cargos.FieldByName('cargo').AsString);
      dm.query_cargos.Next;
    end;
  end;
end;

procedure Tfrm_funcionarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;

  btn_editar.Enabled := True;
  btn_excluir.Enabled := True;

  dm.tb_func.Edit;

  if dm.query_func.FieldbyName ('nome').Value <> null then
  edt_nome.Text := dm.query_func.FieldbyName ('nome').Value;

  edt_cpf.Text := dm.query_func.FieldbyName ('cpf').Value;

  cb_cargo.Text := dm.query_func.FieldbyName ('cargo').Value;

  if dm.query_func.FieldbyName ('telefone').Value <> null then
  edt_telefone.Text := dm.query_func.FieldbyName ('telefone').Value;

  if dm.query_func.FieldbyName ('endereco').Value <> null then
  edt_endereco.Text := dm.query_func.FieldbyName ('endereco').Value;

  id := dm.query_func.FieldbyName ('id').Value;
  cpfAntigo := dm.query_func.FieldbyName ('cpf').Value;
end;

procedure Tfrm_funcionarios.DBGrid1DblClick(Sender: TObject);
begin
  if chamada = 'Func' then
  begin
    idFunc := dm.query_func.FieldbyName ('id').Value;
    nomeFunc := dm.query_func.FieldbyName ('nome').Value;
    cargoFunc:= dm.query_func.FieldbyName ('cargo').Value;
    Close;
    chamada := '';
  end;
end;

procedure Tfrm_funcionarios.desabilitarCampos;
begin
  edt_nome.Enabled := False;
  edt_cpf.Enabled := False;
  edt_endereco.Enabled := False;
  edt_telefone.Enabled := False;
  cb_cargo.Enabled := False;
end;

procedure Tfrm_funcionarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  dm.tb_func.Active := True;

  listar;

  carregarCombobox;
  cb_cargo.ItemIndex := 0;
  edt_buscarCpf.Visible := False;
  rb_nome.Checked := True;
end;

procedure Tfrm_funcionarios.habilitarCampos;
begin
  edt_nome.Enabled := True;
  edt_cpf.Enabled := True;
  edt_endereco.Enabled := True;
  edt_telefone.Enabled := True;
  cb_cargo.Enabled := True;
end;

procedure Tfrm_funcionarios.limpar;
begin
  edt_nome.Text := '';
  edt_cpf.Text := '';
  edt_endereco.Text := '';
  edt_telefone.Text := '';
end;

procedure Tfrm_funcionarios.listar;
begin
  dm.query_func.Close;
  dm.query_func.SQL.Clear;
  dm.query_func.SQL.Add ('SELECT * from funcionarios order by nome asc');
  dm.query_func.Open;
end;

procedure Tfrm_funcionarios.rb_cpfClick(Sender: TObject);
begin
  listar;

  edt_buscarCpf.Visible := True;
  edt_buscarNome.Visible := False;
end;

procedure Tfrm_funcionarios.rb_nomeClick(Sender: TObject);
begin
  listar;

  edt_buscarCpf.Visible := False;
  edt_buscarNome.Visible := True;
end;

procedure Tfrm_funcionarios.edt_buscarCpfChange(Sender: TObject);

begin
  buscarCpf;
end;

procedure Tfrm_funcionarios.edt_buscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

end.
