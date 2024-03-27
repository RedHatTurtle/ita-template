# Modelo de Dissertação/Tese em LaTeX do ITA

O arquivo principal do documento é o `main.tex`, a partir dele são incluídos
arquivos contidos na pasta `texts` conforme o necessário para o documento.

Dentro da pasta `texts` estão:
1. `cap0` Pasta com os conteúdos pre textuais como:
    - Agradecimentos
    - Resumo em português
    - Resumo em inglês (abstract)
    - Lista de símbolos
    - Lista de abreviaturas
2. `capX` Pastas com texto e figuras de cada capítulo do documento, por padrão 4
    - `cap1`: Introdução
    - `cap2`: Revisão Bibliográfica
    - `cap3`: Formulação Teórica
    - `cap4`: Resultados
    - `cap5`: Conclusão
3. `apeX` Pastas com texto e figuras de cada apêndice utilizado (opcional)
4. `aneX` Pastas com texto e figuras de cada anexo utilizado (opcional)

## Bibliografia e Referências
Além disso a pasta `bib` contém os arquivos de bibliografia com todas as
referências que serão citadas ao longo do texto. O LaTeX usas esses arquivos
`xxx.bib` para gerar automaticamente o capítulo de referências segundo a
especificação desejada (abnt por padrão).

## Compilação
O documento pode ser compilado com o comando `make` usando o `Makefile` contido
no repositório, nesse caso todos os arquivos de saida são salvos na pasta `build`
Ao serem compilados, os arquivos geram o arquivo final em .pdf (tese.pdf).
Também é possivel compilar o documento com um programa externo como Texmaker,
Texstudio ou a extensão LaTeX Workshop do VSCode, nesse caso o arquivo PDF é
gerado na mesma pasta do `main.tex`.

## Opções da classe ITA
No arquivo `tese.tex`
Este é o arquivo principal que vai chamar os capítulos
Ele também tem informações, como o seu nome, curso ...
No primeiro comando deste arquivo se define se a tese é em inglês ou português