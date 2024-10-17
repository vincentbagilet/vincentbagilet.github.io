%%%%%%%%%%%%%%%%%
% This is altacv.cls (v1.1.3, 30 April 2017) written by
% LianTze Lim (liantze@gmail.com).
% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2003/12/01 or later.
%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{altacv}[2017/04/30 AltaCV v1.1.3, yet another alternative class for a résumé/curriculum vitae.]

%% v1.1: Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}

%% v1.1: Optionally load academicons
\if@academicons
  %% Patch to make academicons compilable with XeLaTeX
  \ExplSyntaxOn
  \msg_redirect_name:nnn { fontspec } { font-not-found } { none }
  \ExplSyntaxOff
  \RequirePackage{academicons}
  \newfontfamily{\AI}{academicons.ttf}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
\RequirePackage{ragged2e}
% \RequirePackage{marginfix}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

\definecolor{NiceGreen}{HTML}{259D48}
\definecolor{NiceYellow}{HTML}{F7BF39}
\definecolor{NiceRed}{HTML}{DA3F33}
\definecolor{NiceBlue}{HTML}{032A97}
\definecolor{GitHubPuple}{HTML}{8137A4}

\newcommand{\emailsymbol}{\color{NiceBlue}\faAt}
\newcommand{\phonesymbol}{\color{NiceGreen}\faPhone}
\newcommand{\homepagesymbol}{\color{black}\faChain}
\newcommand{\locationsymbol}{\color{NiceRed}\faMapMarker}
\newcommand{\unisymbol}{\color{gray}\faUniversity}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\color{GitHubPuple}\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\color{NiceYellow}\faEnvelope}

\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{#1}\hspace{0.5em}#2\hspace{2em}}}

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{\Large#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\email}[1]{\normalsize \printinfo{\emailsymbol}{#1}}
\newcommand{\mailaddress}[1]{\printinfo{\mailsymbol}{#1}}
\newcommand{\phone}[1]{\printinfo{\phonesymbol}{#1}}
\newcommand{\homepage}[1]{\printinfo{\homepagesymbol}{#1}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{#1}}
\newcommand{\linkedin}[1]{\printinfo{\linkedinsymbol}{#1}}
\newcommand{\github}[1]{\printinfo{\githubsymbol}{#1}}
\newcommand{\orcid}[1]{\printinfo{\orcidsymbol}{#1}}
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}

\newcommand{\personalinfo}[1]{\def\@personalinfo{\small#1}}

\newcommand{\makecvheader}{%
  \begingroup
    \ifdef{\@photodiameter}{\begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}}{}%
    \raggedright\color{emphasis}%
    {\huge\color{heading}\MakeUppercase{\@name}\par}
    \medskip
    %{\large\color{emphasis}\@tagline\par}
   % \vspace{6pt}
    {\footnotesize\bfseries\@personalinfo\par}
    \ifdef{\@photodiameter}{%
    \end{minipage}\hfill%
    \begin{minipage}{\@photodiameter}
    \if@normalphoto
      \includegraphics[width=\linewidth]{\@photo}
    \else
      \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
    \fi%
    \end{minipage}\par}{}%
  \endgroup\medskip
}

\renewenvironment{quote}{\color{accent}\itshape\large}{\par}

\newcommand{\cvsection}[2][]{%
  \medskip%
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}% 
  {\color{heading}\Large\scshape{#2}}\\[-1.2ex]%
  {\color{heading}\rule{\linewidth}{0.6pt}\par}\medskip
}

\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{emphasis}\large\textbf{#1}\par}
  \vspace{0.5em}
  \medskip
}

\newcommand{\cvevent}[4]{%
  {\normalsize \color{accent}\textbf{#1}\hfill \ifstrequal{#3}{}{}{\small \color{emphasis}\hspace{0.5em}#3} \par}
  \vspace{2pt}
  \normalsize \color{body}\quad #2 \hfill \ifstrequal{#4}{}{}{\small \color{NiceRed} \faMapMarker \color{body} \hspace{0.3em} \textit{#4}} \par
  {}
  \vspace{8pt}
}

\newcommand{\cveventshort}[2]{%
  {\normalsize \color{accent} #1 \hfill}{\small #2 \par}
  \vspace{0.5em}
}

%\newcommand{\cvworkingpaper}[4]{%
%  {\normalsize \color{body}  \href{#3}{\textit{#1}}, ~with #2 ~\small\href{#4}{\faDownload}}
%  \medskip
%}
\newcommand{\cvworkingpaper}[5]{%
	\normalsize \color{accent}  \textbf{#1}\color{body}
  	\ifstrequal{#2}{}{}{%
  		\textit{, joint with #2}%
	} 
  	\ifstrequal{#3}{}{}{%
		\href{#3}{
		[\textit{Project website} \footnotesize \color{NiceBlue}\faExternalLink\normalsize, }
	}
	\ifstrequal{#4}{}{}{%
		\href{#4}{\textit{Download} \footnotesize \color{NiceBlue}\faDownload}] \normalsize
	}
	\ifstrequal{#5}{}{}{ %
		%\small
		\begin{center}
			\begin{adjustwidth}{0.5cm}{0.5cm}
				\justifying
				\textbf{\textsc{Abstract:}} #5
			\end{adjustwidth}
		\end{center}
	}
  	\medskip
	}

\newcommand{\cvachievement}[3]{%
  \begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
  \multirow{2}{*}{\Large\color{accent}#1} & \bfseries\textcolor{emphasis}{#2}\\
  & #3
  \end{tabularx}%
  \smallskip
}

\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

\newcommand{\cvskill}[2]{%
\textcolor{emphasis}{\scshape \textbf{#1}}\hfill
\foreach \x in {1,...,5}{%
  \space{\ifnumgreater{\x}{#2}{\color{body!30}}{\color{heading}}\faStop}}\par%
}

\newcommand{\cvonelinelist}[2]{%
  {\normalsize \color{accent} \textsc{\textbf{#1}}:}{ #2}
  \vspace{0.5em}
}

\newcommand{\cvref}[5]{%
  \textcolor{emphasis}{\textbf{#1}}\par
   \smallskip
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.25em]
  \item[\small\unisymbol] #2
  \item[\small\mailsymbol] #3
  \item[\small\phonesymbol] #4
  \item[\emailsymbol] #5
  \end{description}
   \medskip
}

\newenvironment{cvcolumn}[1]{\begin{minipage}[t]{#1}\raggedright}{\end{minipage}}

\RequirePackage[backend=biber,style=authoryear,sorting=ydnt]{biblatex}
%% For removing numbering entirely when using a numeric style
% \setlength{\bibhang}{1em}
% \DeclareFieldFormat{labelnumberwidth}{\makebox[\bibhang][l]{\itemmarker}}
% \setlength{\biblabelsep}{0pt}
\defbibheading{pubtype}{\cvsubsection{#1}}
\renewcommand{\bibsetup}{\vspace*{-\baselineskip}}
\AtEveryBibitem{\makebox[\bibhang][l]{\itemmarker}}
\setlength{\bibitemsep}{0.25\baselineskip}

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}
