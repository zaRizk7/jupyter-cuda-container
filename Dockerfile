FROM tensorflow/tensorflow:latest

EXPOSE 8888 8889

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN type -p curl >/dev/null || apt install curl -y

RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

RUN apt-get update -y

RUN apt-get install tmux git gh nodejs -y

RUN pip install --upgrade pip

RUN git clone https://github.com/zaRizk7/ml-packages.git && \
	pip install --upgrade -r ml-packages/requirements-cuda-docker.txt && \
	rm -rf ml-packages

RUN curl -fsSL https://code-server.dev/install.sh | sh

ADD run /bin

ADD inspect /bin

RUN chmod +x /bin/run /bin/inspect
