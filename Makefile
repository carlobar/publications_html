DOC := publications
REFS := references.bib
REFS_DOC := refs
REFS_DOC_NO_LINKS := refs_nl

all: $(REFS_DOC).html 
	sed -i 's!C\..*Barreto!<b><u>C\. Barreto</u></b>!g' $(REFS_DOC).html

$(REFS_DOC).bib: $(REFS)
	bib2bib -ob $(REFS_DOC).bib $(REFS) --remove 'url' --remove 'pdf' --remove 'slides'

$(REFS_DOC_NO_LINKS).bib: $(REFS_DOC).bib
	bib2bib -ob $(REFS_DOC_NO_LINKS).bib $(REFS_DOC).bib --remove 'pdf' --remove 'slides' --remove 'abstract' --remove 'keywords' 

$(REFS_DOC).html: $(REFS_DOC_NO_LINKS).bib $(REFS_DOC).bib 
	bibtex2html -s IEEEtran --no-keywords -nodoc $(REFS_DOC_NO_LINKS).bib
	mv $(REFS_DOC_NO_LINKS)_bib.html $(REFS_DOC)_bib.html.tmp
	bibtex2html -s IEEEtran --both --no-keywords -nodoc $(REFS_DOC).bib
	rm $(REFS_DOC)_bib.html
	mv  $(REFS_DOC)_bib.html.tmp $(REFS_DOC)_bib.html
	rm $(REFS_DOC_NO_LINKS).bib
	rm $(REFS_DOC_NO_LINKS).html


clean:
	rm -f $(DOC).aux refs.bib refs_only_abstract.bib *.html *.log *.bbl *.dvi *.blg *.pdf *.synctex.gz $(REFS_DOC_NO_LINKS).bib $(REFS_DOC).bib $(TAR_FILE)



