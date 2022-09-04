tmux new -d -s jupyter-lab-server
tmux send-keys -t jupyter-lab-server "jupyter lab . --ip=* --port=8888 --no-browser --allow-root" C-m
tmux new -d -s vscode-server
tmux send-keys -t vscode-server "code-server . --bind-addr 0.0.0.0:8889" C-m
sleep 5s
jupyter notebook list
cat ~/.config/code-server/config.yaml
