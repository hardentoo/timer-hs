# timer-hs - a Haskell learning project

Small personal project to document Haskell & Stack usage.


# Haskell & IDE Setup

## Install Stack

On Ubuntu:  
`sudo apt install haskell-stack`

On openSUSE:  
`sudo zypper install stack`


## Setup project and dependencies

First `cd` into the project directory, than run:

    stack setup
    stack build
    stack install intero
    stack install QuickCheck

## IDE - Visual Studio Code

Install [VSCode](https://code.visualstudio.com/)
and the vscode `Haskero` extension. Done.


# Using GHCI, run tests and build a binary

To open the Haskell-REPL:  
`stack ghci`

To run tests:  
`stack test`

To build the binary:  
`stack install --local-bin-path [dir]`


# Hoogle - How to find the right function

[Hoogle](https://www.haskell.org/hoogle/) is a Haskell API search engine,
which makes developing Haskell much more enjoyable. Beside searching for
a function name, it is possible to search for a function signature, e.g.:

`[Maybe a] -> Maybe [a]`

Returns among other things: `sequence :: Monad m => [m a] -> m [a]`


# GHCI usage

| Command                   | Function                             |
--------------------------- | --------------------------------------
| `:r`                      | reload                               |
| `:i something`            | print info about something           |
| `:m +Control.Applicative` | load the Control.Applicative library |
| `:t variable`             | show type of variable                |