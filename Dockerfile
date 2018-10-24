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

RUN cd $HOME/work;\
    pip install octave_kernel sos sos-notebook scipy plotly dash dash_core_components dash_html_components dash_dangerously_set_inner_html dash-renderer flask==0.12.2;\
    python -m sos_notebook.install;\
    git clone --single-branch -b qmrstat https://github.com/qMRLab/notebook_playground;\
    cd notebook_playground;\
    git clone https://github.com/neuropoly/qMRLab.git;\
    chmod -R 777 $HOME/work/notebook_playground; \
    octave --eval "cd qMRLab; \
                      startup; \
                      pkg list;"

COPY requirements.txt $HOME/work/requirements.txt
RUN cd $HOME/work;\
    pip install -r requirements.txt 

WORKDIR $HOME/work/notebook_playground

USER $NB_UID
