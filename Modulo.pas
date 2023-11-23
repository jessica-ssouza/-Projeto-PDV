unit Modulo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet;

type
  Tdm = class(TDataModule)
    fd: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    tb_cargos: TFDTable;
    query_cargos: TFDQuery;
    query_cargosid: TFDAutoIncField;
    query_cargoscargo: TStringField;
    ds_cargos: TDataSource;
    tb_cargosid: TFDAutoIncField;
    tb_cargoscargo: TStringField;
    tb_func: TFDTable;
    query_func: TFDQuery;
    ds_func: TDataSource;
    query_funcid: TFDAutoIncField;
    query_funcnome: TStringField;
    query_funccpf: TStringField;
    query_functelefone: TStringField;
    query_funcendereco: TStringField;
    query_funccargo: TStringField;
    query_funcdata: TDateField;
    tb_usuarios: TFDTable;
    query_usuarios: TFDQuery;
    query_usuariosid: TIntegerField;
    query_usuariosnome: TStringField;
    query_usuariosusuario: TStringField;
    query_usuariossenha: TStringField;
    query_usuarioscargo: TStringField;
    query_usuariosid_funcionario: TIntegerField;
    ds_usuarios: TDataSource;
    tb_usuariosid: TIntegerField;
    tb_usuariosnome: TStringField;
    tb_usuariosusuario: TStringField;
    tb_usuariossenha: TStringField;
    tb_usuarioscargo: TStringField;
    tb_usuariosid_funcionario: TIntegerField;
    tb_forn: TFDTable;
    query_forn: TFDQuery;
    ds_forn: TDataSource;
    query_fornid: TFDAutoIncField;
    query_fornnome: TStringField;
    query_fornproduto: TStringField;
    query_fornendereco: TStringField;
    query_forntelefone: TStringField;
    query_forndata: TDateField;
    tb_produtos: TFDTable;
    query_produtos: TFDQuery;
    ds_produtos: TDataSource;
    query_produtosid: TFDAutoIncField;
    query_produtoscodigo: TStringField;
    query_produtosnome: TStringField;
    query_produtosdescricao: TStringField;
    query_produtosvalor: TBCDField;
    query_produtosestoque: TIntegerField;
    query_produtosdata: TDateField;
    query_produtosimagem: TBlobField;
    query_coringa: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    private
  { Private declarations }

    public
  { Public declarations }
end;

var
  dm: Tdm;

  //Declaração de variáveis globais
  idFunc: string;
  nomeFunc: string;
  cargoFunc: string;

  chamada: string;

  nomeUsuario: string;
  cargoUsuario: string;

  codigoProduto: string;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  fd.Connected := True;
end;

end.
