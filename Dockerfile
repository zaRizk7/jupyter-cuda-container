FROM nvcr.io/nvidia/tensorflow:22.08-tf2-py3

EXPOSE 8888 8889

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -y

RUN apt-get install tmux -y

RUN pip install --upgrade pip

RUN curl -sSL https://install.python-poetry.org | python3 -

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	poetry add $( cat ml-packages/requirements-cuda-docker.txt ) && \
	rm -rf ml-packages

RUN curl -fsSL https://code-server.dev/install.sh | sh

ADD run /bin

ADD inspect /bin

RUN chmod +x /bin/run /bin/inspect
