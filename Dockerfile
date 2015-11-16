FROM ubuntu:trusty

RUN apt-get update && apt-get install -y \
    emacs \
    gcc \
    git \
    make \
    r-base \
    vim \
    wget \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add lab software.
RUN git clone https://github.com/ezorita/seeq.git && \
    git clone https://github.com/gui11aume/starcode.git && \
    git clone https://github.com/gui11aume/zerone.git && \
    # git reset --hard #SHA1
    make -C seeq && \
    make -C starcode && \
    make -C zerone && \
    #make test -C seeq/test && \
    #make test -C starcode/test && \
    #make test -C zerone/src/test && \
    #make clean -C seeq/test && \
    #make clean -C starcode/test && \
    #make clean -C zerone/src/test
    R CMD INSTALL zerone/ZeroneRPackage && \
    make clean -C zerone/ZeroneRPackage/src

# Add GEM.
ENV GEM_RELEASE=3 GEM=GEM-binaries-Linux-x86_64-core_i3-20130406-045632
RUN wget http://downloads.sourceforge.net/project/gemlibrary/gem-library/Binary%20pre-release%20${GEM_RELEASE}/${GEM}.tbz2 && /
    tar -xjf ${GEM}.tbz2 && \
    rm ${GEM}.tbz2
# md5sum 06de0a815f0cee963ec94321d899042a

# Update PATH.
ENV PATH $PATH:/seeq:/starcode:/zerone:/${GEM}/bin
