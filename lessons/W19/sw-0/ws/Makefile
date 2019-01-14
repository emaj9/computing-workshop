all: writeup.pdf types-values.pdf functions.pdf
writeup.pdf: writeup.tex
	lualatex $<

types-values.pdf: types-values.tex snippet1.py snippet2.py snippet3.py snippet4.py
	lualatex $<

functions.pdf: functions.tex

	lualatex $<
