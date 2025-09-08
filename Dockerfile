FROM ubuntu:latest

USER root


RUN apt-get update -y && \
    apt-get install git wget tar tmux screen -y
RUN apt-get install python3 python3-pip python3-venv -y    

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab


# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

RUN echo "${NB_USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${NB_USER} \
    && chmod 0440 /etc/sudoers.d/${NB_USER}
