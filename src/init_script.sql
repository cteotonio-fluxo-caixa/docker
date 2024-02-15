USE [Master];
GO

IF NOT EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'DB_FLUXO_CAIXA') BEGIN

    CREATE DATABASE DB_FLUXO_CAIXA;

END
GO

USE [DB_FLUXO_CAIXA];
GO

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME = 'SaldoDia') BEGIN 
    CREATE TABLE SaldoDia (
        SaldoDiaId UNIQUEIDENTIFIER PRIMARY KEY,
        DataSaldo DATE NOT NULL UNIQUE,
        Saldo DECIMAL(18,2) NOT NULL
    );

END 
GO

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME = 'MetodosPagamento') BEGIN 
    CREATE TABLE MetodosPagamento (
        MetodoPagamentoId UNIQUEIDENTIFIER PRIMARY KEY,
        Nome NVARCHAR(20) NOT NULL UNIQUE,
        Descricao NVARCHAR(50)
    );

END 
GO

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME = 'CategoriasTransacoes') BEGIN 

    CREATE TABLE CategoriasTransacoes (
        CategoriaId UNIQUEIDENTIFIER PRIMARY KEY,
        Nome NVARCHAR(20) NOT NULL UNIQUE,
        Descricao NVARCHAR(50)
    );

END 
GO

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME = 'Transacoes') BEGIN 
    CREATE TABLE Transacoes (
        TransacaoId UNIQUEIDENTIFIER PRIMARY KEY,
        DataTransacao DATETIME NOT NULL,
        Valor DECIMAL(18, 2) NOT NULL,
        Credito INT NOT NULL, -- Pode ser '0 - Credito' ou '1 - Debito'
        Descricao NVARCHAR(100) NOT NULL,
        CriadoPor UNIQUEIDENTIFIER NOT NULL, -- ID do usu�rio que criou o registro
        CriadoEm DATETIME NOT NULL, -- Data e hora de cria��o do registro
        ModificadoPor UNIQUEIDENTIFIER, -- ID do usu�rio que modificou o registro (pode ser nulo se nunca foi modificado)
        ModificadoEm DATETIME, -- Data e hora da �ltima modifica��o do registro
        ExcluidoPor UNIQUEIDENTIFIER, -- ID do usu�rio que excluiu o registro (pode ser nulo se nunca foi exclu�do)
        ExcluidoEm DATETIME, -- Data e hora de exclus�o do registro
        Excluido BIT NOT NULL, -- Indica se o registro foi excluido
        CategoriaId UNIQUEIDENTIFIER NOT NULL, -- Chave estrangeira para a tabela de usu�rios
        FOREIGN KEY (CategoriaId) REFERENCES CategoriasTransacoes(CategoriaId),
        MetodoPagamentoId UNIQUEIDENTIFIER NOT NULL, -- Chave estrangeira para a tabela de usu�rios
        FOREIGN KEY (MetodoPagamentoId) REFERENCES MetodosPagamento(MetodoPagamentoId)
    )
END
GO

/* CARGA DE DADOS DE METODOS DE PAGAMENTOS */
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Dinheiro') BEGIN
    INSERT INTO MetodosPagamento VALUES ('9CEFDFCB-4BA8-49FF-A29B-5955941BF3B8', 'Dinheiro', 'Pagamento em Dinheiro')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Credito') BEGIN
    INSERT INTO MetodosPagamento VALUES ('59086160-FA29-44CA-80BF-28684AD3C21F', 'Credito', 'Pagamento com Cartao de Credito')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Debito') BEGIN
    INSERT INTO MetodosPagamento VALUES ('1546333D-77DF-4B6C-8980-7AB7165A0DA5', 'Debito', 'Pagamento com Cartao de Debito')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'TED') BEGIN
    INSERT INTO MetodosPagamento VALUES ('0AE00EAA-D7E9-4E28-8920-2F736DA207C9', 'TED', 'Transferencia Bancaria - TED')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'PIX') BEGIN
    INSERT INTO MetodosPagamento VALUES ('3E32C095-3CFE-4E35-A25B-3A4D06D81FAB', 'PIX', 'Transferencia Bancaria - PIX')
END

/* CARGA DE DADOS DE CATEGORIAS DE TRANSA��ES */
IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Alimentacao') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('7F9ECEBB-D82E-4824-9DD1-8274653DD598', 'Alimentacao', 'Despesas com alimentacao')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Transporte') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('0D5A4ABB-609E-4726-AF7B-161A0B46E890', 'Transporte', 'Despesas com Transporte')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Lazer') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('CFB3B637-1A45-401A-8CA0-C711F0A6B88A', 'Lazer', 'Despesas com Lazer')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Saude') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('FF5C75D9-F887-4F7A-938A-965121CCB83C', 'Saude', 'Despesas com Saude')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Educacao') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('F967DCC9-F0DE-4891-8921-678745D15C9F', 'Educacao', 'Despesas com Educacao')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Recebimentos') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('C7316094-D047-4BE4-8F22-BCC35B5A7CEF', 'Recebimentos', 'Recebimentos de valores')
END

GO
