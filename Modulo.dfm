object dm: Tdm
  OnCreate = DataModuleCreate
  Height = 503
  Width = 806
  object fd: TFDConnection
    Params.Strings = (
      'Database=pdv'
      'User_Name=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 24
    Top = 8
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Jessica Souza\Documents\Embarcadero\Studio\Projects\PDV' +
      '\Win32\Debug\libmySQL.dll'
    Left = 688
    Top = 8
  end
  object tb_cargos: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.cargos'
    TableName = 'pdv.cargos'
    Left = 32
    Top = 168
    object tb_cargosid: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object tb_cargoscargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
  end
  object query_cargos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from cargos order by cargo asc')
    Left = 32
    Top = 280
    object query_cargosid: TFDAutoIncField
      DisplayLabel = 'ID'
      DisplayWidth = 7
      FieldName = 'id'
      Origin = 'ID'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object query_cargoscargo: TStringField
      DisplayLabel = 'Cargo'
      FieldName = 'cargo'
      Origin = 'Cargo'
      Required = True
    end
  end
  object ds_cargos: TDataSource
    DataSet = query_cargos
    Left = 96
    Top = 280
  end
  object tb_func: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.`funcionarios`'
    TableName = 'pdv.`funcionarios`'
    Left = 80
    Top = 168
  end
  object query_func: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from funcionarios order by funcionarios asc')
    Left = 192
    Top = 280
    object query_funcid: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_funcnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object query_funccpf: TStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 15
      FieldName = 'cpf'
      Origin = 'cpf'
      Required = True
    end
    object query_functelefone: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'telefone'
      Origin = 'telefone'
      Size = 15
    end
    object query_funcendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'endereco'
      Origin = 'endereco'
      Size = 50
    end
    object query_funccargo: TStringField
      DisplayLabel = 'Cargo'
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_funcdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = '`data`'
      Required = True
    end
  end
  object ds_func: TDataSource
    DataSet = query_func
    Left = 248
    Top = 280
  end
  object tb_usuarios: TFDTable
    IndexFieldNames = 'id'
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.usuarios'
    TableName = 'pdv.usuarios'
    Left = 136
    Top = 168
    object tb_usuariosid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object tb_usuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 30
    end
    object tb_usuariosusuario: TStringField
      FieldName = 'usuario'
      Origin = 'usuario'
      Required = True
      Size = 25
    end
    object tb_usuariossenha: TStringField
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object tb_usuarioscargo: TStringField
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object tb_usuariosid_funcionario: TIntegerField
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      Required = True
    end
  end
  object query_usuarios: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from usuarios')
    Left = 336
    Top = 280
    object query_usuariosid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Visible = False
    end
    object query_usuariosnome: TStringField
      FieldName = 'nome'
      Origin = 'Nome'
      Required = True
      Size = 25
    end
    object query_usuariosusuario: TStringField
      DisplayWidth = 15
      FieldName = 'usuario'
      Origin = 'Usuario'
      Required = True
      Size = 25
    end
    object query_usuariossenha: TStringField
      DisplayWidth = 10
      FieldName = 'senha'
      Origin = 'senha'
      Required = True
      Size = 25
    end
    object query_usuarioscargo: TStringField
      DisplayWidth = 15
      FieldName = 'cargo'
      Origin = 'cargo'
      Required = True
      Size = 25
    end
    object query_usuariosid_funcionario: TIntegerField
      FieldName = 'id_funcionario'
      Origin = 'id_funcionario'
      Required = True
      Visible = False
    end
  end
  object ds_usuarios: TDataSource
    DataSet = query_usuarios
    Left = 408
    Top = 280
  end
  object tb_forn: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.fornecedores'
    TableName = 'pdv.fornecedores'
    Left = 192
    Top = 168
  end
  object query_forn: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select * from fornecedores ')
    Left = 488
    Top = 280
    object query_fornid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_fornnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 13
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 25
    end
    object query_fornproduto: TStringField
      DisplayLabel = 'Produto'
      DisplayWidth = 15
      FieldName = 'produto'
      Origin = 'produto'
      Required = True
      Size = 25
    end
    object query_fornendereco: TStringField
      DisplayLabel = 'Endere'#231'o'
      DisplayWidth = 20
      FieldName = 'endereco'
      Origin = 'endereco'
      Required = True
      Size = 30
    end
    object query_forntelefone: TStringField
      DisplayLabel = 'Telefone'
      DisplayWidth = 16
      FieldName = 'telefone'
      Origin = 'telefone'
      Required = True
      Size = 15
    end
    object query_forndata: TDateField
      DisplayLabel = ' Data de Cadastro'
      DisplayWidth = 12
      FieldName = 'data'
      Origin = '`data`'
      Required = True
    end
  end
  object ds_forn: TDataSource
    DataSet = query_forn
    Left = 544
    Top = 280
  end
  object tb_produtos: TFDTable
    Connection = fd
    UpdateOptions.UpdateTableName = 'pdv.produtos'
    TableName = 'pdv.produtos'
    Left = 256
    Top = 168
  end
  object query_produtos: TFDQuery
    Connection = fd
    SQL.Strings = (
      'select* from produtos')
    Left = 624
    Top = 280
    object query_produtosid: TFDAutoIncField
      DisplayLabel = 'ID'
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object query_produtoscodigo: TStringField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 15
      FieldName = 'codigo'
      Origin = 'codigo'
      Required = True
      Size = 50
    end
    object query_produtosnome: TStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 15
      FieldName = 'nome'
      Origin = 'nome'
      Required = True
      Size = 25
    end
    object query_produtosdescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 18
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 35
    end
    object query_produtosvalor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'valor'
      Origin = 'valor'
      Required = True
      Precision = 10
      Size = 2
    end
    object query_produtosestoque: TIntegerField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Estoque'
      FieldName = 'estoque'
      Origin = 'estoque'
    end
    object query_produtosdata: TDateField
      DisplayLabel = 'Data'
      FieldName = 'data'
      Origin = '`data`'
      Required = True
    end
    object query_produtosimagem: TBlobField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Imagem'
      FieldName = 'imagem'
      Origin = 'imagem'
    end
  end
  object ds_produtos: TDataSource
    DataSet = query_produtos
    Left = 696
    Top = 280
  end
  object query_coringa: TFDQuery
    Connection = fd
    Left = 104
    Top = 8
  end
end
