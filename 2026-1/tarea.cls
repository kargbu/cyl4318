\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tarea}[2025/08/31 v1]

\LoadClass[article]{memoir}

%Opciones para la clase
\newif\ifisirc
\newif\ifisfc
\DeclareOption{irc}{\isirctrue}
\DeclareOption{fc}{\isfctrue}
\ProcessOptions\relax

\ifisirc
\settypeblocksize{17cm}{15cm}{*}%279 x 216
\setlrmargins{2cm}{*}{1}
\setulmargins{6cm}{*}{*}
\setheadfoot{5cm}{1cm}
\setmarginnotes{0.5cm}{3cm}{0.2cm}
\checkandfixthelayout
\fi

\ifisfc
\setlrmarginsandblock{2.5cm}{*}{1}
\setulmarginsandblock{7cm}{2.5cm}{*}
\setheadfoot{5cm}{1cm}
\setmarginnotes{0pt}{0pt}{0pt}
\checkandfixthelayout
\fi

%paquetes
\RequirePackage[spanish,mexico,es-noindentfirst]{babel}
\RequirePackage{mathtools}
\RequirePackage{xsim}
\RequirePackage{tasks}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{tikz-cd}
\RequirePackage{fontspec}
\RequirePackage{unicode-math}

\ExplSyntaxOn
\NewDocumentCommand{\makeabbrev}{mmm}
 {
  \myab_makeabbrev:nnn { #1 } { #2 } { #3 }
 }

\cs_new_protected:Npn \myab_makeabbrev:nnn #1 #2 #3
 {
  \clist_map_inline:nn { #3 }
   {
    \cs_new_protected:cpn { #2 } { #1 { ##1 } }
   }
 }
\ExplSyntaxOff

%vectores
\makeabbrev{\symbfit}{vect#1}{a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z} 
%estructuras numéricas
\makeabbrev{\symbb}{bb#1}{C,N,Q,R,Z}

\SetExerciseParameters{exercise}{
  exercise-name = Ejercicio,
  solution-name = Solución,
  exercise-heading = \paragraph,
  solution-heading = \paragraph
}

\xsimsetup{%
  exercise/pre-hook = {\vspace{-10pt}},
  exercise/post-hook = {\vspace{3pt}},
  solution/pre-hook = {\vspace{-15pt}\color{violet}},
  solution/post-hook = {\vspace{3pt}}
}

\NewTasksEnvironment[label-format={\color{violet!80}},item-format={\color{violet!80}}]{res}[*]

%definiciones recurrentes

%puntas más chicas para las flechas
\tikzcdset{arrow style=tikz, diagrams={>={Classical TikZ Rightarrow[]}}}

%Capítulos
\makechapterstyle{tareas}{%
\renewcommand{\chapterheadstart}{}
\renewcommand{\chapnamefont}{\Large\bfseries}
\renewcommand{\chapnumfont}{\Large\bfseries}
\renewcommand{\chaptitlefont}{\Large\bfseries}
\renewcommand{\printchaptername}{}
\renewcommand{\printchapternum}{\chapnumfont\thechapter}
\renewcommand{\afterchapternum}{ }
\renewcommand{\printchaptertitle}{\textcolor{gray}{\vrule}~\chaptitlefont}
\renewcommand{\afterchaptertitle}{\par\nobreak\vspace*{0.6\afterchapskip}}
}
\chapterstyle{tareas}



%diseño IRC
\ifisirc
%tokens para hacer el diseño
\newtoks\materia
\newtoks\tarex
\newlength{\nombre}
\setlength{\nombre}{\textwidth-\widthof{Nombre del alumne:}}

\newcommand{\info}{
  \begin{minipage}{0.4\linewidth}
    \raggedright%
    \includegraphics[width=0.9\linewidth]{logoIRC}
  \end{minipage}%
  \begin{minipage}{0.5\linewidth}
    {\large\bfseries\sffamily \the\materia}\\[1mm]
    {\scalebox{1.2}{\sffamily \the\tarex:\rule[-2pt]{1cm}{0.4pt}}}\\
    {\sffamily M. en F.C. Karina García Buendía}\\[1mm]
    {\sffamily Fecha de entrega:\rule[-2pt]{3cm}{0.4pt}}
  \end{minipage}%

  \vspace{5mm}

  \noindent Nombre del alumne:\rule[-2pt]{\nombre}{0.4pt}
}

\makeoddhead{plain}{\info}{}{}
\makeevenhead{plain}{\info}{}{}
\makeoddfoot{plain}{}{}{}
\makeevenfoot{plain}{}{}{}

\makepagestyle{irc}
\makeoddhead{irc}{\info}{}{}
\makeevenhead{irc}{\info}{}{}
\makeoddfoot{irc}{}{}{}
\makeevenfoot{irc}{}{}{}
\pagestyle{irc}
\fi


%diseño FC
\ifisfc
%fuentes
\newfontfamily{\arial}{Arial}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{10.5pt}{15pt}%
}
\normalsize

%tokens para llenar la información de la hoja de examen
\newtoks\examen
\newtoks\prof
\newtoks\materia
\newtoks\alum

%longitudes que serán útiles (usa el paquete calc)
\newlength{\ex}
\newlength{\pr}
\newlength{\pra}
\newlength{\ma}
\newlength{\na}
\newlength{\naa}
\setlength{\ex}{12.8cm-\widthof{\small\arial EXAMEN}}
\setlength{\pr}{12.8cm-\widthof{\small\arial PROFESOR}}
\setlength{\pra}{12.8cm-\widthof{\small\arial PROFESORA}}
\setlength{\ma}{12.8cm-\widthof{\small\arial MATERIA}}
\setlength{\na}{12.8cm-\widthof{\small\arial NOMBRE DEL ALUMNO}}
\setlength{\naa}{12.8cm-\widthof{\small\arial NOMBRE DE LA ALUMNA}}

\newcommand{\hojaa}{
\hspace{3.3cm}
\makebox[12.95cm][s]{\arial\fontsize{5mm}{1mm}\selectfont UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO}

\noindent%
\begin{minipage}[b]{3cm}
\centering
\includegraphics[width=3cm]{unam}
\end{minipage}%
\hspace{5mm}
\begin{minipage}[b]{\linewidth-3.68cm}
{\small\arial EXAMEN:}\rule[-2pt]{\ex}{0.4pt}%
\nobreak\hspace{-\ex} \the\examen\par
\vspace{3mm}
{\small\arial PROFESOR:}\rule[-2pt]{\pr}{0.4pt}%
\nobreak\hspace{-\pr} \the\prof\par
\vspace{3mm}
{\small\arial MATERIA:}\rule[-2pt]{\ma}{0.4pt}%
\nobreak\hspace{-\ma} \the\materia\par
\vspace{3mm}
{\small\arial NOMBRE DEL ALUMNE:}\rule[-2pt]{\na}{0.4pt}%
\nobreak\hspace{-\na} \the\alum
\end{minipage}
}

\newcommand{\hojab}{
\hspace{3.3cm}
\makebox[12.95cm][s]{\arial\fontsize{5mm}{1mm}\selectfont UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO}

\noindent%
\begin{minipage}[b]{3cm}
\centering
\includegraphics[width=3cm]{unam}
\end{minipage}%
\hspace{5mm}
\begin{minipage}[b]{\linewidth-3.68cm}
{\small\arial EXAMEN:}\rule[-2pt]{\ex}{0.4pt}%
\nobreak\hspace{-\ex} \the\examen\par
\vspace{3mm}
{\small\arial PROFESORA:}\rule[-2pt]{\pra}{0.4pt}%
\nobreak\hspace{-\pra} \the\prof\par
\vspace{3mm}
{\small\arial MATERIA:}\rule[-2pt]{\ma}{0.4pt}%
\nobreak\hspace{-\ma} \the\materia\par
\vspace{3mm}
{\small\arial NOMBRE DEL ALUMNE:}\rule[-2pt]{\na}{0.4pt}%
\nobreak\hspace{-\na} \the\alum
\end{minipage}
}

\newcommand{\hojac}{
\hspace{3.3cm}
\makebox[12.95cm][s]{\arial\fontsize{5mm}{1mm}\selectfont UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO}

\noindent%
\begin{minipage}[b]{3cm}
\centering
\includegraphics[width=3cm]{unam}
\end{minipage}%
\hspace{5mm}
\begin{minipage}[b]{\linewidth-3.68cm}
{\small\arial EXAMEN:}\rule[-2pt]{\ex}{0.4pt}%
\nobreak\hspace{-\ex} \the\examen\par
\vspace{3mm}
{\small\arial PROFESOR:}\rule[-2pt]{\pr}{0.4pt}%
\nobreak\hspace{-\pr} \the\prof\par
\vspace{3mm}
{\small\arial MATERIA:}\rule[-2pt]{\ma}{0.4pt}%
\nobreak\hspace{-\ma} \the\materia\par
\vspace{3mm}
{\small\arial NOMBRE DE LA ALUMNA:}\rule[-2pt]{\naa}{0.4pt}%
\nobreak\hspace{-\naa} \the\alum
\end{minipage}
}

\newcommand{\hojad}{
\hspace{3.3cm}
\makebox[12.95cm][s]{\arial\fontsize{5mm}{1mm}\selectfont UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO}

\noindent%
\begin{minipage}[b]{3cm}
\centering
\includegraphics[width=3cm]{unam}
\end{minipage}%
\hspace{5mm}
\begin{minipage}[b]{\linewidth-3.68cm}
{\small\arial EXAMEN:}\rule[-2pt]{\ex}{0.4pt}%
\nobreak\hspace{-\ex} \the\examen\par
\vspace{3mm}
{\small\arial PROFESORA:}\rule[-2pt]{\pra}{0.4pt}%
\nobreak\hspace{-\pra} \the\prof\par
\vspace{3mm}
{\small\arial MATERIA:}\rule[-2pt]{\ma}{0.4pt}%
\nobreak\hspace{-\ma} \the\materia\par
\vspace{3mm}
{\small\arial NOMBRE DE LA ALUMNA:}\rule[-2pt]{\naa}{0.4pt}%
\nobreak\hspace{-\naa} \the\alum
\end{minipage}
}


%implementación
\makepagestyle{fc}
\makeoddfoot{fc}{}{}{}
\makeevenfoot{fc}{}{}{}
\NewDocumentCommand{\HojaExamen}{mm}{
  \ifblank{#1}
  {
    \ifblank{#2}{
      \makeoddhead{fc}{\hojad}{}{}
      \makeevenhead{fc}{\hojad}{}{}
    }
    {
      \makeoddhead{fc}{\hojab}{}{}
      \makeevenhead{fc}{\hojab}{}{}
    }
  }
  {
    \ifblank{#2}{
      \makeoddhead{fc}{\hojac}{}{}
      \makeevenhead{fc}{\hojac}{}{}
    }
    {
      \makeoddhead{fc}{\hojaa}{}{}
      \makeevenhead{fc}{\hojaa}{}{}
    }
  }
}

\pagestyle{fc}
\fi
