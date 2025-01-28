# Changelog for keytheorems package

## [v0.2.5dev]
- disable `\index` and `\glossary` in restated theorems
- fix [\#11](https://github.com/mbertucci47/keytheorems/issues/11)

## [v0.2.4]
- fixed issue with too much expansion in `manual-num`
- fix [\#14](https://github.com/mbertucci47/keytheorems/issues/14)

## [v0.2.3]
- add many translations; some missing translation of "continuing from p."
- add `manual-num` key
- `leftmargin` and `rightmargin` now work correctly with tagging loaded

## [v0.2.2]
- fix implementation of `inherit-style` so it can contain thm keys
- add support for zref-clever in `refname` and `Refname`

## [v0.2.1]
- make several commands "long" so keyvals can contain `\par` tokens
- add `leftmargin` and `rightmargin` keys
- improve implementation of tcolorbox theorems

## [v0.1.8]
- add support for tagged PDF ([\#4](https://github.com/mbertucci47/keytheorems/issues/4))
- add tagged example file tagged-keytheorems-amsthmtest.tex

## [v0.1.7]
- add support for aomart class
- add support for Michael Sharpe's font packages that change plain style

## [v0.1.6]
- add `\renewkeytheorem`, `\providekeytheorem`, and `\declarekeytheorem` ([\#5](https://github.com/mbertucci47/keytheorems/issues/5))
- tcolorbox theorems no longer error with beamer
- add support for beamer action spec

## [v0.1.5]
- add `format-code` list key
- can now use `\thmname`, `\thmnumber`, `\thmnote` in `headformat`

## [v0.1.4]
- add `store-sets-label` option
- add `restatable*` environment for `thmtools-compat`
- add `numberfont` style key
- add `restate-keys` key
- styles defined with `\newkeytheoremstyle` now work as expected with `\theoremstyle`

## [v0.1.3]
- add `noteseparator` key
- add `\IfRestatingT`, `\IfRestatingF`
- add `store*` key
- add Portuguese translations

## [v0.1.2]
- Move support for memoir and AMS classes to dedicated files
- document `headformat` key
- add Italian translations
- add `indent` list key
- add `no-toc` list key
- documentation improvements

## [v0.1.1] - 2024-09-09
- First CTAN release

## 0.1.0 - 2024-09-04
- First release

[v0.2.5dev]: https://github.com/mbertucci47/keytheorems/compare/v0.2.4...HEAD
[v0.2.4]: https://github.com/mbertucci47/keytheorems/compare/v0.2.3...v0.2.4
[v0.2.3]: https://github.com/mbertucci47/keytheorems/compare/v0.2.2...v0.2.3
[v0.2.2]: https://github.com/mbertucci47/keytheorems/compare/v0.2.1...v0.2.2
[v0.2.1]: https://github.com/mbertucci47/keytheorems/compare/v0.1.8...v0.2.1
[v0.1.8]: https://github.com/mbertucci47/keytheorems/compare/v0.1.7...v0.1.8
[v0.1.7]: https://github.com/mbertucci47/keytheorems/compare/v0.1.6...v0.1.7
[v0.1.6]: https://github.com/mbertucci47/keytheorems/compare/v0.1.5...v0.1.6
[v0.1.5]: https://github.com/mbertucci47/keytheorems/compare/v0.1.4...v0.1.5
[v0.1.4]: https://github.com/mbertucci47/keytheorems/compare/v0.1.3...v0.1.4
[v0.1.3]: https://github.com/mbertucci47/keytheorems/compare/v0.1.2...v0.1.3
[v0.1.2]: https://github.com/mbertucci47/keytheorems/compare/v0.1.1...v0.1.2
[v0.1.1]: https://github.com/mbertucci47/keytheorems/compare/v0.1.0...v0.1.1