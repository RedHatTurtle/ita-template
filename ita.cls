%===============================================================================
% This is the ITA LateX class - classe de documento com padrões do ITA
% written by
%              Fábio Fagundes Silveira   - ffs [at] ita [dot] br
%              Benedito C. O. Maciel     - bcmaciel [at] ita [dot] br
%              Giovani Volnei Meinertz   - giovani [at] ita [dot] br
%              Hudson Alberto Bode       - bode [at] ita [dot]br
%              P. I. Braga de Queiroz    - pi [at] ita [dot] br
%              Jorge A. B. Gripp         - gripp [at] ita [dot] br
%              Juliano Monte-Mor         - jamontemor [at] yahoo [dot] com [dot] br
%              Tarcisio A. B. Gripp      - tarcisio.gripp [at] gmail [dot] com
%              Alejandro Rios            -
%              Fábio Malacco Moreira     - fabiom91 [at] gmail [dot] com
%
% last updated:
%        $Id: ita.cls 42 2024-03-11$
%        $HeadURL: http://www.apgita.org.br/apgita/teses-e-latex.php$
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
% ITALUS
% Instituto Tecnológico de Aeronáutica - ITA
% São José dos Campos, Brazil
% HomePages:        http://www.comp.ita.br/italus
%                   http://groups.yahoo.com/group/italus/
% Discussion list: italus {at} yahoogroups.com
%===============================================================================

%===============================================================================
\NeedsTeXFormat{LaTeX2e}[2020/01/01]
\ProvidesClass{ita}[2006/03/10 v2.0 Classe de documento com padrões do ITA]

