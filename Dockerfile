
FROM ubuntu:latest

# Atur variabel lingkungan
ARG USERNAME=jovyan
ARG USER_UID=1002
ARG USER_GID=$USER_UID

# Instal dependensi dasar
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
        git \
        curl \
        ca-certificates \
        locales \
        tzdata \
        python3-pip \
        python3-venv && \
    rm -rf /var/lib/apt/lists/*


RUN apt-get update -y && \
    apt-get install git wget tar tmux screen nano sudo zip -y
# Buat pengguna kustom dengan sudo
RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Atur zona waktu (opsional)
RUN ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    locale-gen en_US.UTF-8

# Aktifkan pengguna
USER $USERNAME

# Buat virtual environment Python
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Instal paket Python
RUN pip install --no-cache-dir notebook jupyterlab

# Setel direktori kerja
WORKDIR /home/$USERNAME

