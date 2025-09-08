FROM jupyter/datascience-notebook:latest

# Instal paket sebagai root (sebelum switch user)
USER root
RUN apt-get update && apt-get install -y \
    sudo \
    tmux \
    screen \
    wget \
    tar \
    zip \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Buat konfigurasi sudoers (tetapkan sebelum switch user)
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/jovyan \
    && chmod 0440 /etc/sudoers.d/jovyan

# Switch ke user non-root
USER jovyan

# Set the working directory
WORKDIR /home/jovyan

# Expose the Jupyter Notebook port
EXPOSE 8888

# Command to run Jupyter Notebook
CMD ["start-notebook.sh"]
