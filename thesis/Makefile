TEXFILES=thesis.tex
PDF=thesis.pdf
PDFLATEX=pdflatex
PDFVIEW=acroread

MAINTEX=$(PDF:%.pdf=%.tex)

all: $(PDF)

$(PDF): $(TEXFILES)
	$(PDFLATEX) $(MAINTEX)
	$(PDFLATEX) $(MAINTEX)
	$(PDFLATEX) $(MAINTEX)

view: $(PDF)
	$(PDFVIEW) $(PDF)

clean:
	@rm -rf $(TEXFILES:%.tex=%.aux) thesis.dvi thesis.log thesis.pdf thesis.lof thesis.toc thesis.lot thesis.out