\newcommand{\itaclassfile}[1]{ita/#1}

%===============================================================================
% Declaração das opções
%===============================================================================
\DeclareOption{defaults}{
  \input{\itaclassfile{defs/defaults.def}}
}
% Doutorado
\DeclareOption{dsc}{
  \input{\itaclassfile{defs/dsc.def}}
}
% Exame de Qualificação
\DeclareOption{quali}{
  \input{\itaclassfile{defs/quali.def}}
}
% Mestrado
\DeclareOption{msc}{
  \input{\itaclassfile{defs/msc.def}}
}
% Trabalho Final de Graduação (TG)
\DeclareOption{tg}{
  \input{\itaclassfile{defs/tg.def}}
}

% Versão em ingles
\newif\if@eng
\DeclareOption{eng}{
  \@engtrue
}

% dv: 'draft version': imprime ´Versão Preliminar´ + data da impressão
\newif\if@dv
\DeclareOption{dv}{
  \@dvtrue
}

\DeclareOption{classic}{
  \newcommand{\itaformatworktitle} [1]{\Large \textbf{#1}}
  \newcommand{\itaformatauthorname}[1]{\large \textbf{#1}}
  \newcommand{\itaformattitletext} [1]{\large{#1}}

  \renewcommand{\itaspacing}{1.5}
}

\ExecuteOptions{defaults,classic}
\ProcessOptions
\AtEndOfPackage{
  \renewcommand{\baselinestretch}{\itaspacing} % Mudar espaçamento para \itaspacing
}

%===============================================================================
% Herança e Configuração da classe
%===============================================================================
\LoadClass[12pt,a4paper,oneside]{book}

\RequirePackage{ifthen}

\if@eng
   \RequirePackage[english]{babel}
\else
   \RequirePackage[english,portuges,brazil]{babel}
\fi

\if@eng
  \input{\itaclassfile{babel/itaeng.babel}}
\else
  \input{\itaclassfile{babel/itabr.babel}}
\fi

%===============================================================================
% Pacotes extras necessários para a classe ita
%===============================================================================

\RequirePackage{hyphenat}    % Controles de hifenização
\RequirePackage{setspace}    % Configura espaçamento de linhas
\RequirePackage{fancyhdr}    % Controle detalhado de cabeçalhos e rodapés
\RequirePackage{indentfirst} % Indenta primeiro parágrafo após um header/título
\RequirePackage{lastpage}    % Introduz label `LastPage` para o comando `\pageref`

\RequirePackage{tabularx}  % Extensão do \tabular com melhores controles de largura
\RequirePackage{xltabular} % Para tabelas que continuam na página seguinte
\RequirePackage{array}     % Extensões aos comandos \array e \tabular
\RequirePackage{xcolor}    % Extensão do pacote `color` com mais opções de definição de cores

% O modelo word oficial do ITA usa fontes de tamanho regular para captions
% Porém pessoalmente eu prefiro "footnotesize"
\RequirePackage[labelsep=endash,font=footnotesize]{caption} % Legendas para tabelas e figuras

%===============================================================================
% Check TeX engine used to compile the document and add distro specific packages
%===============================================================================

% Comandos de verificação de engine de tex usada, ex: pdfTex, XeTex, LuaTex
\RequirePackage{iftex}

% Check what TeX engine we're using, hopefully we're compiling with XeTex
\ifXeTeX
  \RequirePackage[xetex]{graphicx}
  \RequirePackage[xetex]{geometry}
\else
  % LuaTeX is slower and we don't really need the Lua features but at least the
  % fonts are as good as in XeTeX
  \ifLuaTeX
    % LuaTeX need these packages to break links into two lines
    \usepackage{url}
    \usepackage{breakurl}

    \RequirePackage[luatex]{graphicx}
    \RequirePackage[luatex]{geometry}
  \else
    % Worst case require at least PDFTeX
    \RequirePDFTeX

    % Add unicode support
    % Unicode para suporte nativo a diacríticos, ex: ç, â, á, ì, õ, etc.
    \RequirePackage[utf8]{inputenc}

    \ifPDFTeX
      % Check if output mode is set to PDF or DVI
      \ifpdf
        \RequirePackage{ae} % Fontes para pdf
        \RequirePackage[pdftex]{graphicx}
        \RequirePackage[pdftex]{geometry}
      \else % DVI output
        \RequirePackage[T1]{fontenc}
        \RequirePackage[dvips]{graphicx}
        \RequirePackage[dvips]{geometry}
      \fi
    \fi
  \fi
\fi

%===============================================================================
% Índice
%===============================================================================
\RequirePackage{makeidx} % Pacote padrão para gerar índice

%===============================================================================
% Glossário
%===============================================================================
%\RequirePackage{makeglos} % Pacote padrão para geração de Glossários

%===============================================================================
% Hyperref para termos hiperlinks no índica, citações, etc
%===============================================================================
% Redefinindo cores para os hyperlinks
\definecolor{linkblu}{HTML}{004098} % Links internos em azul
\definecolor{citered}{HTML}{CC1414} % Citações em vermelho
\definecolor{urlcyan}{HTML}{008080} % URLs em ciano

\RequirePackage[debug,
                breaklinks,
                pagebackref=true,
                bookmarksopen=true,
                colorlinks=true,
                linkcolor=linkblu,
                citecolor=citered,
                urlcolor=urlcyan,
                bookmarksnumbered=true,
                hyperindex=true,
                verbose=true]
               {hyperref}

%===============================================================================
% Formatação ABNT para citações
%===============================================================================

% O ABNTeX2 usa o pacote `natbib` para montar referências no estilo ABNT
% O `natbib` está ficnado obsoleto embora ainda seja usado por algumas revistas
\RequirePackage[alf,
                abnt-emphasize=bf,
                abnt-etal-cite=2,
                abnt-etal-list=0,
                abnt-etal-text=it]
               {abntex2cite}

% O pacote `biblatex` é o jeito "moderno" de fazer bibliografias mas para usa-lo
% são necessárias várias mudanças no template que eu não estou disposto a fazer
% no momento
% Em teoria o biblatex já tem as definições da ABNT internamente, basta
% especificar a opção de estilo
%\RequirePackage[style=abnt]{biblatex}

%===============================================================================
% Pacotes extras recomendados para teses
%===============================================================================

% AMS Packages
%\RequirePackage{amsmath}     % Ambiente de matemática e equações avançado
%\RequirePackage{amsfonts}    % Fontes p/ conjuntos: R, Z, H, etc
%\RequirePackage{amssymb}     % Símbolos matemáticos
%\RequirePackage{amsthm}      % Theorem writing tools

%\RequirePackage{epsfig}
%\RequirePackage{subfig}
%\RequirePackage{multirow}
%\RequirePackage{float}

%===============================================================================

% Dimensões das páginas
\geometry{a4paper,
          %showframe,  % Used only to debug margin settings
          lmargin=30mm, % Left Margin
          rmargin=20mm, % Right Margin
          tmargin=30mm, % Top Margin
          bmargin=20mm, % Bottom margin
          verbose,
          headheight=0.56cm,
          headsep=0.5cm,
          footskip=3em}

\newif\ifhyperref
\@ifpackageloaded{hyperref}{\hyperreftrue}{\hyperreffalse}

%===============================================================================
% Alterar os tamanhos de fonte padrão do Tex para os valores usados no template
% word oficial do ITA. O primeiro argumento é o tamanho da fonte e o segundo
% o espaçamento padrão (símples) que no modelo word é de 8%
%\renewcommand{\small}     {\fontsize{10}{10.80}} % 10pt
%\renewcommand{\normalsize}{\fontsize{12}{12.96}} % 12pt
%\renewcommand{\large}     {\fontsize{14}{15.12}} % 14pt Usado para o nome do autor
%\renewcommand{\Large}     {\fontsize{16}{17.28}} % 16pt Usado para o título

%\RequirePackage{titlesec} %alterar tamanho da fonte
%\titleformat{\section}
% {\large\bfseries}{\thesection}{0.5em}{}
%\titleformat{\subsection}
% {\normalsize\bfseries}{\thesubsection}{0.5em}{}
%\titleformat{\subsubsection}
% {\normalsize\bfseries}{\thesubsubsection}{0.5em}{}
%\titleformat{\paragraph} % para 4o nivel
% {\normalsize\bfseries}{\theparagraph}{0.5em}{}

%===============================================================================
% Redefinição da data (para ter dia, mês e ano separados)
%===============================================================================
\renewcommand{\date}[3]{
  \gdef\@publday{#1}
  \gdef\@publmonth{#2}
  \gdef\@publyear{#3}
}
\date{\dayname}{\monthname}{\number\year}

%===============================================================================
% Novos comandos:
% - \authorgender
% - \author
% - \authoraddress
% - \advisorgender
% - \advisor
% - \coadvisorgender
% - \coadvisor
% - \bossgender
% - \boss
% - \bosscoursegender
% - \bosscourse
% - \course
% - \dept
% - \area
% - \cdu
%===============================================================================
% Autor
% Gênero do autor
\newcommand{\authorgender}[1]{
  \renewcommand{\authorgendermf}{#1}
}
% Nome, Sobrenome
\renewcommand{\author}[2]{
  \gdef\@authorfirst{#1}
  \gdef\@authorlast{#2}
}
% Endereco do Autor (utilizado no verso da folha de rosto)
\renewcommand{\itaauthoraddress}[3]{
  \gdef\@itaauthoraddress{#1}
  \gdef\@itaauthorcep{#2}
  \gdef\@itaauthorcity{#3}
}

% Orientador
% Gênero do orientador
\newcommand{\advisorgender}[1]{
  \renewcommand{\advisorgendermf}{#1}
}
% word, title, name
\newcommand{\advisor}[4][\itaadvisorwordbabel]{
  \renewcommand{\itaadvisorword}{#1}
  \renewcommand{\itaadvisortitle}{#2}
  \renewcommand{\itaadvisorname}{#3}
  \gdef\@itaadvisorinst{#4}
  \gdef\@advisor{#2~#3 \\ #1}
  \gdef\@advisortg{#1 \\ #2~#3 (#4)}
  %\gdef\itaadvisorword{#1} % This should have been defined already somewhere else
}

% Coorientador  (opcional)
% Gênero do coorientador
\newcommand{\coadvisorgender}[1]{
   \renewcommand{\coadvisorgendermf}{#1}
}
% word, title, name
\newcommand{\coadvisor}[4][\itacoadvisorwordbabel]{
  \gdef\itacoadvisorword{#1}
  \gdef\itacoadvisortitle{#2}
  \gdef\itacoadvisorname{#3}
  \gdef\@itacoadvisorinst{#4}
  \gdef\@coadvisor{#2~#3 \\ #1}
  \gdef\@coadvisortg{#1 \\ #2~#3 (#4)}
}

% Pró-Reitor de Pós-Graduação
% Gênero do Pró-reitor da Pós-graduação
\newcommand{\bossgender}[1]{
  \renewcommand{\bossgendermf}{#1}
}
% word, title, name
\newcommand{\boss}[3][\itabosswordbabel]{
  \renewcommand{\itabossword}{#1}
  \renewcommand{\itabosstitle}{#2}
  \renewcommand{\itabossname}{#3}
  \gdef\@boss {#2~#3 \\ #1}
}

% Coordenador do respectivo curso de graduação
% Gênero do Coordenador do curso no caso de TG
\newcommand{\bosscoursegender}[1]{
  \renewcommand{\bosscoursegendermf}{#1}
}
% word, title, name
\newcommand{\bosscourse}[3][\itabosscoursewordbabel]{
  \renewcommand{\itabosscourseword}{#1}
  \renewcommand{\itabosscoursetitle}{#2}
  \renewcommand{\itabosscoursename}{#3}
  \gdef\@bosscourse {#2~#3 \\ #1}
}
% Curso de Graduação/Programa de Pós-Graduação
\newcommand{\course}[1]{
  \renewcommand{\itaworkcourse}{#1}
}
% Divisão Acadêmica do ITA (não utilizado no template atual):
% - IEF: Divisão de Ciências Fundamentais
% - IEA: Divisão de Engenharia Aeronáutica
% - IEE: Divisão de Engenharia Eletrônica
% - IEM: Divisão de Engenharia Mecânica
% - IEI: Divisão de Engenharia Civil
% - IEC: Divisão de Ciência da Computação
\newcommand{\dept}[1]{
  \renewcommand{\itaworkdept}{#1}
}
% Área do Curso
\newcommand{\area}[1]{
  \renewcommand{\itaworkarea}{#1}
}
% Número de CDU
\newcommand{\cdu}[1]{
  \renewcommand{\cdunumber}{#1}
}
%===============================================================================
% Hack: Pagina de Rosto para Teses
%===============================================================================
\newcommand{\itatitletext}{\itatitletextbabel}

\renewcommand{\maketitle}{%
  \begin{titlepage}
    \ifthenelse{\equal{\itaoptionlevel}{tg}}
               {\maketgcover}
               {}

    \pdfbookmark[0]{\nametitlepage}{titulo}
    % Verifica se é uma tese ou um exame de qualificação
    \ifthenelse{\equal{\itaoptionlevel}{quali}}
               {\thequalititlepage}
               {\ifthenelse{\equal{\itaoptionlevel}{tg}}
                           {\thetgtitlepage}
                           {\thethesistitlepage}
  }
  \end{titlepage}

  \ifthenelse{\equal{\itaoptionlevel}{quali}}
             {\setcounter{page}{2}}
             {\setcounter{page}{4}}
}

%===============================================================================
% Folha de Rosto do Exame de Qualificação para Doutorado
%===============================================================================
\newcommand{\thequalititlepage}{%
  \noindent
  \center
  \begin{spacing}{1.5}
    {\Large \itanametitlequalibabel }    \\ %  ITA -- \textsc{Instituto Tecnológico de Aeronáutica}} \\
    {\Large \itaposnametitlequalibabel } \\ %  \textsc{Pós-Graduação em \itaworkcourse}} \\
    {\large \itaarenametitlequalibabel }    %  \textsc{Área de \itaworkarea}}
  \end{spacing}
  \vfill
  \begin{spacing}{1.2}
    \itaformatworktitle{\MakeUppercase{\@title}}
  \end{spacing}
  \vfill
  \if@eng
    by\\
  \else
    por\\
  \fi
  \itaformatauthorname{\@authorfirst\ \@authorlast}
  \vfill
  \normalsize
  \hspace{\fill}
  \parbox[b]{8.5cm}{\itaqualifictext}%
  \vfill
  \begin{spacing}{1.5}
    \@advisor
  \end{spacing}

  % Coorientador(a) (opcional)
  \@ifundefined{@coadvisor}{}{
    \vfill
    \begin{spacing}{1.5}
      \@coadvisor
    \end{spacing}
  }
  \vfill
  \if@eng
    \begin{spacing}{1.5}
      S{\~a}o Jos{\'e} dos Campos: \@publmonth\ \@publday, \@publyear
    \end{spacing}
  \else
    \begin{spacing}{1.5}
      \sjc, \@publmonth\ de \@publyear
    \end{spacing}
  \fi
}

%===============================================================================
% Folha de Rosto do Trabalho de Graduação
%===============================================================================
\newcommand{\thetgtitlepage}{%
  \newpage%
  \thispagestyle{empty} % Suprime o cabeçalho e numeração da página
  \noindent

  \begin{flushright}% Número de CDU
    \MakeUppercase{\footnotesize CDU \cdunumber}
  \end{flushright}

  \center

  \itaformatauthorname{\@authorfirst\ \@authorlast}
  \vfill

  \vspace*{\stretch{1}}

  \begin{spacing}{1.0}
  \itaformatworktitle{\MakeUppercase{\@title}}
  \end{spacing}

  \vspace*{\stretch{2}}

  % Orientador
  \begin{spacing}{  1.5}
    \@advisortg
  \end{spacing}

  % Coorientador(a) (opcional)
  \@ifundefined{@coadvisor}{}{
    \vspace*{\stretch{2}}
    \begin{spacing}{1.5}
      \@coadvisortg
    \end{spacing}
  }

  \vspace*{\stretch{3}}

  \itaformatauthorname{\MakeUppercase{\textbf{\itaworkcourse}}}

  \vspace*{\stretch{2}}

  \vspace*{\stretch{2}}

  \begin{spacing}{1.0}
    \textsc{\Large{S}\large{\~{a}o} \Large{J}\large{os\'{e}} dos \Large{C}\large{ampos}} \\
    \textsc{\Large{I}\large{nstituto}{} \Large{T}\large{ecnol\'{o}gico}{} de \Large{A}\large{eron\'{a}utica}{}}

    \vspace*{\stretch{2}}

    \@publyear
  \end{spacing}

  \@makecippage        % Função para criar verso da folha de rosto
  \@listexaminators    % Função para criar página de membros da banca
}

%===============================================================================
% Folha de Rosto das Teses de Mestrado e Doutorado
%===============================================================================
\newcommand{\thethesistitlepage}{%
  \noindent

  \begin{spacing}{1.5}
  \noindent \parbox[c]{\textwidth}{\itaformattitletext{\itatitletext}}
  \end{spacing}

  \vspace*{\stretch{2}}

  \center

  \itaformatauthorname{\@authorfirst\ \@authorlast}
  \vfill

  \vspace*{\stretch{1}}

  % Title spacing is double in the word template
  \begin{spacing}{2.0}
    \itaformatworktitle{\MakeUppercase{\@title}}
  \end{spacing}

  \vspace*{\stretch{2}}

  \normalsize
  \itathesisapprovedmembersbabel

  \vspace*{\stretch{3}}

  \begin{spacing}{  1.5}
    \@advisor
  \end{spacing}

  % Coorientador (opcional)
  \@ifundefined{@coadvisor}{}{
    \vspace*{\stretch{2}}
    \begin{spacing}{  1.5}
      \@coadvisor
    \end{spacing}
  }

  \vspace*{\stretch{2}}

  \begin{spacing}{  1.5}
  \@boss
  \end{spacing}

  \vspace*{\stretch{2}}

  \begin{spacing}{1.0}
    Campo Montenegro \\
    \sjc, SP - \itacountrybabel \\
    \@publyear
  \end{spacing}

  \@makecippage        % Função para criar verso da folha de rosto
  \@listexaminators    % Função para criar a folha de banca
}
%===============================================================================
% Capa do TG
%===============================================================================

\newcommand{\maketgcover}{%
  \pdfbookmark[0]{\namecover}{cover}
  \thispagestyle{empty}

  \hspace{-0.8cm}\fbox{\parbox[c][660pt][c]{\textwidth}{
  \centering

  \itaformatworktitle{\MakeUppercase{\italongname}}

  \vspace*{\stretch{2}}

  \includegraphics[width=0.5\textwidth]{\itaclassfile{figs/ita_logo.jpg}}

  \vspace*{\stretch{2}}

  \itaformatauthorname{\@authorfirst\ \@authorlast}

  \vspace*{\stretch{1}}

  \begin{spacing}{1.0}
  \itaformatworktitle{\MakeUppercase{\@title}}
  \end{spacing}

  \vspace*{\stretch{3}}

  \begin{spacing}{1.0}
  \Large{\finalpaper \\
  \@publyear}
  \end{spacing}

  \vspace*{\stretch{2}}

  \Huge{\textbf{\courseof\ \itaworkcourse}}

  \vspace*{\stretch{1}}
  \vfill
  } }
}

%===============================================================================
% CIP: Verso da Folha de Rosto
%===============================================================================
\newcommand{\@makecippage}{%
  \newpage%
  \pdfbookmark[0]{\namecip}{cip}
  \thispagestyle{empty}
  \begin{flushleft}
    \begin{footnotesize}
      \begin{onehalfspacing}
        {\setlength{\baselineskip}{0.8\baselineskip}
          \textbf{\itaciptitlebabel} \\
          \textbf{\itacipbibbabel}\\}
        \@cipwindow
        \@bibref
        \@rights
      \end{onehalfspacing}
    \end{footnotesize}
  \end{flushleft}
  \vfill
}

% Definição do quadro
\def\@cipwindow{%
  \framebox[\textwidth]{%
  \begin{minipage}{\textwidth - 10mm}%
    \begin{flushleft}
      \vspace*{0.5ex}
      \setlength{\parindent}{1em}%
      \begin{footnotesize}
        \begin{onehalfspacing}
          \setlength{\baselineskip}{0.7\baselineskip}
          \noindent\@authorlast, \@authorfirst\par
          \@title\ / \@authorfirst\ \@authorlast.\\
          \noindent São José dos Campos, \@publyear.\par
          \NumPenultimaPagina f.\par
          \vspace{\baselineskip}
          \itacipdata1babel
          \vspace{0.4ex}
        \end{onehalfspacing}
      \end{footnotesize}
    \end{flushleft}
  \end{minipage}%
  }%
}

% Referência Bibliográfica
\def\@bibref{%
  \vspace*{\stretch{2}}
  \normalsize
  \textbf{\itarefbibnamecipbabel} \par
  \begin{onehalfspacing}
    {\setlength{\baselineskip}{1.0\baselineskip}
    \MakeUppercase{\@authorlast}, \@authorfirst. \textbf{\@title}. \@publyear. \NumPenultimaPagina~f. \itacip2babel \\}
  \end{onehalfspacing}
}

% Cessão de Direitos
\def\@rights{%
  \begin{onehalfspacing}
    \vspace*{\stretch{4}}
    {\normalsize\textbf{\itacedirnamebabel}} \par
    {\setlength{\baselineskip}{1.0\baselineskip}
    {\footnotesize \itacipauthorname} {\normalsize \@authorfirst\ \@authorlast} \\
    {\footnotesize \itacipworktitlebabel} {\normalsize \@title.} \\
    {\footnotesize \itacipworktype} {\normalsize{\itaworklevel}\ / \@publyear} \\ }

    \vspace{\baselineskip}

    \parbox[c]{\textwidth}{\normalsize\setlength{\baselineskip}{0.7\baselineskip} \itacesdirtextbabel \\}

    \vspace*{\stretch{2}}
    \rule{75mm}{0.2mm}\\
    {\normalsize\setlength{\baselineskip}{0.7\baselineskip}
    \@authorfirst\ \@authorlast\\
    \@itaauthoraddress\\
    \@itaauthorcep~\@itaauthorcity\\}
  \end{onehalfspacing}
}

%===============================================================================
% Folha de Banca Examinadora
%===============================================================================
\newcommand{\@listexaminators}
{
  \newpage
  \pdfbookmark[0]{\namepageexaminersbookmark}{aprovacao}
  \thispagestyle{empty}

  \noindent

  \ifthenelse{\equal{\itaoptionlevel}{tg}}
  { % Folha de Banca para TG
    \begin{spacing}{1.2}
      \begin{center}
        \itaformatworktitle{\MakeUppercase{\@title}}
        \vfill
        \small{\itathesisapprovedmemberstg}
        \vspace*{\stretch{3}}

        \hspace{3cm}\hrulefill\hspace{3cm}
        \par
        \small{\@authorfirst\ \@authorlast
        \par
        \@authorword\ifthenelse{\equal{\authorgendermf}{mas}}{}{\if@eng \else a\fi}}
        \vspace*{\stretch{1}}

        \hspace{3cm}\hrulefill\hspace{3cm}
        \par
        \small{\itaadvisorname\ (\@itaadvisorinst )
        \par
        \itaadvisorword}
        \vspace*{\stretch{1}}

        % Coorientador (opcional)
        \@ifundefined{@coadvisor}{}{
          \hspace{3cm}\hrulefill\hspace{3cm}
          \par
          \small{\itacoadvisorname\ (\@itacoadvisorinst )
          \par
          \itacoadvisorword}
          \vspace*{\stretch{1}}
        }

        \hspace{3cm}\hrulefill\hspace{3cm}
        \par
        \small{\@bosscourse}
        \vspace*{\stretch{2}}

        \if@eng
          \small{S{\~a}o Jos{\'e} dos Campos: \@publmonth\ \@publday, \@publyear.}
        \else
          \small{S{\~a}o Jos{\'e} dos Campos, \@publday\ de \@publmonth\ de \@publyear.}
        \fi
      \end{center}
    \end{spacing}
  }
  { % Folha de Banca para Mestrado/Doutorado
    \begin{spacing}{1.0}
      \begin{center}
        \itaformatworktitle{\MakeUppercase{\@title}}
        \vfill
        \itaformatauthorname{\@authorfirst\ \@authorlast}
        \vfill
      \end{center}

      \raggedright{\normalsize{\namepageexaminers}}
      \raggedright\@memberslist

    \end{spacing}
    \vfill
    \center
    \large\textbf{ITA}
  }
}

%===============================================================================
% Dedicatória
%===============================================================================
\newenvironment{itadedication}
{\thispagestyle{empty}%
  \pdfbookmark[0]{\namededicatory}{dedication}
  \begin{flushright}%
  \null\vfil \@beginparpenalty\@lowpenalty
  \vspace{120mm}
  \hspace{80mm}
  \begin{minipage}[b]{0.45\textwidth}\begin{spacing}{1.5}}
{\end{spacing}\end{minipage}\end{flushright}\par\vfil\null\newpage}

%===============================================================================
% Agradecimentos
%===============================================================================
\newenvironment{itathanks}[1][\nameacknowledgment]{
  \chapter*{#1}
  \pdfbookmark[0]{\nameacknowledgment}{acknowledgment}
}
{\par\vfil\null\newpage}

%===============================================================================
% Resumo
%===============================================================================
\newenvironment{abstract}
  {\chapter*{\nameabstract}\pdfbookmark[0]{\nameabstract}{resumo}}
  {}

%===============================================================================
% Abstract
%===============================================================================
\newenvironment{englishabstract}
  {\chapter*{\nameengabstract}\pdfbookmark[0]{\nameengabstract}{abstract}}
  {}

%===============================================================================
% Redefinicao de chapter
%===============================================================================
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
                      \thispagestyle{empty}%
                      \global\@topnum\z@
                      \@afterindenttrue
                      \secdef\@chapter\@schapter}
% Redefinição do espaço entre parágrafos
\setlength{\parskip}{.5em}

%===============================================================================
% Hack: Adicionando Bibliografia, Lista de Figuras, Lista de Tabelas,
% Lista de Simbolos e Lista de Abreviaturas ao Sumario
%===============================================================================
% Bibliografia
\renewenvironment{thebibliography}[1]
  {\chapter*{\bibname
  \refstepcounter{chapter}
  \addcontentsline{toc}{chapter}{\bibname}   % Thanks to D.Farfan
  \@mkboth{\MakeUppercase{\bibname}}%
          {\MakeUppercase{\bibname}}}%       % Thanks to ffs :-)
  \singlespacing
  \flushleft
  \list{\@biblabel{\@arabic\c@enumiv}}%
        {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
}
{\def\@noitemerr
  {\@latex@warning{Empty `thebibliography' environment}}%
  \endlist}

% Lista de figuras
\renewcommand\listoffigures{%
  %\begin{spacing}{  1.5}
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename
      \@mkboth{\MakeUppercase{\listfigurename}}%
              {\MakeUppercase{\listfigurename}}}     % Thanks to Reinaldo Fortes
    %\addcontentsline{toc}{chapter}{\listfigurename} % Thanks to D.Farfan
    \pdfbookmark[0]{\listfigurename}{listafiguras}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
  %\end{spacing}
}

% Lista de tabelas
\renewcommand\listoftables{%
  %\begin{spacing}{  1.5}
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename
      \@mkboth{\MakeUppercase{\listtablename}}%
              {\MakeUppercase{\listtablename}}}     % Thanks to Reinaldo Fortes
    %\addcontentsline{toc}{chapter}{\listtablename} % Thanks do D.Farfan
    \pdfbookmark[0]{\listtablename}{listatabelas}
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
  %\end{spacing}
}

% Redefinicao do Sumário
\renewcommand\tableofcontents{%
  %\begin{spacing}{  1.5}
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\contentsname
    \pdfbookmark[0]{\namecontents}{contents}
    \@mkboth{\MakeUppercase{\contentsname}}  %
            {\MakeUppercase{\contentsname}}} % Thanks to Reinaldo Fortes
    \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
  %\end{spacing}
}

% Lista de Abreviaturas
\newcommand\listofabbreviations{%
  %\begin{spacing}{  1.5}
    \begin{flushleft}
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{{\listofabbreviationsname}
      \@mkboth{\MakeUppercase{\listofabbreviationsname}}  % Thanks to Reinaldo Fortes
              {\MakeUppercase{\listofabbreviationsname}}} %
      %\addcontentsline{toc}{chapter}{\listofabbreviationsname}%  Thanks to ffs  :-)
    \pdfbookmark[0]{\listofabbreviationsname}{listaabreviaturas}
    \@starttoc{loa}%
    \if@restonecol\twocolumn\fi
    \end{flushleft}
  %\end{spacing}
}

% Lista de Símbolos
\newcommand\listofsymbols{%
  %\begin{spacing}{  1.5}
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listofsymbolsname
      \@mkboth{\MakeUppercase{\listofsymbolsname}}%
              {\MakeUppercase{\listofsymbolsname}}}%         Thanks to Reinaldo Fortes
    %\addcontentsline{toc}{chapter}{\listofsymbolsname}%      Thanks to ffs  :-)
    \pdfbookmark[0]{\listofsymbolsname}{listasimbolos}
    \@starttoc{los}% If this command is enable list of symbols will appears with othe list (list of table or list of figures)
    \if@restonecol\twocolumn\fi
  %\end{spacing}
}

% Thanks to Dr. Alan Wilter Sousa da Silva - alan@lncc.br
\renewcommand{\addcontentsline}[3]{%
  \begingroup
    \let\label\@gobble
    \let\textlatin\@firstofone
    \ifx\@currentHref\@empty
      \Hy@Warning{%
        No destination for bookmark of \string\addcontentsline,%
        \MessageBreak destination is added%
      }%
      \phantomsection
    \fi
    \expandafter\ifx\csname toclevel@#2\endcsname\relax
      \begingroup
        \def\Hy@tempa{#1}%
        \ifx\Hy@tempa\Hy@bookmarkstype
          \Hy@WarningNoLine{bookmark level for unknown #2 defaults to 0}%
        \else
          \Hy@Info{bookmark level for unknown #2 defaults to 0}%
        \fi
      \endgroup
      \expandafter\gdef\csname toclevel@#2\endcsname{0}%
    \fi
    \edef\Hy@toclevel{\csname toclevel@#2\endcsname}%
    \Hy@writebookmark{\csname the#2\endcsname}%
      {#3}%
      {\@currentHref}%
      {\Hy@toclevel}%
      {#1}%
    \ifHy@verbose
      \typeout{pdftex: bookmark at \the\inputlineno:
        {\csname the#2\endcsname}
        {#3}
        {\@currentHref}%
        {\Hy@toclevel}%
        {#1}%
      }%
    \fi
    \addtocontents{#1}{%
      \protect\contentsline{#2}{#3}{\thepage}{\@currentHref}%
    }%
  \endgroup
}

%===============================================================================
% Cabecalhos e Rodapés
%===============================================================================
\pagestyle{fancy}
\lhead{\leftmark}
\chead{}
\rhead{\thepage}
\lfoot{}\cfoot{}\rfoot{}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0pt}
% Imprimir rodape com versao preliminar?
  \if@dv
     \rfoot{\emph{\itadvnamebabel\ \today }}
  \fi

%===============================================================================
% Membros da banca examinadora
%===============================================================================
\newcounter{mecounter}
\newcommand{\examiner}[4]{
        \addtocounter{mecounter}{1}
        \expandafter\gdef\csname metitle\alph{mecounter}\endcsname{#1}
        \expandafter\gdef\csname mename\alph{mecounter}\endcsname{#2}
        \expandafter\gdef\csname merole\alph{mecounter}\endcsname{#3}
        \expandafter\gdef\csname meinst\alph{mecounter}\endcsname{#4}
}

\newcommand{\@memberslist}{
  \noindent\begin{tabularx}{\textwidth}{l l l l l}
    \@ifundefined{metitlea}  {}{\metitlea\@        & \menamea\@        & \merolea\@        & - & \meinsta\@         \\}
    \@ifundefined{@advisor}  {}{\itaadvisortitle   & \itaadvisorname   & \itaadvisorword   & - & \@itaadvisorinst   \\}
    \@ifundefined{@coadvisor}{}{\itacoadvisortitle & \itacoadvisorname & \itacoadvisorword & - & \@itacoadvisorinst \\}
    \@ifundefined{metitleb}  {}{\metitleb\@        & \menameb\@        & \meroleb\@        & - & \meinstb\@         \\}
    \@ifundefined{metitlec}  {}{\metitlec\@        & \menamec\@        & \merolec\@        & - & \meinstc\@         \\}
    \@ifundefined{metitled}  {}{\metitled\@        & \menamed\@        & \meroled\@        & - & \meinstd\@         \\}
    \@ifundefined{metitlee}  {}{\metitlee\@        & \menamee\@        & \merolee\@        & - & \meinste\@         \\}
    \@ifundefined{metitlef}  {}{\metitlef\@        & \menamef\@        & \merolef\@        & - & \meinstf\@         \\}
    \@ifundefined{metitleg}  {}{\metitleg\@        & \menameg\@        & \meroleg\@        & - & \meinstg\@         \\}
    \@ifundefined{metitleh}  {}{\metitleh\@        & \menameh\@        & \meroleh\@        & - & \meinsth\@         \\}
  \end{tabularx}
}

%===============================================================================
% Palavras-chave
%===============================================================================
\newcommand{\keywords}[1]{%
    \vfill \noindent\textbf{Palavras--Chave:} #1%
}

%===============================================================================
% Keywords
%===============================================================================
\newcommand{\englishkeywords}[1]{%
    \vfill \noindent\textbf{Keywords:} #1%
}

%===============================================================================
% Definição das palavras-chave para CIP (informado pela Biblioteca)
%===============================================================================
\newcounter{kwcipcounter}
\newcommand{\kwcip}[1]{
        \addtocounter{kwcipcounter}{1}
        \expandafter\gdef\csname kwcip\alph{kwcipcounter}\endcsname{#1}
}
\newcommand{\@cipkw}{%
        \@ifundefined{kwcipa}{}{1.~\expandafter\MakeUppercase\kwcipa\@. }%
        \@ifundefined{kwcipb}{}{2.~\expandafter\MakeUppercase\kwcipb\@. }%
        \@ifundefined{kwcipc}{}{3.~\expandafter\MakeUppercase\kwcipc\@. }%
        \@ifundefined{kwcipd}{}{4.~\expandafter\MakeUppercase\kwcipd\@. }%
        \@ifundefined{kwcipe}{}{5.~\expandafter\MakeUppercase\kwcipe\@. }%
        \@ifundefined{kwcipf}{}{6.~\expandafter\MakeUppercase\kwcipf\@. }%
        \@ifundefined{kwcipg}{}{7.~\expandafter\MakeUppercase\kwcipg\@. }%
        \@ifundefined{kwciph}{}{8.~\expandafter\MakeUppercase\kwciph\@. }%
        \@ifundefined{kwcipi}{}{9.~\expandafter\MakeUppercase\kwcipi\@. }%
        \@ifundefined{kwcipj}{}{10.~\expandafter\MakeUppercase\kwcipj\@. }%
}

%===============================================================================
% Hack: Centralizando \chapter*
% \@makeschapterhead é chamado por \chapter*
%===============================================================================
\def\@makeschapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \centering
    \normalfont
    \interlinepenalty\@M
    \Huge \bfseries  #1\par\nobreak
    \vskip 40\p@
  }
}

%===============================================================================
% Redefinicao do comando \appendix para mostrar 'Apêndice' ou 'Anexo'
% no Sumario
%===============================================================================
\renewcommand{\appendix}{%
  \cleardoublepage
  \providecommand\anexoautorefname{appendix}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \def\Hy@appendixstring{appendix}% %%novo string no *.toc, para fazer o hyperlink funcionar
  \def\anexo{%
  \@ifundefined{chapter}%
    {\gdef\theHsection{\Alph{section}}}%
    {\gdef\theHchapter{\Alph{chapter}}}%
  \xdef\Hy@chapapp{\Hy@appendixstring}%

  \gdef\@chapapp{\appendixname}%
  \addtocontents{toc}{\SetAppendixTocName{\appendixname}}%
  \gdef\thechapter{\@Alph\c@chapter}%
  }
  \anexo
}

%===============================================================================
% Acrescenta o comando SetappendixTocName ao toc
%===============================================================================
\DeclareRobustCommand{\SetAppendixTocName}[1]{\gdef\AppendixTocName{#1}}

%===============================================================================
% Novo comando: \annex
%===============================================================================
\newcommand{\annex}{%
  \cleardoublepage
  \providecommand\anexoautorefname{annex}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \def\Hy@appendixstring{annex}% %%novo string no *.toc, para fazer o hyperlink funcionar
  \def\anexo{%
  \@ifundefined{chapter}%
    {\gdef\theHsection{\alph{section}}}%
    {\gdef\theHchapter{\alph{chapter}}}%
  \xdef\Hy@chapapp{\Hy@appendixstring}%

  \gdef\@chapapp{\nameannex}%
  \addtocontents{toc}{\SetAppendixTocName{\nameannex}}%
  \gdef\thechapter{\@Alph\c@chapter}%
  }
  \anexo
}

%===============================================================================
% Redefinicao de mainmatter para numeracao continua de paginas
%===============================================================================
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \renewcommand{\thepage}{\arabic{page}}}

%===============================================================================
% 'Desligar' hifenacao
%===============================================================================
\newlanguage\nohyphen
\newcommand\nh[1]{{\language\nohyphen #1}}

%===============================================================================
% Redefinicao de l@chapter, l@section e l@subsection para acrescentar
% a palavra 'Anexo' ou 'Apendice' no toc e ajustar identacao para
% "nada identado" :-)
%===============================================================================
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip -3ex \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
    \ifx\AppendixTocName\undefined\else
       \renewcommand{\numberline}[1]{\AppendixTocName~##1~~--~~}%
    \fi
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      \@dottedtocline{0}{0em}{1.8em}{\normalfont\scshape\large{#1}}{#2}
      \penalty\@highpenalty
    \endgroup
  \fi
}

% l@section
\renewcommand*{\l@section}[2]{%
\@dottedtocline{1}{0.5cm}{2.8em}{\textbf{#1}}{\hss #2}}

% l@subsection
\renewcommand*{\l@subsection}{\@dottedtocline{2}{1cm}{3.7em}}

%===============================================================================
% Numerar o subsubsection conforme definido anteriormente
%===============================================================================
\setcounter{secnumdepth}{4}

%===============================================================================
% Glossário (desatualizado)
%===============================================================================
%\newcommand{\itaglossary}{
%  \cleardoublepage
%  \thispagestyle{empty}%
%  \@mkboth{\MakeUppercase{\itaglossarynamebabel}}%
%          {\MakeUppercase{\itaglossarynamebabel}}%
%  \gdef\glossaryname{\itaglossarynamebabel}
%  \refstepcounter{chapter}
%}

%===============================================================================
% Centralizar e ajustar os espacamentos dos captions das figuras e tabelas
%===============================================================================
\def\fnum@figure{\centering\MakeUppercase{\figurename}\nobreakspace\thefigure}
\def\fnum@table{\centering\MakeUppercase{\tablename}\nobreakspace\thetable}
\setlength\abovecaptionskip{6\p@}
\setlength\belowcaptionskip{4\p@}

% Redefinicao do caracter que separa o label Figura ou Tabela do texto
%\renewcommand*\captionlabeldelim{\ --}

%===============================================================================
% Indentar a segunda linha de captions longos das listas de figuras e tabelas
%===============================================================================
\renewcommand*{\l@figure}{\@dottedtocline{1}{0cm}{1cm}}
\def\FigureITA@dottedtocline#1#2#3#4#5{\begingroup
  \def\numberline##1{\hb@xt@\@tempdima{\itafigurenamebabel~##1 --\hfil}}%
  \@dottedtocline{#1}{#2}{#3}{#4}{#5}%
\endgroup}
\def\TableITA@dottedtocline#1#2#3#4#5{\begingroup
  \def\numberline##1{\hb@xt@\@tempdima{\itatablenamebabel~##1 --\hfil}}%
  \@dottedtocline{#1}{#2}{#3}{#4}{#5}%
\endgroup}
% faz a lista de figuras e de tabelas usarem as novas versoes dos \dottedtocline
\renewcommand*\l@figure{\FigureITA@dottedtocline{1}{0cm}{2.8cm}}
\renewcommand*\l@table{\TableITA@dottedtocline{1}{0cm}{2.8cm}}

%===============================================================================
% Folha de Registro do Documento
%===============================================================================
\newcommand{\esp}{.2cm}


% Definicoes dos valores dos campos do formulario
\newcommand{\FRDitadata}[1]{\gdef\FRDitadatababel{#1}}
\newcommand{\FRDitadocnro}[1]{\gdef\FRDitadocnrobabel{#1}}


\gdef\FRDitaorgaointernobabel{\italongname\ -- \itashortname}
\newcommand{\FRDitaorgaointerno}[1][\italongname\ -- \itashortname]{\gdef\FRDitaorgaointernobabel{#1}}

\newcommand{\FRDitapalavrasautor}[1]{\gdef\FRDitapalavrasautorbabel{#1}}
\newcommand{\FRDitapalavrasresult}[1]{\gdef\FRDitapalavrasresultbabel{#1}}
\newcommand{\FRDitapalavraapresentacao}[1]{\gdef\FRDitapalavraapresentacaobabel{#1}}

\newcommand{\FRDitaresumo}[1]{
  \gdef\FDRitaabstractcontent{#1}
}

% Opções para documento
\newcommand{\FRDitaOpcoes}[2]{

% Nacional ou Internacional - N/I
  \gdef\N{\ } \gdef\I{\ }
  \ifthenelse{\equal{#1}{N}}{\gdef\N{\textbf{X}}}{}
  \ifthenelse{\equal{#1}{I}}{\gdef\I{\textbf{X}}}{}

% Ostensivo, Reservado, Secreto ou Ultrasecreto - O/R/S/U
% Níveis de confidencialidade definitos pela Lei de Acesso à  Informação (LAI)
% Lei nº 12.527, de 18/11/2011
% https://wikilai.fiquemsabendo.com.br/wiki/Texto_da_LAI
  \gdef\O{\ } \gdef\R{\ } \gdef\S{\ } \gdef\U{\ }
  \ifthenelse{\equal{#2}{O}}{\gdef\O{\textbf{X}}}{}
  \ifthenelse{\equal{#2}{R}}{\gdef\R{\textbf{X}}}{}
  \ifthenelse{\equal{#2}{S}}{\gdef\S{\textbf{X}}}{}
  %\ifthenelse{\equal{#2}{U}}{\gdef\S{\textbf{X}}}{}
}

% Folha de Registro de Documento (FRD)
\newcommand{\itaFRD}{

  \if@openright\cleardoublepage\else\clearpage\fi

  \newgeometry{tmargin=25mm,
               bmargin=20mm,
               lmargin=30mm,
               rmargin=30mm}

  % Remove header and footer from this page
  \thispagestyle{empty}
  \fancyhf{} % Set header and footer to blank
  \renewcommand{\headrulewidth}{0pt}

  % Configurações de espaçamento
  \singlespacing
  \footnotesize
  \setlength{\baselineskip}{0.1\baselineskip}
  \setlength{\parskip}{.1em}
  \setlength{\extrarowheight}{2pt}

  % Adicionar FRD ao outline do documento pdf
  \pdfbookmark[0]{\itapagedocregbabel}{bla}

  % Conteuro da FRD
  \noindent\begin{tabularx}{\textwidth}{|l|l|l|l|}
    \hline
    \multicolumn{ 4}{|c|}{                                          } \\
    \multicolumn{ 4}{|c|}{\normalsize FOLHA DE REGISTRO DO DOCUMENTO} \\
    \multicolumn{ 4}{|c|}{                                          } \\
    \hline

    $^{1.}$ \scriptsize CLASSIFICAÇÃO/TIPO &
    $^{2.}$ \scriptsize DATA               &
    $^{3.}$ \scriptsize REGISTRO Nº        &
    $^{4.}$ \scriptsize Nº DE PÁGINAS      \tabularnewline

    \multicolumn{ 1}{|c|}{
      \ifthenelse{\equal{\itaoptionlevel}{tg}}
        {TC}
        {\ifthenelse{\equal{\itaoptionlevel}{msc}}
          {DM}
          {TD}
        }
    } &
    \multicolumn{ 1}{c|}{\FRDitadatababel              } &
    \multicolumn{ 1}{c|}{\scriptsize \FRDitadocnrobabel} &
    \multicolumn{ 1}{c|}{\NumPenultimaPagina           } \tabularnewline
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{5.}$ \scriptsize TÍTULO E SUBTÍTULO:} \\
    \multicolumn{ 4}{|l|}{\nh{\parbox[b]{.97\textwidth}{\@title}}} \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{6.}$ \scriptsize
      \ifthenelse{\equal{\authorgendermf}{mas}}{AUTOR}{AUTORA}:} \\
    \multicolumn{ 4}{|l|}{\textbf{\@authorfirst\ \@authorlast}}  \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{7.}$ \scriptsize
      INSTITUIÇÃO(ÕES)/ÓRGÃO(S) INTERNO(S)/DIVISÃO(ÕES):} \\
    \multicolumn{ 4}{|l|}{\FRDitaorgaointernobabel} \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{8.}$ \scriptsize
      PALAVRAS-CHAVE SUGERIDAS
      \ifthenelse{\equal{\authorgendermf}{mas}}{PELO AUTOR}{PELA AUTORA}:} \\
    \multicolumn{ 4}{|p{0.97\textwidth}|}{\FRDitapalavrasautorbabel} \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{9.}$ \scriptsize
      PALAVRAS-CHAVE RESULTANTES DE INDEXAÇÃO:} \\
    \multicolumn{ 4}{|p{0.97\textwidth}|}{\FRDitapalavrasresultbabel} \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{10.}$ {\scriptsize APRESENTAÇÃO:} \hfill
      \textbf{(\N) Nacional\ \ \ (\I) Internacional}} \\
    \multicolumn{ 4}{|p{0.97\textwidth}|}{\FRDitapalavraapresentacaobabel} \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{11.}$ \scriptsize RESUMO:} \\
    %\multicolumn{ 4}{|p{0.97\textwidth}|}{\parbox[t][12cm]{0.97\textwidth}{\FDRitaabstractcontent}} \\
    \multicolumn{ 4}{|c|}{\parbox[t][12cm]{.97\textwidth}{\FDRitaabstractcontent}} \\
    [\esp]
    \hline
    \multicolumn{ 4}{|l|}{$^{12.}$ \scriptsize GRAU DE SIGILO:} \\
    \multicolumn{ 4}{|c|}{       \hfill\
      (\O) \textbf{OSTENSIVO}    \hfill\
      (\R) \textbf{RESERVADO}    \hfill\
      (\S) \textbf{SECRETO}      \hfill\
      %(\U) \textbf{ULTRASECRETO} \hfill\
      } \\
    [\esp]
    \hline
  \end{tabularx}
}

%===============================================================================
% Hack: Retirando a palavra Capitulo mas mantendo Anexo e Apendice no índice
% \@makechapterhead é chamado por \chapter
%===============================================================================
\def\@makechapterhead#1{%
  \vspace*{50\p@}%
  {\parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne
      \if@mainmatter
        % Se "anexo" não foi definido, altera cabecalho do capitulo
        % Senao, mantem a palavra Anexo ou Apêndice
        \@ifundefined{anexo}
          {\huge\bfseries \thechapter\space}
          {\huge\bfseries \@chapapp\space \thechapter \space -}
      \fi
    \fi
    \interlinepenalty\@M
    \Huge \bfseries #1\par\nobreak
    \vskip 40\p@
  }
}

%===============================================================================
% Obtendo o numero da penultima pagina, visto que a FRD nao é contada
% Thanks to Dr. Miguel V. S. Frasson!! :-)
%===============================================================================
\def\deixasosegundo#1#2#3!{#2}
\makeatletter
\AtBeginDocument{%
  % Se a refêrencia à última página não existe, definir como ??
  \expandafter\ifx\csname r@LastPage\endcsname\relax
    \newcommand\NumPenultimaPagina{{\bfseries??}}%
  \else
    \newcounter{butlastpage}%
    \setcounter{butlastpage}{\expandafter\deixasosegundo\r@LastPage!}%
    \addtocounter{butlastpage}{-1}%
    \newcommand\NumPenultimaPagina{}%
    \edef\NumPenultimaPagina{\arabic{butlastpage}}%
  \fi
}
