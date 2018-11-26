PROJECT_NAME    = UntitledGame
SOURCES         = main.lua \
                  conf.lua \
                  game.lua \
                  util.lua \
                  log.lua \
                  parser.lua \
                  timer.lua \
                  models/* \
                  views/* \
                  controllers/* \
                  lib/* \
                  data/*

.PHONY: all run love lint package test

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
