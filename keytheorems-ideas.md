# Ideas/Issues:
- [ ] Only print "up-to-now" theorems, or by section.
      This is complicated. See etoc. And acro (`\acbarrier`).
- [x] (just use `\theoremstyle`) Use style key for multiple theorems, like
      ```tex
      \keytheoremset{style={<keys>}}
      \newkeytheorem{thm1}
      \newkeytheorem{thm2}
      ```
      Well maybe not. Because should these style keys also be applied to a called
      `\newkeytheoremstyle`? Or only used for that? Question is: should user be able to style theorems
      without an explicit call to `\newkeytheorem{<thm>}[style=<style>]`?
- [ ] link theorem to restated (see TeX.sx)
- [ ] Fix equation, etc. numbering in restated theorems when numbered by
      chapter, section, etc. Or leave it up to user to add these counters
      with restate-counters?
- [x] listhack
- [ ] Proof hooks? Other proof customization? New proof-like envs? feature creep...
- [x] `\newtheoremstyle` overwrites existing styles. Should `\newkeytheoremstyle` check
      if style exists? Relevant for plain, remark, definition. Could provide
      `\renewkeytheoremstyle`. Further, if there is use for (re)defining theorems
      mid-document, could make cmds usable after preamble by removing package loading
      in keys
      Slightly more complicated than anticipated, need to deal with hooks
- [ ] Currently `numbered=unless-unique` + `parent` is incompatible with restate, but this is
      true also with thmtools.
- [x] Idea for qed, tcolorbox in style: in thm, just check if already set and adjust accordingly
- [x] What about `\zlabel` and other "label" commands in restated theorem? Should
      there be an interface for disabling them?
- [ ] `unless-unique` more general: https://tex.stackexchange.com/a/705572/208544
- [x] Rename "preheadhook" etc. to "prehead"? Answer: no, prehead sounds like a skip amount
- [ ] `\listofkeytheorems` does not print restated theorems. Should an option be added
      to do this? No, right?
- [x] Language support? At least for list of theorems title
- [x] Interface for adding entries to list of theorems. In fact, should
      benchmark the "add to seq then write at end of file" approach vs.
      traditional `\addcontentsline` approach
- [ ] (partial) `short name` key for theorems to replace thmtools'
      `name={[short name]name}`. Should we also support this syntax?
      Progress: key implemented but not yet compat with continues
- [x] (see restate-keys) And what about `restate={[options]foo}` syntax? How useful is this?
- [x] Should `continues(*)` theorems appear in list of theorems? Decide and add option to
      change default.
- [x] Add `shaded` and `thmbox` keys that use tcolorbox under the hood.
      In thmtools-compat or available always? Or as "library"?
      Currently thmbox has white background, want transparent but has issue:
      https://tex.stackexchange.com/a/706216/208544
- [x] Should more hook operations be available in user commands, like labels and removing?
    Answer: no, I don't think so. `\addtotheoremhook` is for simple things.
    Programmers can use the usual hook interface with more verbose labels
- [x] Document how to disable things like footnotes in restated theorems.
- [x] Should indent be suppressed after tcolorbox theorems? It is for thmtools' shaded and thmbox theorems.
      Just setting `\tcbset{after=\par\@endpetrue}` doesn't work since there is code in between but
      `\AddToHook{keytheorems/<env>/postfoot}[keythms_hook_keys]{\par\@endpetrue}` seems to work
      Answer: I say no, since it's not suppressed after regular theorems.
- [ ] (partial) `break` + `tcolorbox-no-titlebar` adds too much space if theorem starts with list
      listhack fixes this.
- [x] rename package to "keytheorems"?
- [x] should all code added to hooks have the "keytheorems" label as opposed to "."?
- [x] seq approach doesn't work well with `\includeonly`
- [x] chaptervspacehack
- [ ] Should there be a way to add content lines to `\listofkeytheorems` with print-body?
      Currently we disable code added with `\addtotheoremcontents`
- [x] hyperref does not jump to correct location for tcolorbox theorems
- [ ] use `\MakeLinkTarget` instead of dummy counter?
- [x] should default theorem style be changed if ams class is loaded? Yes,
      and need general mechanism for setting up class defaults
- [x] need to clear .thlist file if no restate or list of
- [x] Beamer issues:
    - [x] tcolorbox theorems not compatible with beamer
    - [x] cannot give action spec to theorems
- [ ] Idea: delay making hooks until begindocument to avoid using internal cmd
- [x] fix acmart defaults
- [x] use different dummy counters for unnumbered, continues, and restate
- [x] seq for custom lists of theorems
- [x] make code more modular
- [x] option to restate without writing to file (let's wait to see if this is an issue)
- [x] code with brackets fail in note key, e.g. `\cite[bla]{ref}`
- [x] with tcolorbox theorems, spaceabove and spacebelow should always be set to 0pt
- [x] no-auto-translate or something like that
- [x] tcolorbox theorem spacing after sections is not good when titlesec loaded
- [x] also different behavior for tcb theorems and not, namely spaceabove adds space
      after section for former but not latter
- [x] (see `format-code`) full control over list-of appearance, including name and number
- [x] option to add list of theorems to TOC. No, let user control manually.
- [x] list appearance does not match list of figures in memoir
- [x] make indent configurable in general
- [x] With amsart etc. `no-title` vert spacing is bad; currently uses empty title
- [ ] chaptervspacehack adds extra vert space above no-title (maybe this is okay)
- [x] With memoir, list of theorems always on new page (list of figures is not)
      Should I just use memoir's list commands when it's loaded?
- [x] Idea: just define everything for the default classes, then have support files
            for the other classes that redefine things
- [ ] Remove dependency on unique.sty
- [ ] Line numbers for errors/warnings
- [x] store-sets-label
- [x] allow passing options to restated env
- [x] number font
- [ ] allow to suppress content of env, then restate later (or earlier)
- [x] `\begin{theorem}[store=foo][text that should be in body]` picks up latter bracketed material as note
- [x] `\theoremstyle` does not apply thm keys
- [ ] nested inherit-style errors
- [x] use tcb style with #1 for tcolorbox theorems so style can be added to or overridden
- [x] can't define `\renewkeytheorem`, etc., until figure out preheadhook situation.
      Right now we don't add if empty, but then \hook_remove gives warnings
- [x] `\KeyThmsContentsLine`, etc. should be default be no-ops, redefined to do things, not reverse as now
- [ ] amsbook and `no-title`...
- [ ] hook order with `\addtotheoremhook` and qed is wrong
- [ ] `\getkeytheorem[body]{foo}` needs to use theorem-specific restated hook
      This means getthm_body needs to take three arguments...
- [x] `qed={}` in style does not do the right thing
- [ ] lots of code duplication, for example in beamer support file
- [ ] space after title with beamer, tcolorbox theorems, and label
- [x] move `prehead_code` out of `withhooks_begin` so the preheadhook can change note.
      Then wouldn't need separate `prehead_continues_code`, I think.
      See this for application: https://tex.stackexchange.com/a/728812/208544
- [x] logic with `restate-keys` and `store*` is reversed. Nevermind, it has to
      work this way. Otherwise all keys for actually written theorem would have
      to be passes to `restate-keys`.
- [x] Don't patch `\@thm` for `leftmargin` and `rightmargin`. Just redefine `\trivlist`
      in the prehead hook and restore original definition in posthead.
- [ ] Make margin theorems work with tagging code
- [ ] Manual label after `tcolorbox-no-titlebar` theorem produces extra space