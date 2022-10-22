FROM tensorflow/tensorflow:latest-gpu

EXPOSE 8888 8889

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN type -p curl >/dev/null || apt-get install curl libgl1-mesa-glx ffmpeg libsm6 libxext6 -y

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get update -y

RUN apt-get install tmux git gh nodejs -y

RUN pip install --upgrade pip

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip install --upgrade -r ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages
	
RUN python -m spacy download en_core_web_sm && \
	python -m textblob.download_corpora

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN jupyter nbextension enable --py widgetsnbextension && \
	code-server --install-extension ms-python.python

ADD run /bin

ADD inspect /bin

RUN chmod +x /bin/run /bin/inspect
