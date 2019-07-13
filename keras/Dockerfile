FROM ubuntu:18.04

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends curl

RUN curl -k https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh -o anaconda.sh && \
/bin/bash anaconda.sh -b -p /opt/conda && \
rm anaconda.sh

RUN pip install --upgrade pip && \
pip install --upgrade tensorflow && \
pip install --upgrade keras

EXPOSE 8888

WORKDIR /root/workdir

CMD jupyter notebook --NotebookApp.token="$TOKEN" --ip=0.0.0.0 --allow-root --no-browser
