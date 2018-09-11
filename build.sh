#!/bin/bash
  
## Dockerfile for Haskell environment

# Exit on any non-zero status.
trap 'exit' ERR
set -E

# install

# See /etc/debian_version for Ubuntu version on top of Debian version
# See http://downloads.haskell.org/debian/
echo 'deb http://downloads.haskell.org/debian stretch main' > /etc/apt/sources.list.d/haskell.list
apt-key adv --keyserver keyserver.ubuntu.com  --recv-keys BA3CBA3FFE22B574
export DEBIAN_FRONTEND=noninteractive
apt-get -qy update
apt-get -qy --no-install-suggests --no-install-recommends install \
    cabal-install-$CABAL_VERSION \
    ghc-$GHC_VERSION
cd /usr/local/bin
ln -s /etc/alternatives/opt-cabal cabal
ln -s /etc/alternatives/opt-ghc ghc
ln -s /etc/alternatives/opt-ghc-pkg ghc-pkg
ln -s /etc/alternatives/opt-ghci ghci
ln -s /etc/alternatives/opt-haddock haddock
ln -s /etc/alternatives/opt-runghc runghc
cabal update
# install pandoc globally to prevent : error: exec: "/root/.cabal/bin/pandoc": stat /root/.cabal/bin/pandoc: permission denied
# with cabal 2 --global is deprecated, so set user-install: False in /root/.cabal/config
sed -i -e 's!^-- \(user-install: \)True!\1False!' /root/.cabal/config
mkdir /root/.cabal/bin
cabal install \
    alex-${ALEX_VERSION} \
    happy-${HAPPY_VERSION}

# uninstall and clean
cd /root/.cabal
find ./logs/ -name "*.log" -exec rm {} \;
rm -fr packages/*
apt-get clean -y
rm -rf /var/lib/apt/lists/*
rm -rf /usr/share/doc/*
rm -rf /usr/share/doc-gen/*
rm -fr /usr/share/man/*

exit 0

