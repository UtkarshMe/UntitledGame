PROJECT_NAME    = UntitledGame
SOURCES         = main.lua conf.lua

.PHONY: all run love lint package

all:

run:
	love .

# because executing "make love" is awesome
love: run

lint:
	luacheck .

package:
	zip -9 -r ${PROJECT_NAME}.love ${SOURCES}
