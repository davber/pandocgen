# pandocgen

This is a generation framework for yielding PDF and HTML from good old Markdown files. It
uses the eminent [Pandoc tool](http://johnmacfarlane.net/pandoc/), so the Markdown files
can use Pandoc extensions to provide a slicker
output, including mathematical expressions.

**NOTE**: for some reason, the creator of Pandoc, John MacFarlane, has not named the
Pandoc Markdown extension language. I sometimes refer to it as **PandocMarkdown**.

**NOTE**: Pandoc is capable of translating between a host of formats, but this
**pandocgen** project focuses on (Pandoc-)Markdown input.

## Very, Very Quick Intro...

1. Add this project as a submodule
   `git submodule add git@github.com:davber/pandocgen.git`
1. Create some beautiful Markdown file, `MyCoolDoc.md`
1. Create a Makefile like this:
>  BASE=MyCoolDoc
>  include pandocgen/Makefile
1. Make space for the generated files:
>  mkdir gen
1. Create the PDF and HTML files:
>  make all

That is it! Now you have a PDF and HTML version of your Markdown document.

There are some dependencies, though.

## Dependencies

You need to have these items installed:

1. A Gnu `make` command, preferably version 3.80 or later. On most decent machines,
   this is already installed.
1. LaTex, such as [TeX Live](http://www.tug.org/texlive/).
1. [Pandoc](http://johnmacfarlane.net/pandoc/) --- the tool actually doing the generation

## Using It...

To use this framework, there are two paths:

1. Include the provided `Makefile` in your own Makefile, after a section where you
   specify a few custom parameters, as defined in the Custom Parameters section.
2. Set the custom parameters as environment variables and use the provided `Makefile`
   as is.   
   
## Building Targets

All target versions of the Markdown document are generated in a `gen` directory
relative the current working directory. As a convenience, this project contains such
a directory in case you are running `make` from there.

Each of the target formats has a corresponding make target, so you can issue one of:

>	make pdf
>	make html
>	make tex

There is also a universal target, which builds all formats:

>	make all

## Customer Parameters

These are the parameters you can set -- either via a initial section in an embedding
Makefile or as environment variables:

* `BASE` - that is the name of the Markdown document, **without** suffix, such as
  `MyCoolDoc`, which will then generate `MyCoolDoc.pdf`, `MyCoolDoc.html` and
  `MyCoolDoc.tex` in the `gen` directory. **MANDATORY**
* `RES_IN` - the input files for resources, such as images, needed by the document.
   This often includes `dot` files or other input formats for `pdf`- and `png`-based
   images. **OPTIONAL**
* `RES_OUT` - the corresponding generated resource files, which are often `pdf` and
   `png` files. **OPTIONAL** and will **DEFAULT** to `RES_IN` if not provided!
* `RES_GEN` - the full command to generate the `RES_OUT` files from the `RES_IN` files.
   **OPTIONAL**
   
**NOTE**: so there is only **one** mandatory parameter to set, and that is `BASE`.

**NOTE**: the default behavior, described above, actually allows you to include
resources in an input-ready format, such as raw `png` and `pdf` files, by merely
setting the `RES_IN` to those files and let the other two resource-related parameters
be. That will translate into a no-op for that make step.

## Helper Files

The helper files reside in the `input` directory.

The helper files are:

* `my-template.latex` - this is the main template for LaTeX generation and, indirectly,
  for PDF generation. It uses some parameters that can be set from command line ---
  and is actually set by the provided `Makefile` --- such as `docuemntclass`, which
  the `Makefile` sets to `memoir`. See the `Makefile` for some of those parameters used.
* `mytitle.tex` - this is the template for the title page, for LaTeX (and PDF...)
* `mychapter.tex` - specifies the look of chapter headings for LaTeX (and PDF...)
* `macros.tex` - some TeX macros. **NOTE** these macros are actually expanded by Pandoc
  itself in the case of non-TeX-based generation --- such as HTML --- so one can have
  shortcuts or other macros even for HTML.
