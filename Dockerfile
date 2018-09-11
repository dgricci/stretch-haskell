## Dockerfile for a haskell environment
## Cf. https://github.com/freebroccolo/docker-haskell/blob/master/8.2/Dockerfile
FROM       dgricci/stretch:1.0.0
MAINTAINER Didier Richard <didier.richard@ign.fr>
LABEL       version="1.0.0" \
            cabal="v2.2" \
            ghc="v8.4.2" \
            alex="v3.1.7" \
            happy="v1.19.5" \
            os="Debian Stretch" \
            description="Haskell environment"

## different versions - use argument when defined otherwise use defaults
ARG CABAL_VERSION
ENV CABAL_VERSION   ${CABAL_VERSION:-2.2}
ARG GHC_VERSION
ENV GHC_VERSION     ${GHC_VERSION:-8.4.2}
ARG ALEX_VERSION
ENV ALEX_VERSION    ${ALEX_VERSION:-3.1.7}
ARG HAPPY_VERSION
ENV HAPPY_VERSION   ${HAPPY_VERSION:-1.19.5}

COPY build.sh /tmp/build.sh
RUN /tmp/build.sh && rm -f /tmp/build.sh

## run software with flag version by default unless a command is specified
## See https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/flags.html#flag-reference
CMD ghci --version && alex -v && happy -v

