FROM nvcr.io/nvidia/tensorflow:22.08-tf2-py3

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update -y

RUN apt-get install tmux -y

RUN pip install --upgrade pip

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip install -r ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN tmux new -d -s jupyter-lab-server && \
	tmux send-keys -t jupyter-lab-server "jupyter lab . --port=8888" C-m && \
	tmux new -d -s vscode-server && \
	tmux send-keys -t vscode-server "PORT=8889 code-server" C-m

