USE [Master];
GO

IF NOT EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME = 'DB_FLUXO_CAIXA') BEGIN

    CREATE DATABASE DB_FLUXO_CAIXA;

END
GO

USE [DB_FLUXO_CAIXA];
GO

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME = 'CategoriasTransacoes') BEGIN 
    CREATE TABLE MetodosPagamento (
        MetodoPagamentoId UNIQUEIDENTIFIER PRIMARY KEY,
        Nome NVARCHAR(100) NOT NULL UNIQUE,
        Descricao NVARCHAR(255)
    );

END 
GO

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME = 'CategoriasTransacoes') BEGIN 

    CREATE TABLE CategoriasTransacoes (
        CategoriaId UNIQUEIDENTIFIER PRIMARY KEY,
        Nome NVARCHAR(100) NOT NULL UNIQUE,
        Descricao NVARCHAR(255)
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
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Cr�dito') BEGIN
    INSERT INTO MetodosPagamento VALUES ('59086160-FA29-44CA-80BF-28684AD3C21F', 'Cr�dito', 'Pagamento com Cart�o de Cr�dito')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'D�bito') BEGIN
    INSERT INTO MetodosPagamento VALUES ('1546333D-77DF-4B6C-8980-7AB7165A0DA5', 'D�bito', 'Pagamento com Cart�o de D�bito')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'TED') BEGIN
    INSERT INTO MetodosPagamento VALUES ('0AE00EAA-D7E9-4E28-8920-2F736DA207C9', 'TED', 'Transfer�ncia Banc�ria - TED')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'PIX') BEGIN
    INSERT INTO MetodosPagamento VALUES ('3E32C095-3CFE-4E35-A25B-3A4D06D81FAB', 'PIX', 'Transfer�ncia Banc�ria - PIX')
END

/* CARGA DE DADOS DE CATEGORIAS DE TRANSA��ES */
IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Alimenta��o') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('7F9ECEBB-D82E-4824-9DD1-8274653DD598', 'Alimenta��o', 'Despesas com alimenta��o')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Transporte') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('0D5A4ABB-609E-4726-AF7B-161A0B46E890', 'Transporte', 'Despesas com Transporte')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Lazer') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('CFB3B637-1A45-401A-8CA0-C711F0A6B88A', 'Lazer', 'Despesas com Lazer')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Sa�de') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('FF5C75D9-F887-4F7A-938A-965121CCB83C', 'Sa�de', 'Despesas com Sa�de')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Educa��o') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('F967DCC9-F0DE-4891-8921-678745D15C9F', 'Educa��o', 'Despesas com Educa��o')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Recebimentos') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('C7316094-D047-4BE4-8F22-BCC35B5A7CEF', 'Recebimentos', 'Recebimentos de valores')
END

GO
