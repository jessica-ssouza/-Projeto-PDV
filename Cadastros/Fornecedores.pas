unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.StdCtrls, Vcl.Buttons;

type
  Tfrm_fornecedores = class(TForm)
    lb_nome: TLabel;
    lb_endereco: TLabel;
    lb_telefone: TLabel;
    lb_buscar: TLabel;
    btn_novo: TSpeedButton;
    btn_salvar: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_excluir: TSpeedButton;
    edt_buscarNome: TEdit;
    edt_endereco: TEdit;
    edt_nome: TEdit;
    edt_telefone: TMaskEdit;
    DBGrid1: TDBGrid;
    lb_cargos: TLabel;
    edt_produto: TEdit;
    procedure btn_novoClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btn_excluirClick(Sender: TObject);
    procedure edt_buscarNomeChange(Sender: TObject);

    private
  { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure buscarNome;

    public
  { Public declarations }
  end;

var
  frm_fornecedores: Tfrm_fornecedores;
  id: string;
implementation

uses
  Modulo;

{$R *.dfm}

{ Tfrm_fornecedores }

procedure Tfrm_fornecedores.associarCampos;
begin
  dm.tb_forn.FieldByName('nome').Value := edt_nome.Text;
  dm.tb_forn.FieldByName('produto').Value := edt_produto.Text;
  dm.tb_forn.FieldByName('telefone').Value := edt_telefone.Text;
  dm.tb_forn.FieldByName('endereco').Value := edt_endereco.Text;
  dm.tb_forn.FieldByName('data').Value := DateToStr(Date);
end;

procedure Tfrm_fornecedores.btn_editarClick(Sender: TObject);
begin
  if Trim(edt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    edt_nome.SetFocus;
    exit;
  end;

  associarCampos;

  dm.query_forn.Close;
  dm.query_forn.SQL.Clear;
  dm.query_forn.SQL.Add('UPDATE fornecedores set nome = :nome, produto = :produto, endereco = :endereco, telefone = :telefone where id = :id');
  dm.query_forn.ParamByName('nome').Value := edt_nome.Text;
  dm.query_forn.ParamByName('produto').Value := edt_produto.Text;
  dm.query_forn.ParamByName('endereco').Value := edt_endereco.Text;
  dm.query_forn.ParamByName('telefone').Value := edt_telefone.Text;
  dm.query_forn.ParamByName('id').Value := id;
  dm.query_forn.ExecSQL;

  listar;

  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btn_editar.Enabled := False;
  btn_excluir.Enabled := False;

  limpar;
  desabilitarCampos;
end;

procedure Tfrm_fornecedores.btn_excluirClick(Sender: TObject);
begin
   if MessageDlg('Deseja excluir o registro?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_forn.Delete;
    MessageDlg('Exclu�do com sucesso!', mtInformation, mbOKCancel, 0);

    btn_editar.Enabled := False;
    btn_excluir.Enabled := False;
    edt_nome.Text := '';

    listar;
  end;
end;

procedure Tfrm_fornecedores.btn_novoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tb_forn.Insert;
  btn_salvar.Enabled := True;
end;

procedure Tfrm_fornecedores.btn_salvarClick(Sender: TObject);
begin
  if Trim(edt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    edt_nome.SetFocus;
    exit;
  end;

  associarCampos;

  dm.tb_forn.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);

  limpar;
  desabilitarCampos;

  btn_salvar.Enabled := False;

  listar;
end;

procedure Tfrm_fornecedores.buscarNome;
begin
  dm.query_forn.Close;
  dm.query_forn.SQL.Clear;
  dm.query_forn.SQL.Add ('SELECT * from fornecdores where nome LIKE :nome order by nome asc');
  dm.query_forn.ParamByName('nome').Value := edt_buscarNome.Text + '%' ;
  dm.query_func.Open;
end;

procedure Tfrm_fornecedores.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;

  btn_editar.Enabled := True;
  btn_excluir.Enabled := True;

  dm.tb_forn.Edit;

  edt_nome.Text := dm.query_forn.FieldbyName ('nome').Value;
  edt_produto.Text := dm.query_forn.FieldbyName ('produto').Value;

  if dm.query_forn.FieldbyName ('telefone').Value <> null then
  edt_telefone.Text := dm.query_func.FieldbyName ('telefone').Value;

  if dm.query_forn.FieldbyName ('endereco').Value <> null then
  edt_endereco.Text := dm.query_func.FieldbyName ('endereco').Value;

  id := dm.query_forn.FieldbyName ('id').Value;
end;

procedure Tfrm_fornecedores.desabilitarCampos;
begin
  edt_nome.Enabled := False;
  edt_produto.Enabled := False;
  edt_endereco.Enabled := False;
  edt_telefone.Enabled := False;
end;

procedure Tfrm_fornecedores.edt_buscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure Tfrm_fornecedores.FormShow(Sender: TObject);
begin
  desabilitarCampos;

  dm.tb_forn.Active := True;

  listar;
end;

procedure Tfrm_fornecedores.habilitarCampos;
begin
  edt_nome.Enabled := True;
  edt_produto.Enabled := True;
  edt_endereco.Enabled := True;
  edt_telefone.Enabled := True;
end;

procedure Tfrm_fornecedores.limpar;
begin
  edt_nome.Text := '';
  edt_produto.Text := '';
  edt_endereco.Text := '';
  edt_telefone.Text := '';
end;

procedure Tfrm_fornecedores.listar;
begin
  dm.query_forn.Close;
  dm.query_forn.SQL.Clear;
  dm.query_forn.SQL.Add ('SELECT * from fornecedores order by nome asc');
  dm.query_forn.Open;
end;

end.
