#
# This Makefile generates target formats of the (Pandoc-)MD-based
# document. It uses the tool 'pandoc' which then has to be installed.
# To generate PDF, you also need a PDF-compatible LaTex installation.
#
# In order for the make targets to work, you must set at least one
# parameter, 'BASE',
# and can also set three other parameters, 'RES_IN', 'RES_OUT' and
# 'RES_GEN', with the following meanings:
#
# BASE - the base name of the Markdown document, without suffix.
# RES_IN - the original resource files, such as Graphviz files.
# RES_OUT - the read-to-embed resources, such as PDF and PNG files,
#           created from the 'RES_IN' files.
# RES_GEN - the command generated the 'RES_OUT' files form the
# 'RES_IN' files.
#
#
#
# To make all the output formats, issue
#	make all
#
# You can also generate the various output formats individually, using
#	make pdf
# or
#	make html
#
# There is also a LaTeX target, for those that want to fiddle around
# with some TeX magic on their own:
#	make tex
#

#
# Variables to the process, please set in embedding Makefile or
# via environment variables!
#

# BASE=MyCoolDoc
# RES_IN=input/cool_image.dot
# RES_OUT=rez/cool_image.pdf
# RES_GEN=dot -o $(RES_OUT) $(RES_IN)

#
# We make sure that the auxiliary input we need is relative
# this Makefile, which is done in this roundabout way:
ROOT_REL=$(dir $(lastword $(MAKEFILE_LIST)))

AUX_IN=$(ROOT_REL)input
TEMPLATES=$(AUX_IN)/mychapter.tex $(AUX_IN)/mytitle.tex $(AUX_IN)/my-template.latex $(AUX_IN)/macros.tex
PDF=gen/$(BASE).pdf
TEX=gen/$(BASE).tex
HTML=gen/$(BASE).html
DOC=$(BASE).md
INPUT=$(DOC) $(RES_OUT) $(TEMPLATES)
COM_OPTS=-V documentclass=memoir -V classopt=oneside -H $(AUX_IN)/mychapter.tex -H $(AUX_IN)/mytitle.tex --smart -N -H $(AUX_IN)/macros.tex
TEX_OPTS=$(COM_OPTS) --template=$(AUX_IN)/my-template
HTML_OPTS=$(COM_OPTS)

all: pdf tex html

pdf: $(PDF)
tex: $(TEX)
html: $(HTML)


$(PDF): $(INPUT)
	pandoc $(TEX_OPTS) -o $(PDF) $(DOC)

$(HTML): $(INPUT)
	pandoc $(HTML_OPTS) -o $(HTML) $(DOC)

$(TEX): $(INPUT)
	pandoc $(TEX_OPTS) -o $(TEX) $(DOC)

$(RES_OUT): $(RES_IN)
	$(RES_GEN)
