FROM ubuntu:18.04

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends wget

# From https://github.com/ContinuumIO/docker-images/tree/master/anaconda3
RUN wget --quiet --no-check-certificate https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O anaconda.sh && \
  /bin/bash anaconda.sh -b -p /opt/conda && \
  rm anaconda.sh && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc

RUN conda install pip && \
  pip install --upgrade tensorflow && \
  pip install --upgrade keras

EXPOSE 8888

WORKDIR /root/workdir

CMD jupyter notebook --NotebookApp.token="$TOKEN" --ip=0.0.0.0 --allow-root --no-browser
