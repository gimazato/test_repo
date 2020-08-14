# https://github.com/keras-team/keras/blob/master/docker/Dockerfile 
# https://www.tensorflow.org/install/pip?hl=ja#%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E8%A6%81%E4%BB%B6 を参考にして作成
ARG cuda_version=10.1
ARG cudnn_version=7
ARG python_version=3.7


# base image
FROM nvidia/cuda:${cuda_version}-cudnn${cudnn_version}-devel


# add sudo user
ARG DOCKER_UID=1000
ARG DOCKER_USER=user
ARG DOCKER_PASSWORD=password
RUN apt-get update && apt-get install -y --no-install-recommends sudo
RUN groupadd -g 1000 developer
RUN useradd -u $DOCKER_UID -g developer -G sudo -m -s /bin/bash ${DOCKER_USER} && \
    echo ${DOCKER_USER}:${DOCKER_PASSWORD} | chpasswd
# condaフォルダの所有権変更
# RUN chown $DOCKER_USER $CONDA_DIR -R 
# ? # passwdなしでsudo
RUN echo 'Defaults visiblepw'             >> /etc/sudoers && \ 
    echo '${DOCKER_USER} ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 
#user変更
USER ${DOCKER_USER}
#WORKDIR /home/${DOCKER_USER}/workspace

# デフォルトのシェル変更
SHELL ["/bin/bash", "-c"]

# Install system packages
RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
      python3-dev \
      python3-pip \
      vim \
      wget && \
    rm -rf /var/lib/apt/lists/*

# Install conda
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
RUN wget --quiet --no-check-certificate https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-latest-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-latest-Linux-x86_64.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc 


# Install Python packages and keras #"."" は bin/shでのsourceの役割
# RUN conda config --append channels conda-forge
RUN conda update -y conda && \
    conda create -n venv37 pip python=${python_version} 
RUN conda init bash && \
    source ~/.bashrc && \
    conda activate venv37 &&\
    pip install --upgrade pip && \
    pip install \
      --ignore-installed --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-2.1.0-cp37-cp37m-manylinux2010_x86_64.whl && \
    pip install --upgrade tensorflow && \
    conda install \
      numpy \
      matplotlib \
      Pillow \
      pandas \
      scikit-learn && \
    conda clean -yt

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#WORKDIR /workspace