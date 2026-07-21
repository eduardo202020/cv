PDF := output/pdf/eduardo-guevara-cv.pdf
GENERATED := \
	output/pdf/eduardo-guevara-cv.aux \
	output/pdf/eduardo-guevara-cv.log \
	output/pdf/eduardo-guevara-cv.out \
	output/pdf/eduardo-guevara-cv.xdv \
	output/pdf/eduardo-guevara-cv.synctex.gz

.PHONY: all build verify clean

all: build

build:
	sh scripts/build.sh

verify: build
	test -s $(PDF)
	@echo "PDF verificado: $(PDF)"

clean:
	rm -f $(GENERATED) $(PDF)
