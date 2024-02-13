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
        CriadoPor UNIQUEIDENTIFIER NOT NULL, -- ID do usuário que criou o registro
        CriadoEm DATETIME NOT NULL, -- Data e hora de criação do registro
        ModificadoPor UNIQUEIDENTIFIER, -- ID do usuário que modificou o registro (pode ser nulo se nunca foi modificado)
        ModificadoEm DATETIME, -- Data e hora da última modificação do registro
        ExcluidoPor UNIQUEIDENTIFIER, -- ID do usuário que excluiu o registro (pode ser nulo se nunca foi excluído)
        ExcluidoEm DATETIME, -- Data e hora de exclusão do registro
        Excluido BIT NOT NULL, -- Indica se o registro foi excluido
        CategoriaId UNIQUEIDENTIFIER NOT NULL, -- Chave estrangeira para a tabela de usuários
        FOREIGN KEY (CategoriaId) REFERENCES CategoriasTransacoes(CategoriaId),
        MetodoPagamentoId UNIQUEIDENTIFIER NOT NULL, -- Chave estrangeira para a tabela de usuários
        FOREIGN KEY (MetodoPagamentoId) REFERENCES MetodosPagamento(MetodoPagamentoId)
    )
END
GO

/* CARGA DE DADOS DE METODOS DE PAGAMENTOS */
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Dinheiro') BEGIN
    INSERT INTO MetodosPagamento VALUES ('9CEFDFCB-4BA8-49FF-A29B-5955941BF3B8', 'Dinheiro', 'Pagamento em Dinheiro')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Crédito') BEGIN
    INSERT INTO MetodosPagamento VALUES ('59086160-FA29-44CA-80BF-28684AD3C21F', 'Crédito', 'Pagamento com Cartão de Crédito')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'Débito') BEGIN
    INSERT INTO MetodosPagamento VALUES ('1546333D-77DF-4B6C-8980-7AB7165A0DA5', 'Débito', 'Pagamento com Cartão de Débito')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'TED') BEGIN
    INSERT INTO MetodosPagamento VALUES ('0AE00EAA-D7E9-4E28-8920-2F736DA207C9', 'TED', 'Transferência Bancária - TED')
END
IF NOT EXISTS(SELECT 1 FROM MetodosPagamento WHERE Nome = 'PIX') BEGIN
    INSERT INTO MetodosPagamento VALUES ('3E32C095-3CFE-4E35-A25B-3A4D06D81FAB', 'PIX', 'Transferência Bancária - PIX')
END

/* CARGA DE DADOS DE CATEGORIAS DE TRANSAÇÕES */
IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Alimentação') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('7F9ECEBB-D82E-4824-9DD1-8274653DD598', 'Alimentação', 'Despesas com alimentação')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Transporte') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('0D5A4ABB-609E-4726-AF7B-161A0B46E890', 'Transporte', 'Despesas com Transporte')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Lazer') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('CFB3B637-1A45-401A-8CA0-C711F0A6B88A', 'Lazer', 'Despesas com Lazer')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Saúde') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('FF5C75D9-F887-4F7A-938A-965121CCB83C', 'Saúde', 'Despesas com Saúde')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Educação') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('F967DCC9-F0DE-4891-8921-678745D15C9F', 'Educação', 'Despesas com Educação')
END

IF NOT EXISTS(SELECT 1 FROM CategoriasTransacoes WHERE Nome = 'Recebimentos') BEGIN
    INSERT INTO CategoriasTransacoes VALUES ('C7316094-D047-4BE4-8F22-BCC35B5A7CEF', 'Recebimentos', 'Recebimentos de valores')
END

GO
