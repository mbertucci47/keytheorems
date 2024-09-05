# keytheorems

A LaTeX package to use [`amsthm`](https://www.ctan.org/pkg/amsthm)
with a key-value interface. Meant to emulate most of the functionality of [`thmtools`](https://www.ctan.org/pkg/thmtools)
but written in expl3. The goal was just an exercise in using expl3, but if you find a bug
feel free to open an issue or PR.

## Sample document
```tex
\documentclass{article}
\usepackage{amssymb,amsmath}
\usepackage{keytheorems}
\usepackage{hyperref}

\newkeytheoremstyle{mystyle}{
    % <insert options>
    }
\newkeytheorem{theorem}[
    style=mystyle,
    parent=section
    ]
\newkeytheorem{remark}[
    style=remark,
    numbered=no
    ]

\begin{document}

\section{Some theorems}

\begin{theorem}[
    note=Strong Bertini over $\mathbb{C}$,
    label=strongbertini
    ]
Let $X$ be a smooth complex variety and let $\mathfrak{D}$ be a positive dimensional linear system on $X$.
Then the general element of $\mathfrak{D}$ is smooth away from the base locus $B_{\mathfrak{D}}$. That is, the set
    \[\{H\in\mathfrak{D}\mid D_H \text{ is smooth away from } B_{\mathfrak{D}}\}\]
is a Zariski dense open subset of $\mathfrak{D}$.
\end{theorem}

\begin{remark}
In fact, \autoref{strongbertini} holds over any algebraically closed field of characteristic zero.
\end{remark}

\begin{theorem}[Bertini over any field]
Let $X\subset\mathbb{P}_k^n$ be a smooth projective variety over a field $k$. Then the set of hyperplanes
$H\subseteq\mathbb{P}_k^n$ such that $X\cap H$ is smooth is a Zariski dense open subset of $(\mathbb{P}_k^n)^*$.
\end{theorem}

\listofkeytheorems

%%% compare with
%\listofkeytheorems[ignoreall,show=theorem]
%\listofkeytheorems[swapnumber]
%\listofkeytheorems[title=BLUB]
%\listofkeytheorems[print-body] % needs 'store-all' package option

\end{document}
```

## Documentation
There is a list of commands and keys offered by the package
[here](https://github.com/mbertucci47/keytheorems/blob/main/doc/keytheorems-doc.pdf).
More of a reference document than documentation.

## Differences with thmtools

Some of the code is a direct translation from thmtools but a few things are changed:
- The only backend supported is amsthm, and it is loaded by the package. As I understand it,
  [`ntheorem`](https://www.ctan.org/pkg/ntheorem) has quite a few bugs and no active development, and
  if you're just using the kernel `\newtheorem` then you don't need a package like this.
- Theorem hooks use the kernel hooks. Thus unlike the `prefoot` and `postfoot` hooks of
  thmtools, all code chunks are added to hooks in the order declared (unless given a
  distinct label; then the chunks are reversed). The order of generic/specific hooks
  remains the same. Furthermore, the command for adding to theorem hooks is `\addtotheoremhook{<hook name>}{<theorem name>}`.
- thmtools changes some style settings to be default that are different from
  amsthm defaults, but only if a custom style is called. Example:
  ```tex
  \declaretheoremstyle[spaceabove=20pt]{mythmsty}
  \declaretheorem[style=mythmsty]{mythm}
  ```
  
  is different from just
  
  ```tex
  \declaretheorem{mythm}
  ```
  
  as in the former, `bodyfont` is `\normalfont`, not the default `\itshape`.
  This package keeps the defaults unless a key is specifically given.
- There is no `restatable` environment except with package option `thmtools-compat`. Use the
  `store` (alias `restate`) key.
- Rather than `restate=foo` defining a command `\foo*`, theorems are retrieved with `\getkeytheorem{foo}`.
  For just the theorem body, use `\getkeytheorem[body]{foo}`. Also, this retrieval
  can happen even before the theorem is stated since keytheorems writes the contents
  to a file.
- The `shaded` and `thmbox` keys are only available with the package option `thmtools-compat`,
  and they are emulated with [`tcolorbox`](https://www.ctan.org/pkg/tcolorbox). Instead there's
  an interface to tcolorbox with the `tcolorbox={<options>}` and `tcolorbox-no-titlebar={<options>}` key.
  The `mdframed` key is not implemented.
- You can reuse styles with the `inherit-style` key.
- With thmtools, the command `\newtheorem{<envname>}{<heading>}` is changed to behave like
  `\declaretheorem[name=<heading>]{<envname>}`. This is not the default here. Instead either
  only use the new interface or load the package with option `overload`.
- All new keys (see doc for descriptions):
  - global (load-time or in `\keytheoremset`): `overload`, `thmtools-compat`, `store-all`, `restate-counters`, `continues-code`, `qed-symbol`, `auto-translate`
  - keys for theorem envs: `note` (alias `name`), `short-note`, `continues*`, `store` (alias `restate`), `seq`
  - declaring theorems (in `\newkeytheorem`): `tcolorbox`, `tcolorbox-no-titlebar`
  - declaring styles (in `\newkeytheoremstyle`): `inherit-style`
  - list of theorems (in `\keytheoremlistset` and `\listofkeytheorems`): `onlynumbered`, `seq`, `title-code`, `no-title`, `note-code`, `print-body`, `no-continues`, `no-chapter-skip`, `chapter-skip-length`

## thmtools issues resolved by keytheorems
Issues from the thmtools [github page](https://github.com/muzimuzhi/thmtools),
with corresponding keytheorems code that shows the issue resolved.
### [\listoftheorems: filter out restated ones #7](https://github.com/muzimuzhi/thmtools/issues/7)
keytheorems does not list restated theorems in the `\listofkeytheorems`.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{theorem}

\begin{document}

\begin{theorem}[store=foo]
text
\end{theorem}

\getkeytheorem{foo}

\listofkeytheorems

\end{document}
```

### [\listoftheorems: hide title #8](https://github.com/muzimuzhi/thmtools/issues/8)
keytheorems provides the `no-title` key.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{axiom}
\newkeytheorem{theorem}

\begin{document}

\listofkeytheorems[ignoreall,show=axiom]
\listofkeytheorems[ignoreall,show=theorem,no-title]
     
\begin{axiom}
some axiom
\end{axiom}

\begin{theorem}
some theorem
\end{theorem}

\begin{axiom}
another axiom
\end{axiom}

\begin{theorem}
another theorem
\end{theorem}

\end{document}
```

### [Case in point: the tcolorbox key #9](https://github.com/muzimuzhi/thmtools/issues/9)
keytheorems provides the `tcolorbox` and `tcolorbox-no-titlebar` keys.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{theorem}[
  tcolorbox={
    colback=blue!10,
    colframe=blue!75
    }
  ]
\newkeytheorem{corollary}[
  tcolorbox-no-titlebar={colback=red!10}
  ]

\begin{document}

\begin{theorem}
some theorem
\end{theorem}

\begin{corollary}
some corollary
\end{corollary}

\end{document}
```

### [thm-listof: document \thmtformatoptarg, new list option? #14](https://github.com/muzimuzhi/thmtools/issues/14)
keytheorems provides the `note-code` key for `\listofkeytheorems` and
`\keytheoremlistset`.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{theorem}

\begin{document}

\begin{theorem}[my heading]
some theorem
\end{theorem}

\listofkeytheorems[note-code={ [\textit{#1}]}]

\end{document}
```

### [Style inheritance in thmtools #15](https://github.com/muzimuzhi/thmtools/issues/15)
keytheorems provides the `inherit-style` key.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheoremstyle{mysty1}{notefont=\itshape}
\newkeytheoremstyle{mysty2}{inherit-style=mysty1,bodyfont=\normalfont}
\newkeytheorem{theorem}[style=mysty1]
\newkeytheorem{corollary}[style=mysty2]

\begin{document}

\begin{theorem}[my heading]
some theorem
\end{theorem}

\begin{corollary}[my heading]
some corollary
\end{corollary}

\end{document}
```

### [Restate without theorem headings (head + note) #19](https://github.com/muzimuzhi/thmtools/issues/19)
Use `\getkeytheorem[body]{foo}`.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{theorem}

\begin{document}

\begin{theorem}[store=hello]
Hello!
\end{theorem}

\getkeytheorem{hello}

\section{\getkeytheorem[body]{hello}}

\end{document}
```

### [Option clash: numbered=no and thmbox #25](https://github.com/muzimuzhi/thmtools/issues/25)
Fixed with keytheorem's implementation of the `thmbox` key with `thmtools-compat`.
```tex
\documentclass{article}
\usepackage[thmtools-compat]{keytheorems}

\declaretheorem[numbered=no, name=TheoremA,         ]{mytheo1}
\declaretheorem[             name=TheoremB, thmbox=M]{mytheo2}
\declaretheorem[numbered=no, name=TheoremC, thmbox=M]{mytheo3}

\begin{document}

\begin{mytheo1}
    test1
\end{mytheo1}

\begin{mytheo2}
    test2
\end{mytheo2}

\begin{mytheo3}
    test3
\end{mytheo3}

\end{document}
```

### [Skip the title of the theorem but leave the []. #30](https://github.com/muzimuzhi/thmtools/issues/30)
Fixed in keytheorems.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{Teorema}[name=Theorem]

\begin{document}

\begin{Teorema}
  body
\end{Teorema}

\begin{Teorema}[]
  body
\end{Teorema}

\begin{Teorema}[title]
  body
\end{Teorema}

\end{document}
```

### [too much space with restatable #40](https://github.com/muzimuzhi/thmtools/issues/40)
Fixed in keytheorems.
```tex
\documentclass{article}
\usepackage{keytheorems}
\usepackage{kantlipsum}

\newkeytheorem{theorem}

\begin{document}

\begin{theorem}
\kant[2][1]
\end{theorem}

\begin{theorem}[store=foo]
\kant[1][2]
\end{theorem}

\begin{theorem}
\kant[2][1]
\end{theorem}

\getkeytheorem{foo}

\end{document}
```

### [restate key with no name leads to (,) in restated title #41](https://github.com/muzimuzhi/thmtools/issues/41)
Fixed in keytheorems.
```tex
\documentclass{article}
\usepackage{keytheorems}
\usepackage{kantlipsum}

\newkeytheorem{theorem}

\begin{document}

\begin{theorem}[restate=foo]
\kant[1][2]
\end{theorem}

\getkeytheorem{foo}

\begin{theorem}[restate=foobar,name=Heading]
\kant[2][1]
\end{theorem}

\getkeytheorem{foobar}

\end{document}
```
### [[Help Wanted] Print all Theorems? #43](https://github.com/muzimuzhi/thmtools/issues/43)
Use the `store-all` load-time option with `\listofkeytheorems[print-body]`.
```tex
\documentclass{article}
\usepackage[store-all]{keytheorems}

\newkeytheorem{theorem}
\newkeytheorem{lemma}

\begin{document}

\begin{theorem}
some theorem
\end{theorem}

\begin{lemma}
some lemma
\end{lemma}

\listofkeytheorems[print-body]

\end{document}
```

### [qed option without value fails in \declaretheoremstyle #47](https://github.com/muzimuzhi/thmtools/issues/47)
Fixed in keytheorems.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheoremstyle{mythmsty}{qed}
\newkeytheorem{theorem}[style=mythmsty]

\begin{document}

\begin{theorem}
Text
\end{theorem}

\end{document}
```

### [prefoot and postfoot hooks called twice with restate key #54](https://github.com/muzimuzhi/thmtools/issues/54)
Fixed in keytheorems.
```tex
\documentclass{article}
\usepackage{keytheorems}

\newkeytheorem{theorem}

\addtotheoremhook{prehead}{PREHEAD}
\addtotheoremhook{posthead}{POSTHEAD}
\addtotheoremhook{prefoot}{PREFOOT}
\addtotheoremhook{postfoot}{POSTFOOT}

\begin{document}

\begin{theorem}
body text
\end{theorem}

\begin{theorem}[store=foo]
body text
\end{theorem}

\end{document}
```

### [restate key incompatible with beamer #58](https://github.com/muzimuzhi/thmtools/issues/58)
```tex
\documentclass{beamer}
\setbeamertemplate{theorems}[numbered]
\usepackage{keytheorems}

\newkeytheorem{MyTheorem}

\begin{document}

\begin{frame}
\begin{MyTheorem}[restate=foo]
text
\end{MyTheorem}

\getkeytheorem{foo}
\end{frame}

\end{document}
```

## Things to do

- Clean up the code. Things are out of order, poorly named, etc.
- Add more error messages.
- thmtools features not yet implemented
    - labels pointing to restated theorem, not original
    - real [`beamer`](https://ctan.org/pkg/beamer) support
    - certainly more
- For a complete list, see [`keytheorems-ideas.txt`](https://github.com/mbertucci47/keytheorems/blob/main/keytheorems-ideas.txt)
 
## Notes/issues on thmtools, not on Github

### continues with unless unique and restate
Should this be numbered or not?
```tex
\documentclass{article}
\usepackage{amsthm,thmtools}

\declaretheorem[numbered=unless unique]{theorem}

\begin{document}

\begin{theorem}[label=foo]
bla
\end{theorem}

\begin{theorem}[continues=foo]
bla
\end{theorem}

\end{document}
```
It does the correct thing when a parent counter is given and is split across that counter.
```tex
\documentclass{article}
\usepackage{amsthm,thmtools}

\declaretheorem[numbered=unless unique,parent=section]{theorem}

\begin{document}

\begin{theorem}[label=foo]
bla
\end{theorem}

\section{bla}

\begin{theorem}[continues=foo]
bla
\end{theorem}

\end{document}
```
Also adds a number if restated, which seems wrong.
```tex
\documentclass{article}
\usepackage{amsthm,thmtools}

\declaretheorem[numbered=unless unique]{theorem}

\begin{document}

\begin{restatable}{theorem}{foo}
bla
\end{restatable}

\foo*

\end{document}
```

### qed in both `\declaretheoremstyle` and `\declaretheorem`
One would expect the one in `\declaretheorem` to overwrite, but because the code just adds to the hooks without checking,
it's additive.
```tex
\documentclass{article}
\usepackage{amsthm,thmtools}

\declaretheoremstyle[qed=$\clubsuit$]{mysty}
\declaretheorem[style=mysty,qed]{theorem}

\begin{document}

\begin{theorem}
bla
\end{theorem}

\end{document}
```

### restate incompatible with thmbox
```tex
\documentclass{article}
\usepackage{amsthm,thmtools}

\declaretheorem[thmbox]{theorem}

\begin{document}

\begin{theorem}[restate=foo]
bla
\end{theorem}

\foo*

\end{document}
```

### adding to listoftheorems doesn't work as expected
```tex
\documentclass{article}
\usepackage{amsthm,thmtools}

\declaretheorem{theorem}

\begin{document}

\begin{theorem}
bla
\end{theorem}

\addcontentsline{loe}{section}{some text}

\begin{theorem}
bla
\end{theorem}

\listoftheorems

\end{document}
```

### new theorem styles do not preserve "plain" keys
With keytheorems, this is handled only for the AMS classes and acmart.
```tex
\documentclass{amsbook}
\usepackage{thmtools}

\declaretheoremstyle[bodyfont=\upshape]{upsty}
\declaretheorem{theorem}
\declaretheorem[style=upsty]{lemma}

\begin{document}

\begin{theorem}
blub
\end{theorem}

\begin{lemma}
blub
\end{lemma}

\end{document}
```