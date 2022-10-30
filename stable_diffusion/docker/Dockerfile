FROM nvidia/cuda:11.8.0-base-ubuntu22.04

ENV STABLE_DIFFUSION_REPO="https://github.com/CompVis/stable-diffusion"
ENV STABLE_DIFFUSION_SD_REPO="https://github.com/basujindal/stable-diffusion"


# Set-up container dependencies.
RUN apt-get update \
    && apt-get install -y python3 python3-pip git libgl1-mesa-glx libglib2.0-0 curl


# Set-up SD repo.
RUN git clone ${STABLE_DIFFUSION_REPO} /app

WORKDIR /app/stable-diffusion

# Set-up SD python dependencies
COPY requirements.txt ./requirements.txt
RUN pip install --no-cache -r requirements.txt

# Hook Optimized SD scripts into SD repo.
# We currently only monky patch img2txt and txt2img, inpainting and more features
# are not supported yet.
ENV OPTIMIZED_SD_DIR="/app/stable-diffusion/optimizedSD/"
RUN mkdir /app/stable-diffusion/optimizedSD/
RUN curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/optimized_txt2img.py >> /app/stable-diffusion/optimizedSD/optimized_txt2img.py && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/optimized_img2img.py >> /app/stable-diffusion/optimizedSD/optimized_img2img.py && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/optimUtils.py >> /app/stable-diffusion/optimizedSD/optimUtils.py && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/v1-inference.yaml >> /app/stable-diffusion/optimizedSD/v1-inference.yaml && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/ddpm.py >> ${OPTIMIZED_SD_DIR}/ddpm.py && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/samplers.py >> ${OPTIMIZED_SD_DIR}/samplers.py && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/openaimodelSplit.py >> ${OPTIMIZED_SD_DIR}/openaimodelSplit.py && \
    curl https://raw.githubusercontent.com/basujindal/stable-diffusion/main/optimizedSD/splitAttention.py >> ${OPTIMIZED_SD_DIR}/splitAttention.py

ENV PYTHONPATH=${PYTHONPATH}:/app/stable-diffusion/
#RUN pip install -e /app/