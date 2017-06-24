# Haskell & IDE Setup

## Install Stack

On Ubuntu:  
`sudo apt install haskell-stack`

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
