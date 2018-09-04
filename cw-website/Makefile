$(shell mkdir -p dst-fonts)

.PHONY: dst-fonts
dst-fonts: src-fonts
	-rm dst-fonts/*
	cp src-fonts/* dst-fonts/
	find dst-fonts -type f | while read f ; do echo "converting $$f to WOFF"; sfnt2woff "$$f" ; done
