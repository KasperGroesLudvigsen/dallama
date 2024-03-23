#FROM python:3
FROM nvidia/cuda:12.3.2-cudnn9-runtime-ubuntu22.04


RUN apt-get update

RUN apt-get install -y python3

RUN apt-get install -y git
RUN apt-get install -y python3-pip
RUN pip install --upgrade pip
#ARG HF_TOKEN
#ENV HF_TOKEN=$HF_TOKEN

#RUN huggingface-cli login

RUN git clone https://github.com/AnswerDotAI/fsdp_qlora


RUN pip install llama-recipes fastcore --extra-index-url https://download.pytorch.org/whl/test/cu121

RUN pip install bitsandbytes>=0.43.0

# Set as env variable at runtime instead of here. Download model at runtime too instead of storing in image
#RUN echo HF_TOKEN | huggingface-cli login

#RUN pip install hqq

#RUN git clone https://github.com/mobiusml/hqq.git

RUN echo pwd

RUN pip install hqq

COPY hqq .

RUN cd hqq

RUN echo pwd
#RUN pip install .

# Run this in the container. TODO: Check what driver version is recommended
#RUN cd hqq/kernels && python3 setup_cuda.py install
#RUN cd hqq/kernels && python setup_cuda.py install

RUN pip install wandb

RUN pip install codecarbon

RUN apt install -y nvidia-driver-535

RUN apt install gcc

RUN apt install wget 

# Install NVCC / cuda
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg -i cuda-keyring_1.1-1_all.deb
RUN apt-get update
RUN apt-get -y install cuda

RUN pip install ninja

# Install hqq kernel stuff
RUN cd hqq/kernels && python3 setup_cuda.py install

# docker build --build-arg ACCESS_TOKEN=<your_access_token> -t your_image_name:tag .
# docker build -t your_image_name:tag .
