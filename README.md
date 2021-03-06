# pandocgen

**NOTE**: in order to see the images on this page and to have links working, be sure to
add a trailing `/` to the URL in the browser! Yep, a GitHub/Gollum bug.

This is a generation framework for yielding PDF and HTML from good old Markdown files. It
uses the eminent [Pandoc tool](http://johnmacfarlane.net/pandoc/), so the Markdown files
can use Pandoc extensions to provide a slicker
output, including mathematical expressions. For the pure Markdown syntax and its
semantics, there is a good introduction on
[Daring Fireball](http://daringfireball.net/projects/markdown/syntax/).

**NOTE**: for some reason, the creator of Pandoc, John MacFarlane, has not named the
Pandoc Markdown extension language. I sometimes refer to it as **PandocMarkdown**.

**NOTE**: Pandoc is capable of translating between a host of formats, but this
**pandocgen** project focuses on (Pandoc-)Markdown input. See the graph at the bottom
of this document for all the various conversion options of Pandoc; it is quite
mind-blowing. The image is from the Pandoc site and is copyrighted by John MacFarlane.

There are some current issues relative links to resources. See the Issues section below.

## Very, Very Quick Intro...

1. Add this project as a submodule

		git submodule add git@github.com:davber/pandocgen.git
1. Create some beautiful Markdown file, `MyCoolDoc.md`
1. Create a Makefile like this:

		BASE=MyCoolDoc
		include pandocgen/Makefile
1. Make space for the generated files:

		mkdir gen
1. Create the PDF and HTML files:

		make all

That is it! Now you have a PDF and HTML version of your Markdown document.

For a quick generation, you can actually generate this README file --- people always
enjoy others eating their own dog food (or actually others eating pet food in general...)
--- by

	make --file sample.mk

where `sample.mk` is this short make file

	BASE=README
	RES_OUT=diagram.png
	include Makefile
	
This will generate output files in the `gen` directory. They are also uploaded to this
Wiki, as a [PDF file](./gen/README.pdf) and [HTML file](./gen/README.html).

## Dependencies

There are some dependencies, though:

1. A Gnu **make** command, preferably version 3.80 or later. On most decent machines,
   this is already installed.
1. LaTex, such as [TeX Live](http://www.tug.org/texlive/).
1. [Pandoc](http://johnmacfarlane.net/pandoc/) --- the tool actually performing the
   generation

## Using It...

To use this framework, there are two paths:

1. Include the provided Makefile in your own Makefile, after a section where you
   specify a few custom parameters, as defined in the Custom Parameters section.
2. Set the custom parameters as environment variables and use the provided Makefile
   as is.
   
## Building Targets

All target versions of the Markdown document are generated in a `gen` directory
relative the current working directory. As a convenience, this project contains such
a directory in case you are running `make` from there.

Each of the target formats has a corresponding make target, so you can issue one of:

	make pdf
	make html
	make tex

There is also a universal target, which builds all formats:

	make all

## Customer Parameters

These are the parameters you can set -- either via a initial section in an embedding
Makefile or as environment variables:

* `BASE` - that is the name of the Markdown document, **without** suffix, such as
  `MyCoolDoc`, which will then generate `MyCoolDoc.pdf`, `MyCoolDoc.html` and
  `MyCoolDoc.tex` in the `gen` directory. **MANDATORY**
* `RES_IN` - the input files for resources, such as images, needed by the document.
   This often includes Graphviz Dot files or other input formats for PDF- and PNG-based
   images. **OPTIONAL**
* `RES_OUT` - the corresponding generated resource files, which are often PDF and
   PNG files. **OPTIONAL**.
* `RES_GEN` - the full command to generate the `RES_OUT` files from the `RES_IN` files.
   **OPTIONAL**
   
**NOTE**: so there is only **one** mandatory parameter to set, and that is `BASE`.

**NOTE**: the default behavior, described above, actually allows you to include
resources in an input-ready format, such as raw PNG and PDF files, by merely
setting the `RES_OUT` to those files and let the other two resource-related parameters
be. That will translate into a no-op for that make step.

## Helper Files

The helper files reside in the `input` directory.

The helper files are:

* `my-template.latex` - this is the main template for LaTeX generation and, indirectly,
  for PDF generation. It uses some parameters that can be set from command line ---
  and is actually set by the provided Makefile --- such as `docuemntclass`, which
  the Makefile sets to `memoir`. See the Makefile for some of those parameters used.
* `mytitle.tex` - this is the template for the title page, for LaTeX (and PDF...)
* `mychapter.tex` - specifies the look of chapter headings for LaTeX (and PDF...)
* `macros.tex` - some TeX macros. **NOTE** these macros are actually expanded by Pandoc
  itself in the case of non-TeX-based generation --- such as HTML --- so one can have
  shortcuts or other macros even for HTML.

## Issues

Be aware of the intricacies of opening HTML files from the `gen` directory vs
opening them from the top directory. For instance, the links and images are relative
the top directory of this project, so in order for relative links to work, you must
copy the `gen/README.html` to the top directory.

There is also a bug in GitHub/Gollum related to how relative paths are interpreted
in links and embeddings of images. It **sometimes** changes behavior to put the relative
path as relative to the user's base URL, instead of the project. They would probably argue
that it is due to the page being rendered as the home page, which has no relative path,
so the relative path then become relative the next step above that, blah, blah.
The bottom line is: one cannot include relative references using the normal Markdown
syntax in Markdown pages that GitHub/Gollum happen to map from the top of the project.

A "solution" is to add a trailing slash when looking at this "home" page, for instance.
That will at least bring us to the next GitHub/Gollum problem: that of a **valid**
link not fetching a resource... So... one has to use a GitHub-specific form of including
an image (**and** be sure to use a trailing slash in the browser):

	[[rez/diagram.png]]
	
So, we have to use two link formats in this document, so do not be alarmed if you
see some garbage output next to an image.

**UPDATE**: the images do not work at all on GitHub, no matter what is attempted.

## The Completely Connected World Of Pandoc

Can you count the number of translations possible? ...

[[rez/diagram.png]]

![Pandoc Format Conversions](rez/diagram.png)

Again: Image copyright John MacFarlane