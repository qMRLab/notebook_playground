FROM jupyter/base-notebook:8ccdfc1da8d5

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        emacs \
        git \
        inkscape \
        jed \
        libsm6 \
        libxext-dev \
        libxrender1 \
        lmodern \
        netcat \
        unzip \
        nano \
        curl\
        wget \
        gfortran \
        cmake \
        bsdtar \
        rsync \
        imagemagick \
        \
        gnuplot-x11 \
        libopenblas-base \
        \
        octave \
        liboctave-dev \
        octave-info \
        octave-parallel \
        octave-struct \
        octave-io\
        octave-statistics\
        octave-optim\
        octave-image\
        \
        python3-dev \
        ttf-dejavu && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -my wget gnupg
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs libzmq3-dev build-essential && npm install -g ijavascript
RUN ijs --ijs-install-kernel

RUN cd $HOME/work;\
    pip install octave_kernel sos sos-notebook scipy plotly dash dash_core_components dash_html_components dash_dangerously_set_inner_html dash-renderer flask==0.12.2;\
    python -m sos_notebook.install;\
    git clone --single-branch -b sos-javascript https://github.com/qMRLab/notebook_playground;\
    cd notebook_playground;\
    git clone https://github.com/neuropoly/qMRLab.git;\
    chmod -R 777 $HOME/work/notebook_playground; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

WORKDIR $HOME/work/notebook_playground

USER $NB_UID
