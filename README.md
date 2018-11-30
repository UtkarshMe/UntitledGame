## Untitled game in Lua with Love `#GitHubGameOff`
[![Build Status](https://travis-ci.org/UtkarshMe/UntitledGame.svg?branch=master)](https://travis-ci.org/UtkarshMe/UntitledGame)
[![codecov](https://codecov.io/gh/UtkarshMe/UntitledGame/branch/master/graph/badge.svg)](https://codecov.io/gh/UtkarshMe/UntitledGame)

### Shots!
![start screen](screenshots/start.png "Game Start Screen")
![game screen](screenshots/game.png "Game Play Screen")

### Download
The game is available to download for Windows or as source code from the
[releases](https://github.com/UtkarshMe/UntitledGame/releases/latest) page.

### Dependencies
- [Love2d](https://love2d.org/): as game engine
- utf8: for user input (`luarocks install utf8`)

##### Dev dependencies
- luacheck: for lint checking
- busted: as test suite
- codecov: for code coverage analysis


### Documentation
- code style guide: [`docs/style_guide.md`](https://github.com/UtkarshMe/UntitledGame/tree/master/docs/style_guide.md)
- testing: [`docs/testing.md`](https://github.com/UtkarshMe/UntitledGame/tree/master/docs/testing.md)


### Build
```bash
make          # does nothing at the moment
make run      # run the game

make test     # run tests (unit + functional)
make unittest
make functionaltest

make lint     # run code lint

make package  # export the game
```


### License
MIT
