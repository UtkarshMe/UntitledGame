PROJECT_NAME    = UntitledGame
SOURCES         = main.lua \
                  src/conf.lua \
                  src/game.lua \
                  src/util.lua \
                  src/log.lua \
                  src/parser.lua \
                  src/timer.lua \
                  src/assets.lua \
                  src/models/* \
                  src/views/* \
                  src/controllers/* \
                  lib/* \
                  data/* \
                  assets/*
LOVE_WIN_SOURCE = love-11.1.0-win32

.PHONY: all run love lint package test packagewin

all:

run:
	love .

# because executing "make love" is awesome
love: run

lint:
	luacheck .

test: unittest functionaltest

unittest:
	busted --run unittest --output gtest

functionaltest:
	#busted --run functionaltest --output gtest

package:
	zip -9 -r ${PROJECT_NAME}.love ${SOURCES}

packagewin: ${LOVE_WIN_SOURCE} package
	cd ${LOVE_WIN_SOURCE} \
		&& cat ./love.exe ../${PROJECT_NAME}.love > ${PROJECT_NAME}.exe \
		&& rm -rf changes.txt lovec.exe love.ico readme.txt love.exe
	mv ${LOVE_WIN_SOURCE} ${PROJECT_NAME}_win
	zip -r ${PROJECT_NAME}_win ${PROJECT_NAME}_win
	rm -rf ${PROJECT_NAME}_win


${LOVE_WIN_SOURCE}: love-11.1-win32.zip
	unzip love-11.1-win32.zip

love-11.1-win32.zip:
	wget https://bitbucket.org/rude/love/downloads/love-11.1-win32.zip
