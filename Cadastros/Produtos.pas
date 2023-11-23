unit Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask;

type
  Tfrm_produtos = class(TForm)
    lb_nome: TLabel;
    btn_novo: TSpeedButton;
    btn_salvar: TSpeedButton;
    btn_editar: TSpeedButton;
    btn_excluir: TSpeedButton;
    lb_cargos: TLabel;
    edt_nome: TEdit;
    DBGrid1: TDBGrid;
    edt_descricao: TEdit;
    Label1: TLabel;
    img_cod: TImage;
    Label2: TLabel;
    edt_valor: TEdit;
    img: TImage;
    btn_add: TSpeedButton;
    Panel1: TPanel;
    btn_imprimir: TSpeedButton;
    edt_codigo: TMaskEdit;
    Panel2: TPanel;
    btn_gerarCodigo: TSpeedButton;
    lb_buscar: TLabel;
    edt_buscarNome: TEdit;
    rb_nome: TRadioButton;
    rb_codigo: TRadioButton;
    edt_buscarCodigo: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure edt_codigoChange(Sender: TObject);
    procedure btn_novoClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_imprimirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btn_gerarCodigoClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure rb_nomeClick(Sender: TObject);
    procedure rb_codigoClick(Sender: TObject);
    procedure edt_buscarNomeChange(Sender: TObject);

    private
  { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;
    procedure associarCampos;
    procedure listar;
    procedure buscarNome;
    procedure buscarCodigo;
    procedure gerarCodigo (codigo: string; Canvas: TCanvas);

    public
  { Public declarations }

end;
var
  frm_produtos: Tfrm_produtos;
  id: string;

implementation

uses
  Modulo, ImprimirBarras;

{$R *.dfm}

{ Tfrm_produtos }

procedure Tfrm_produtos.associarCampos;
begin
  dm.tb_produtos.FieldByName('nome').Value := edt_nome.Text;
  dm.tb_produtos.FieldByName('descricao').Value := edt_descricao.Text;
  dm.tb_produtos.FieldByName('codigo').Value := edt_codigo.Text;
  dm.tb_produtos.FieldByName('valor').Value := edt_valor.Text;
  dm.tb_produtos.FieldByName('data').Value := DateToStr(Date);
end;

procedure Tfrm_produtos.btn_editarClick(Sender: TObject);
begin
  if Trim(edt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    edt_nome.SetFocus;
    exit;
  end;

  associarCampos;

  dm.query_produtos.Close;
  dm.query_produtos.SQL.Clear;
  dm.query_produtos.SQL.Add('UPDATE produtos set nome = :nome, descricao = :descricao, codigo = :codigo, valor = :valor where id = :id');
  dm.query_produtos.ParamByName('nome').Value := edt_nome.Text;
  dm.query_produtos.ParamByName('descricao').Value := edt_descricao.Text;
  dm.query_produtos.ParamByName('codigo').Value := edt_codigo.Text;
  dm.query_produtos.ParamByName('valor').Value := StrToFloat (edt_valor.Text);
  dm.query_produtos.ParamByName('id').Value := id;
  dm.query_produtos.ExecSQL;

  listar;

  MessageDlg('Editado com sucesso!', mtInformation, mbOKCancel, 0);
  btn_editar.Enabled := False;
  btn_excluir.Enabled := False;

  limpar;
  desabilitarCampos;
end;

procedure Tfrm_produtos.btn_excluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro?' , mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.tb_produtos.Delete;
    MessageDlg('Excluído com sucesso!', mtInformation, mbOKCancel, 0);

    btn_editar.Enabled := False;
    btn_excluir.Enabled := False;
    edt_nome.Text := '';

    listar;
  end;
end;

procedure Tfrm_produtos.btn_gerarCodigoClick(Sender: TObject);
var
cod: string;
begin
  //Verificar se o código já está cadastrado
  dm.query_coringa.Close;
  dm.query_coringa.SQL.Clear;
  dm.query_coringa.SQL.Add ('SELECT * from produtos where codigo = ' + edt_codigo.Text);
  dm.query_coringa.Open;

  if not dm.query_coringa.isEmpty then
  begin
    cod := dm.query_coringa ['codigo'];
    MessageDlg('O código'  + cod + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
    edt_codigo.Text := '';
    edt_codigo.SetFocus;
    exit;
  end;

  gerarCodigo(edt_codigo.Text, img_cod.Canvas);
  btn_salvar.Enabled := True;
end;

procedure Tfrm_produtos.btn_imprimirClick(Sender: TObject);
begin
  frm_imprimirBarras := TFrm_imprimirBarras.Create(self);
  frm_imprimirBarras.ShowModal;
end;

procedure Tfrm_produtos.btn_novoClick(Sender: TObject);
begin
  habilitarCampos;
  dm.tb_produtos.Insert;
  btn_gerarCodigo.Enabled := True;
  btn_salvar.Enabled := True;
end;

procedure Tfrm_produtos.btn_salvarClick(Sender: TObject);
begin
  if Trim(edt_nome.Text) = '' then
  begin
    MessageDlg('Preencha o nome!', mtInformation, mbOKCancel, 0);
    edt_nome.SetFocus;
    exit;
  end;
  if Trim(edt_codigo.Text) = '' then
  begin
    MessageDlg('Preencha o código!', mtInformation, mbOKCancel, 0);
    edt_codigo.SetFocus;
    exit;
  end;

  associarCampos;

  dm.tb_produtos.Post;
  MessageDlg('Salvo com sucesso!', mtInformation, mbOKCancel, 0);

  limpar;
  desabilitarCampos;

  btn_salvar.Enabled := False;

  listar;
end;

procedure Tfrm_produtos.buscarCodigo;
begin
  dm.query_produtos.Close;
  dm.query_produtos.SQL.Clear;
  dm.query_produtos.SQL.Add ('SELECT * from produtos where codigo Like :codigo order by nome asc');
  dm.query_produtos.ParamByName('codigo').Value := edt_buscarCodigo.Text + '%';
  dm.query_produtos.Open;
end;

procedure Tfrm_produtos.buscarNome;
begin
  dm.query_produtos.Close;
  dm.query_produtos.SQL.Clear;
  dm.query_produtos.SQL.Add ('SELECT * from produtos where nome LIKE :nome order by nome asc');
  dm.query_produtos.ParamByName('nome').Value := edt_buscarNome.Text + '%' ;
  dm.query_produtos.Open;
end;

procedure Tfrm_produtos.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;

  btn_editar.Enabled := True;
  btn_excluir.Enabled := True;
  btn_imprimir.Enabled := True;
  btn_gerarCodigo.Enabled := True;

  dm.tb_produtos.Edit;

  edt_nome.Text := dm.query_produtos.FieldbyName ('nome').Value;
  edt_descricao.Text := dm.query_produtos.FieldbyName ('descricao').Value;
  edt_valor.Text := dm.query_produtos.FieldbyName ('valor').Value;
  edt_codigo.Text := dm.query_produtos.FieldbyName ('codigo').Value;
  gerarCodigo(edt_codigo.Text, img.Canvas);


  id := dm.query_produtos.FieldbyName ('id').Value;
  codigoProduto := dm.query_produtos.FieldbyName ('codigo').Value;
end;

procedure Tfrm_produtos.desabilitarCampos;
begin
  edt_nome.Enabled := False;
  edt_descricao.Enabled := False;
  edt_codigo.Enabled := False;
  edt_valor.Enabled := False;
end;

procedure Tfrm_produtos.edt_buscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure Tfrm_produtos.edt_codigoChange(Sender: TObject);
begin
  buscarCodigo;
end;

procedure Tfrm_produtos.FormShow(Sender: TObject);
begin
  desabilitarCampos;

  dm.tb_produtos.Active := True;

  listar;

  rb_nome.Checked;
  edt_buscarCodigo.Visible := False;
end;

procedure Tfrm_produtos.gerarCodigo(codigo: string; Canvas: TCanvas);
const
digitos : array['0'..'9'] of string[5]= ('00110', '10001', '01001', '11000',
'00101', '10100', '01100', '00011', '10010', '01010');
var s : string;
i, j, x, t : Integer;
begin
  //Gerar o valor para desenhar o código de barras
  //Caracter de início
  s := '0000';
  for i := 1 to length(codigo) div 2 do
  for j := 1 to 5 do
  s := s + Copy(Digitos[codigo[i * 2 - 1]], j, 1) + Copy(Digitos[codigo[i * 2]], j, 1);
  //Caracter de fim
  s := s + '100';
  //Desenhar em um objeto canvas
  //Configurar os parâmetros iniciais
  x := 0;
  //Pintar o fundo do código de branco
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clWhite;
  Canvas.Rectangle(10, 10, 500, 50);
  //Definir as cores da caneta
  Canvas.Brush.Color := clBlack;
  Canvas.Pen.Color := clBlack;
  //Escrever o código de barras no canvas
  for i := 1 to length(s) do
  begin
    //Definir a espessura da barra
    t := strToInt(s[i]) * 2 + 1;
    //Imprimir apenas barra sim barra não (preto/branco - intercalado);
    if i mod 2 = 1 then
    Canvas.Rectangle(x, 0, x + t, 50);
    //Passar para a próxima barra
    x := x + t;
  end;
end;

procedure Tfrm_produtos.habilitarCampos;
begin
  edt_nome.Enabled := True;
  edt_descricao.Enabled := True;
  edt_codigo.Enabled := True;
  edt_valor.Enabled := True;
end;

procedure Tfrm_produtos.limpar;
begin
  edt_nome.Text := '';
  edt_descricao.Text := '';
  edt_codigo.Text := '';
  edt_valor.Text := '';
end;

procedure Tfrm_produtos.listar;
begin
  dm.query_produtos.Close;
  dm.query_produtos.SQL.Clear;
  dm.query_produtos.SQL.Add ('SELECT * from produtos order by nome asc');
  dm.query_produtos.Open;
end;

procedure Tfrm_produtos.rb_codigoClick(Sender: TObject);
begin
  listar;

  edt_buscarCodigo.Visible := True;
  edt_buscarNome.Visible := False;
  edt_buscarCodigo.SetFocus;
end;

procedure Tfrm_produtos.rb_nomeClick(Sender: TObject);
begin
  listar;

  edt_buscarCodigo.Visible := False;
  edt_buscarNome.Visible := True;
  edt_buscarNome.SetFocus;
end;

end.

