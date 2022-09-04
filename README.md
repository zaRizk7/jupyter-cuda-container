# Jupyter CUDA Docker

My docker image for deep learning purposes on both PyTorch and TensorFlow.

To build this image it requires NVIDIA CUDA supported device.

## Installation

Note that this step is for Ubuntu with NVIDIA drivers installed.

1. Install Docker using bash script in **https://gist.github.com/rdibella/a8d0c59e60d3c41d8bd61016244a4835#file-docker_install-sh**
2. Install NVIDIA Container Toolkit using bash script in **https://gist.github.com/rdibella/c6b85247dada3b235ef9e3d0d20eb589#file-nvidia-container-toolkit-sh**
3. Reboot using ```sudo reboot now``` (Optional)
4. Test Docker communication with GPU using ```sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi```
6. If the Dockerfile haven't been built, run ```docker build . -t zaRizk7/jupyter-cuda:latest```.
7. Finally, run the container using command ```docker run --gpus all -it --rm -p 0.0.0.0:8888:8888 --ulimit memlock=-1 --ulimit stack=67108864 jupyter-cuda```
