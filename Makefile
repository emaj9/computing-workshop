.PHONY: all

all:
	make -C lessons
	cd cspogil; ./build.py all
