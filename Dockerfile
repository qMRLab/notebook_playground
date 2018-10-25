FROM agahkarakuzu/jnbase

RUN npm install -g ijavascript; \
    ijsinstall

CMD ijs --ip=* --debug \

EXPOSE 8888 \

RUN cd $HOME/work; \
   pip install octave_kernel sos sos-notebook scipy plotly dash dash_core_components dash_html_components dash_dangerously_set_inner_html dash-renderer flask==0.12.2; \
   python -m sos_notebook.install; \
   git clone --single-branch -b sos-javascript-fresh https://github.com/qMRLab/notebook_playground; \
   cd notebook_playground; \
   git clone https://github.com/neuropoly/qMRLab.git; \
   chmod -R 777 $HOME/work/notebook_playground;  \
   octave --eval “cd qMRLab;  \
                     startup;  \
                     pkg list;”

WORKDIR $HOME/work/notebook_playground

USER root