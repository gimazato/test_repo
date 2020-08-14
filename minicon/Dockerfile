FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate py37env" >> ~/.bashrc

RUN conda update -y conda && \
    conda create -n py37env python=3.7 numpy && \
    conda init bash && \
    . ~/.bashrc && \
    conda activate py37env && \
    conda install -y -c conda-forge jupyterlab nodejs==14.3.0 && \
    conda clean -ya

WORKDIR /workspace

RUN chmod -R a+w .

