FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ENV STABLE_DIFFUSION_REPO="https://github.com/CompVis/stable-diffusion"
ENV STABLE_DIFFUSION_SD_REPO="https://github.com/basujindal/stable-diffusion"


# Set-up container dependencies.
RUN apt-get update \
    && apt-get install -y python3 python3-pip git libgl1-mesa-glx libglib2.0-0

