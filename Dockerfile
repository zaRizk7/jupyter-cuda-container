FROM tensorflow/tensorflow:latest-gpu

EXPOSE 8888

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN type -p curl >/dev/null || apt-get install curl libgl1-mesa-glx ffmpeg libsm6 libxext6 -y

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get update -y

RUN apt-get install git gh nodejs -y

RUN pip install --upgrade pip

RUN sh -c "$(curl -fsSL https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/zsh-in-docker.sh | bash -)"

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip install --upgrade -r ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages
	
RUN python -m spacy download en_core_web_sm && \
	python -m textblob.download_corpora

RUN jupyter nbextension enable --py widgetsnbextension

RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["jupyter", "lab", "/home", "--port=8888", "--no-browser", "--allow-root"]
