PROJECT_NAME    = UntitledGame
SOURCES         = main.lua conf.lua

.PHONY: all run love package

all:

run:
	love .

# because executing "make love" is awesome
love: run

package:
	zip -9 -r ${PROJECT_NAME}.love ${SOURCES}
