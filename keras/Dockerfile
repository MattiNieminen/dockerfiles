FROM ubuntu:18.04

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends curl

# Tips from https://github.com/ContinuumIO/docker-images/tree/master/anaconda3
RUN curl -k https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -o anaconda.sh && \
  /bin/bash anaconda.sh -b -p /opt/conda && \
  rm anaconda.sh && \
  ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
  echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
  echo "conda activate base" >> ~/.bashrc

# Downgrading Python to 3.6 can be removed when Tensorflow starts working
# with Python 3.7.
RUN conda install python=3.6 && \
  conda install pip && \
  pip install --upgrade pip && \
  pip install --upgrade tensorflow && \
  pip install --upgrade keras

EXPOSE 8888

WORKDIR /root/workdir

CMD jupyter notebook --NotebookApp.token="$TOKEN" --ip=0.0.0.0 --allow-root --no-browser
