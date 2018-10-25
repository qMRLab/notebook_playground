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

# install wget
RUN apt-get update
RUN apt-get install -y wget

# install nodejs
WORKDIR /tmp
RUN wget https://nodejs.org/download/release/v0.12.9/node-v0.12.9-linux-x64.tar.gz
RUN tar xzf node-v0.12.9-linux-x64.tar.gz
RUN sudo cp -rp node-v0.12.9-linux-x64 /usr/local/
RUN sudo ln -s /usr/local/node-v0.12.9-linux-x64 /usr/local/node
ENV PATH /usr/local/node/bin:$PATH

# install jupyter-nodejs
RUN mkdir -p  $HOME/.ipython/kernels/nodejs
RUN wget https://github.com/notablemind/jupyter-nodejs/releases/download/v1.1.0/jupyter-nodejs-1.1.0.tgz
RUN tar xf jupyter-nodejs-1.1.0.tgz
WORKDIR /tmp/package
RUN npm install && node install.js

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
