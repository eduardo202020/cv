PDF := output/pdf/eduardo-guevara-cv.pdf
ATS_PDF := output/pdf/eduardo-guevara-cv-ats.pdf
GENERATED := \
	output/pdf/eduardo-guevara-cv.aux \
	output/pdf/eduardo-guevara-cv.log \
	output/pdf/eduardo-guevara-cv.out \
	output/pdf/eduardo-guevara-cv.xdv \
	output/pdf/eduardo-guevara-cv.synctex.gz \
	output/pdf/eduardo-guevara-cv-ats.aux \
	output/pdf/eduardo-guevara-cv-ats.log \
	output/pdf/eduardo-guevara-cv-ats.out \
	output/pdf/eduardo-guevara-cv-ats.xdv \
	output/pdf/eduardo-guevara-cv-ats.synctex.gz

.PHONY: all build verify clean

all: build

build:
	sh scripts/build.sh

verify: build
	test -s $(PDF)
	test -s $(ATS_PDF)
	@echo "PDFs verificados: $(PDF), $(ATS_PDF)"

clean:
	rm -f $(GENERATED) $(PDF) $(ATS_PDF)
