# key-theorems

A very much incomplete LaTeX package to use [`amsthm`](https://www.ctan.org/pkg/amsthm)
with a key-value interface. Meant to emulate most of the functionality of [`thmtools`](https://www.ctan.org/pkg/thmtools)
but written in expl3. The goal was just an exercise in using expl3, but if you find a bug
feel free to open an issue or PR.

## Sample document
```tex
\documentclass{article}
\usepackage{amssymb,amsmath}
\usepackage{key-theorems}
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
[here](https://github.com/mbertucci47/key-theorems/blob/main/doc/key-theorems-doc.pdf).
More of a reference document than documentation.

## Differences with `thmtools`

Most of the code is a direct translation from `thmtools`
but a few things are changed:
- The only backend supported is `amsthm`, and it is loaded by the package. As I understand it,
  [`ntheorem`](https://www.ctan.org/pkg/ntheorem) has quite a few bugs and no active development, and
  if you're just using the kernel `\newtheorem` then you don't need a package like this.
- Theorem hooks use the kernel hooks. Thus unlike the `prefoot` and `postfoot` hooks of
  `thmtools`, all code chunks are added to hooks in the order declared (unless given a
  distinct label; then the chunks are reversed). The order of generic/specific hooks
  remains the same.
- `thmtools` changes some style settings to be default that are different from
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
- The `restate=` code uses sequences from l3seq. What does this mean for speed/robustness?
  I have no idea. Also this is only implemented as a key, no `restatable` environment.
- `thmtools` allows keys meant for defining theorems to be used when defining theorem styles.
  Is this a good idea? Not currently implemented, but shouldn't be that difficult.
- The `shaded` and `thmbox` keys are not implemented. Instead there's an interface to [`tcolorbox`](https://www.ctan.org/pkg/tcolorbox)
  with the `tcolorbox={<options>}` key.
- You can reuse styles with the `inherit-style` key.
- With `thmtools`, the command `\newtheorem{<envname>}{<heading>}` is changed to behave like
  `\declaretheorem[name=<heading>]{<envname>}`. This is not the default here. Instead either
  only use the new interface or load the package with option `overload`.
- There are a few global options available with `\keytheoremset{<options>}` (see doc).

## Things to do

- Clean up the code. Things are out of order, poorly named, etc.
- Add error messages. Curently there are none...
- `thmtools` features not yet implemented
    - `numbered=unless unique` key (partially implemented)
    - labels pointing to restated theorem, not original
    - hyperlinking unnumbered theorems in list of theorems
    - certainly more
