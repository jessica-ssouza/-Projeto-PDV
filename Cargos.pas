unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids;

type
  Tfrm_cargos = class(TForm)
    grid: TDBGrid;
    btn_excluir: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_novo: TSpeedButton;
    btn_salvar: TSpeedButton;
    lb_nome: TLabel;
    txt_nome: TEdit;
    procedure btn_novoClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);

    private
  { Private declarations }
    procedure associarCampos;
    procedure listar;

    public
  { Public declarations }
end;

var
  frm_cargos: Tfrm_cargos;
  id : string;

implementation

uses
  Modulo;

{$R *.dfm}

procedure Tfrm_cargos.associarCampos;
begin
  dm.tb_cargos.FieldByName('cargo').Value := txt_nome.Text;
end;

procedure Tfrm_cargos.btn_editarClick(Sender: TObject);
var
  cargos: string ;
begin
  if Trim(txt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    txt_nome.SetFocus;
    exit;
  end;

  //Verificar se o cargo já está cadastrado
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add ('SELECT * from cargos where cargo = ' + QuotedStr(Trim(txt_nome.Text)));
  dm.query_cargos.Open;

  if not dm.query_cargos.isEmpty then
  begin
    cargos := dm.query_cargos ['cargo'];
    MessageDlg('O cargo '  + cargos + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
    txt_nome.Text := '';
    txt_nome.SetFocus;
    exit;
  end;

  associarCampos;

  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add ('UPDATE cargos set cargo = :cargo where id = :id');
  dm.query_cargos.ParamByName('cargo').Value := txt_nome.Text;
  dm.query_cargos.ParamByName('id').Value := id;
  dm.query_cargos.ExecSQL;

  listar;

  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btn_editar.Enabled := False;
  btn_excluir.Enabled := False;
  txt_nome.Text := '';
end;

procedure Tfrm_cargos.btn_excluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_cargos.Delete;
    MessageDlg('Excluído com sucesso!', mtInformation, mbOKCancel, 0);

    listar;

    btn_editar.Enabled := False;
    btn_excluir.Enabled := False;
    txt_nome.Text := '';
  end;
end;

procedure Tfrm_cargos.btn_novoClick(Sender: TObject);
begin
  btn_salvar.Enabled := True;
  txt_nome.Enabled := True;
  txt_nome.Text := '';
  txt_nome.SetFocus;

  dm.tb_cargos.Insert;
end;

procedure Tfrm_cargos.btn_salvarClick(Sender: TObject);
var
cargos: string ;
begin
  if Trim(txt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o cargo!', mtInformation, mbOKCancel, 0);
    txt_nome.SetFocus;
    exit;
  end;

  //Verificar se o cargo já está cadastrado
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add ('SELECT * from cargos where cargo = ' + QuotedStr(Trim(txt_nome.Text)));
  dm.query_cargos.Open;

  if not dm.query_cargos.isEmpty then
  begin
    cargos := dm.query_cargos ['cargo'];
    MessageDlg('O cargo '  + cargos + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
    txt_nome.Text := '';
    txt_nome.SetFocus;
    exit;
  end;

  associarCampos;

  dm.tb_cargos.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);
  txt_nome.Text := '';
  txt_nome.Enabled := False;
  btn_salvar.Enabled := False;

  listar;
end;

procedure Tfrm_cargos.FormCreate(Sender: TObject);
begin
  dm.tb_cargos.Active := True;

  listar;
end;

procedure Tfrm_cargos.gridCellClick(Column: TColumn);
begin
  txt_nome.Enabled := True;
  btn_editar.Enabled := True;
  btn_excluir.Enabled := True;

  dm.tb_cargos.Edit;

  if dm.query_cargos.FieldbyName ('cargo').Value <> null then
  txt_nome.Text := dm.query_cargos.FieldbyName ('cargo').Value;

  id := dm.query_cargos.FieldbyName ('id').Value;
end;

procedure Tfrm_cargos.listar;
begin
  dm.query_cargos.Close;
  dm.query_cargos.SQL.Clear;
  dm.query_cargos.SQL.Add ('SELECT * from cargos order by cargo asc');
  dm.query_cargos.Open;
end;

end.
