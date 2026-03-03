# Pedido de Venda – Delphi 7 + Firebird 2.1

## Visão geral
Aplicação de vendas em lote, com tela de pedido de venda, itens, totalização e gravação em banco Firebird 2.1.  
Implementação segue padrão MVC / Service / Repository e Clean Code.

## Pré-requisitos

- Delphi 7 (ou 2007/2009, compatível com FireDAC)
- Firebird 2.1 (ou versão superior)
- Biblioteca cliente: `fbclient.dll` (copiar para `bin\`)
- `db.sql` já criado no banco

## Instalação

1. **Criar o banco**  
   ```bash
   isql-fb -user SYSDBA -password masterkey
   1> CREATE DATABASE 'C:\data\pedidos.fdb' USER SYSDBA PASSWORD 'masterkey' CONNECTION LIMIT 5;
   2> CONNECT 'C:\data\pedidos.fdb' USER SYSDBA PASSWORD 'masterkey';
   3> <executar o conteúdo de db.sql>

2. Configurar INI
  Copie config.ini.example para config.ini e ajuste:
  Configurar INI
  Copie config.ini.example para config.ini e ajuste:
  [Database]
  Database=..\data\pedidos.fdb
  Username=SYSDBA
  Password=masterkey
  Server=localhost
  Port=3050
  ClientLibrary=..\bin\fbclient.dll

3. Compilar
  Abra Pedido.dpr no Delphi 7 e compile.

4. Executar
  Abra a aplicação
  Informe o código do cliente
  Adicione itens
  Salve

5. Testes manuais
  Cliente
  Digite 1 no campo “Código Cliente” -> deve aparecer “José Silva – São Paulo/SP”.
  Tente 999 -> mensagem “Cliente não encontrado”.

  Produto
  Digite 2 no campo “Código Produto” -> “Caderno Escolar”, valor unitário “12,50”.

  Adicionar item
  Defina quantidade e clique em “Incluir”.
  O item aparece no grid e o total se atualiza.
  
  Edição
  Selecione um item no grid, pressione ENTER -> os dados são carregados nos campos.
  Altere a quantidade e clique em “Incluir” -> o item se atualiza.

  Remoção
  Selecione um item e pressione DEL -> confirmação -> item excluído e total recalculado.

  Salvar pedido
  Clique em “Gravar”.
  Se tudo correto, mensagem “Pedido gravado com sucesso”.

  Verifique no banco: SELECT * FROM PEDIDO e SELECT * FROM PEDIDO_ITEM.
