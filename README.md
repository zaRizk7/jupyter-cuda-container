# Jupyter CUDA Docker

My docker image for deep learning purposes on both PyTorch and TensorFlow.

To build this image it requires NVIDIA CUDA supported device.

## Installation

Note that this step is for Ubuntu with NVIDIA drivers installed.

1. Install Docker using bash script in **https://gist.github.com/rdibella/a8d0c59e60d3c41d8bd61016244a4835#file-docker_install-sh**
2. Install NVIDIA Container Toolkit using bash script in **https://gist.github.com/rdibella/c6b85247dada3b235ef9e3d0d20eb589#file-nvidia-container-toolkit-sh**
3. Reboot (Optional) 
```
sudo reboot now
``` 
4. Test Docker communication with GPU using:
```
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```
5. If the Dockerfile haven't been built, run: 
```
docker build jupyter-cuda-docker -t zarizky/jupyter-cuda:latest
```
6. Run the container using command:
```
docker run --gpus all --ipc=host --ulimit memlock=-1 --ulimit stack=67108864 -it --rm -p 0.0.0.0:8888:8888 -p 0.0.0.0:8889:8889 zarizky/jupyter-cuda
```
7. Start Jupyter and Code Server session by executing:
```
./run.sh
```
