--[=========================[--
   l3build file for keytheorems
--]=========================]--

module = "keytheorems"
version = "2026-10-02 v0.4.3dev"

checkengines = {"pdftex"}
checkruns = 2
recordstatus = true
installfiles = {"keytheorems.sty"}

---- We handle typesetting the doc independently
-- maxprintline = 10000
-- typesetruns = 4
-- typesetexe = "lualatex"

-- All I want 'l3build ctan' to do is move the doc and tex folders into a zip file
packtdszip = false
docfiles = {"doc"}
sourcefiles = {"tex"}
textfiles ={"CHANGELOG.md","README.md"}
excludefiles = {"*.aux","*.hd","*.idx","*.ilg","*.ind","*.listing","*.log",
                "*.synctex.gz","*.tcbtemp","*.thlist","*.toc","*.minted"}

-- Upload meta data

-- announce = {}
-- announce["2026-10-09 v1.0c"] = [[
-- Tag documentation; update maintainer to the LaTeX Project
-- ]]

uploadconfig = {
 pkg = "keytheorems",
 version = version,
 author = "Matthew Bertucci",
 license = "lppl1.3c",
 summary = [[An l3keys interface to amsthm]],
 ctanPath = "/macros/latex/contrib"..module,
 repository = "https://github.com/mbertucci47/keytheorems",
 bugtracker = "https://github.com/mbertucci47/keytheorems/issues",
 uploader = "Matthew Bertucci",
 email = "saints4774@gmail.com",
 update = true ,
 -- announcement = announce[version],
 description  = [[
  A key-value interface to [amsthm](https://www.ctan.org/pkg/amsthm) using the [L3](https://www.ctan.org/pkg/l3kernel) programming layer, implementing most of the functionality provided by [thmtools](https://www.ctan.org/pkg/thmtools).
  Several issues encountered with thmtools are avoided (see the README for a list) and several new features are added.
 ]]
}