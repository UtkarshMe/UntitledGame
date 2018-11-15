## Writing tests
The tests have been divided into two unit and functional tests:

- **Unit tests** test one component and one component only.
- **Functional tests** test how components sit together and implement a
"function".

We are using [busted](https://olivinelabs.com/busted/) as the test suite. See
[their docs](https://olivinelabs.com/busted/#defining-tests) for help on writing
tests.


## Running tests
Tests can be run by `make test` to run both unit and functional tests, or by
`make unittest` and `make functionaltest` to run them separately.

Lint checks can be done using `make lint`. We are using
[luacheck](https://github.com/mpeterv/luacheck/) as our lint checker.
