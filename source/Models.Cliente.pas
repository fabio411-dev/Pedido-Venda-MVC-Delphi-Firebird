unit Models.Cliente;

interface

uses
  System.SysUtils;

type
  TCliente = class
  private
    FCodigo : Integer;
    FNOME   : string;
    FCIDADE : string;
    FUF     : string;
  published
    property Codigo : Integer read FCodigo write FCodigo;
    property Nome   : string  read FNOME   write FNOME;
    property Cidade : string  read FCIDADE write FCIDADE;
    property UF     : string  read FUF     write FUF;
  end;

implementation

end.

