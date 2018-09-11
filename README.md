% Environnement Haskell  
% Didier Richard  
% 2018/08/31

---

revision:
    - 1.0.0 : 2018/08/31  

---

# Building #

```bash
$ docker build -t dgricci/haskell:$(< VERSION) .
$ docker tag dgricci/haskell:$(< VERSION) dgricci/haskell:latest
```

## Behind a proxy (e.g. 10.0.4.2:3128) ##

```bash
$ docker build \
    --build-arg http_proxy=http://10.0.4.2:3128/ \
    --build-arg https_proxy=http://10.0.4.2:3128/ \
    -t dgricci/haskell:$(< VERSION) .
$ docker tag dgricci/haskell:$(< VERSION) dgricci/haskell:latest
```

## Build command with arguments default values ##

```bash
$ docker build \
    --build-arg CABAL_VERSION=2.2 \
    --build-arg GHC_VERSION=8.4.2 \
    --build-arg ALEX_VERSION=3.1.7 \
    --build-arg HAPPY_VERSION=1.19.5 \
    -t dgricci/haskell:$(< VERSION) .
$ docker tag dgricci/haskell:$(< VERSION) dgricci/haskell:latest
```

# Use #

See `dgricci/stretch` README for handling permissions with dockers volumes.

```bash
$ docker run -i --rm -e USER_ID=$UID -e USER_NAME=$USER dgricci/haskell:$(< VERSION)
The Glorious Glasgow Haskell Compilation System, version 8.4.2
Alex version 3.1.7, (c) 2003 Chris Dornan and Simon Marlow
Happy Version 1.19.5 Copyright (c) 1993-1996 Andy Gill, Simon Marlow (c) 1997-2005 Simon Marlow

Happy is a Yacc for Haskell, and comes with ABSOLUTELY NO WARRANTY.
This program is free software; you can redistribute it and/or modify
it under the terms given in the file 'LICENSE' distributed with
the Happy sources.
```

__Et voilà !__


_fin du document[^pandoc_gen]_

[^pandoc_gen]: document généré via $ `pandoc -V fontsize=10pt -V geometry:"top=2cm, bottom=2cm, left=1cm, right=1cm" -s -N --toc -o haskell.pdf README.md`{.bash}
