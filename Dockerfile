FROM tensorflow/tensorflow:latest-gpu

EXPOSE 8888

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN type -p curl >/dev/null || apt-get install tmux curl zip libgl1-mesa-glx ffmpeg libsm6 libxext6 aria2 -y

RUN /bin/bash -c "$(curl -sL https://git.io/vokNn)"

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-fast update -y && \
	apt-fast install git gh nodejs texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra graphviz libgraphviz-dev --fix-missing -y

RUN pip install --upgrade pip

RUN apt-fast install wget \
	&& sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.3/zsh-in-docker.sh)"

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip install --upgrade -r ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages
	
RUN python -m spacy download en_core_web_sm && \
	python -m textblob.download_corpora && \
	python -m nltk.downloader popular

RUN jupyter nbextension enable --py widgetsnbextension

RUN apt-fast autoremove -y \
	&& apt-fast clean -y \
	&& rm -rf /var/lib/apt/lists/*
	
SHELL ["/bin/zsh", "-ec"]

ENV SHELL=/bin/zsh

ENTRYPOINT ["jupyter", "lab", "/home", "--port=8888", "--no-browser", "--allow-root"]
