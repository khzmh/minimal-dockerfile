FROM jupyter/datascience-notebook:latest

# Switch to root user to install sudo
USER root

# Install sudo and any other necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    tmux \
    screen \
    wget \
    tar \
    zip \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Add the 'jovyan' user (or your desired user) to the sudoers file
# This allows the user to execute sudo commands without a password
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/jovyan \
    && chmod 0440 /etc/sudoers.d/jovyan

# Switch back to the 'jovyan' user for running Jupyter
USER jovyan

# Set the working directory
WORKDIR /home/jovyan

# Expose the Jupyter Notebook port
EXPOSE 8888

# Command to run Jupyter Notebook
CMD ["start-notebook.sh"]
