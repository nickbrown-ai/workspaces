# Welcome to Nick's Custom Workspaces

I hate installing things on my machine and love reproducible environments, so here we are! :)

# Working with NVIDIA GPUs

A few things will need to be in place in order to take advantage of GPUs inside your container for libaries like tensorflow and pytorch. First install the [nvidia container runtime](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

```shell
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

Now the worst part is that more than likely your system installed CUDA will not be the supported versions by the main deep learning libraries, so now it is best to go ahead and install CUDA and other key dependencies into a conda environment.

```shell
conda create --name cuda-11.2
conda activate cuda-11.2
conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0 cudatoolkit-dev=11.2
nvcc -V
```

Finally, you just need to have this conda env active when we run the docker run command. Obviously you will need your container to have some additional packages inside your container that match the host drivers and stuffs. To run it, the command is something like this:

```shell
sudo docker run -ti -p 8888:8888 --user root -e GRANT_SUDO=yes --gpus all jupyter/scipy-notebook:lab-3.4.2
```

Wow! Such work, much success! 

![Doge Reward](Original_Doge_meme.jpg)