FROM nvcr.io/nvidia/tensorflow:22.08-tf2-py3

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -y

RUN apt-get install tmux -y

RUN pip install --upgrade pip

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip install -r ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh && \
	chmod +x /usr/local/bin/oh-my-posh && \
	mkdir ~/.poshthemes && \
	wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip && \
	unzip ~/.poshthemes/themes.zip -d ~/.poshthemes && \
	chmod u+rw ~/.poshthemes/*.json && \
	rm ~/.poshthemes/themes.zip && \
	source ~/.bashrc && \
	echo 'eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/craver.omp.json)"' >> ~/.bashrc && \
	source ~/.bashrc && \
	clear

RUN tmux new -d -s jupyter-lab-server && \
	tmux send-keys -t jupyter-lab-server "jupyter lab . --port=8888" C-m && \
	tmux new -d -s vscode-server && \
	tmux send-keys -t vscode-server "PORT=8889 code-server" C-m

