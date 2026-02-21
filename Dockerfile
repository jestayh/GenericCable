FROM nvidia/cuda:12.1.0-devel-ubuntu22.04

# Install dependencies
RUN apt update && apt install -y \
    wget \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh && \
    bash /miniconda.sh -b -p /opt/miniconda && \
    rm /miniconda.sh

ENV PATH="/opt/miniconda/bin:$PATH"
# Set CUDA architecture for PyTorch compilation (use architecture names)
ENV TORCH_CUDA_ARCH_LIST="Turing;Ampere"

# Accept Conda ToS and configure channels
RUN conda config --system --prepend channels conda-forge && \
    conda config --system --set auto_update_conda false && \
    conda config --system --set show_channel_urls true

# Clone GenericCable
WORKDIR /workspace
RUN git clone https://github.com/jestayh/GenericCable.git

WORKDIR /workspace/GenericCable

# Create conda environment from environment.yml
RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    conda env create -f environment.yml -y && \
    echo "source activate genericcable" > ~/.bashrc

SHELL ["conda", "run", "-n", "genericcable", "/bin/bash", "-c"]

# Install system dependencies for CUDA compilation
RUN apt-get update && apt-get install -y \
    libcufft-dev-12-1 \
    cuda-nvrtc-dev-12-1 \
    cuda-nvrtc-12-1 \
    && rm -rf /var/lib/apt/lists/*

# Install seisfwi (already in environment.yml, but ensure it's installed)
RUN pip install seisfwi

# Install GenericCable in editable mode (already in environment.yml)
RUN pip install -e .

# Fix imagex → seisfwi imports
RUN find /opt/miniconda/envs/genericcable/lib/python3.10/site-packages/seisfwi -name "*.py" \
    -exec sed -i 's/from imagex/from seisfwi/g' {} \;

# Expose Jupyter port
EXPOSE 8888

# Start Jupyter Lab with conda environment activated
CMD ["/bin/bash", "-c", "source activate genericcable && jupyter lab --ip=0.0.0.0 --allow-root --no-browser"]
