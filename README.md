Installation
------------

- Install MongoDB. On Mac: `brew install mongo`
- Create database directory: `mkdir db`
- Build and install: `cabal install`
- Now you have an executable `beercounter`

Running
-------

Start the mongoDB server:

    start-mongo.sh

Start beercounter:

    beercounter

Running in GHCI
---------------

Start GHCI with `beercounter` source directories:

    ./repl

Load `Server.hs` and start it:

    :l Server
    main

Server is now running. Use `Ctrl-C` to stop it and `:q` to exit GHCI.

Building the executable
-----------------------

Build with cabal:

    cabal install


Testing
-------

Buy a round:

    curl -d '{"buyer":"juha", "others":["juho", "atte"]}' localhost:8000/buyRound

Check karma:

    curl localhost:8000/karma/juho/atte



