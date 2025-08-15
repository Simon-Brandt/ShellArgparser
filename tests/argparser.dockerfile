# Author: Simon Brandt
# E-Mail: simon.brandt@uni-greifswald.de
# Last Modification: 2025-08-15
# License: Public Domain

FROM ubuntu:24.04

# Install the dependencies.
SHELL [ "/bin/bash", "-c" ]
RUN apt-get update \
    && apt-get install --yes \
        autoconf \
        gcc \
        git \
        locales \
        make \
    && rm --force --recursive /var/lib/apt/lists/*

# Set the Bash version, which can be overridden by the "--build-arg"
# option to "docker build".
ARG VERSION=5.3

# Download and install Bash in the given version.
WORKDIR /opt
RUN git clone \
    --branch=bash-${VERSION} \
    --depth=1 \
    git://git.git.savannah.gnu.org/bash.git

WORKDIR /opt/bash
RUN ./configure \
    && make \
    && make tests \
    && make install

# Copy the Argparser, all test scripts, and their dependencies (the
# resources) into the image.
WORKDIR /opt/argparser
COPY --from=parent argparser .
COPY --from=parent tests tests/
COPY --from=parent resources resources/

# Set the PATH and locale.
ENV PATH="/opt/bash:/opt/argparser:${PATH}"

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Add a non-root user.
RUN useradd --create-home --user-group --uid=1001 user
USER user

# Set the test suite to run under Bash in the given version.  For manual
# introspection, use a customized prompt stating Bash's version.
WORKDIR /opt/argparser/tests
RUN echo "PS1='bash-\V:\w\$ '" >> "${HOME}/.bashrc"
ENTRYPOINT [ "bash" ]
