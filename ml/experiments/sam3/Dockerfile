FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    SAM3_HOST=0.0.0.0 \
    HF_HOME=/model-cache

WORKDIR /app
COPY pyproject.toml README.md ./
COPY sam3_lab ./sam3_lab
RUN pip install --no-cache-dir 'torch==2.10.0+cpu' --index-url https://download.pytorch.org/whl/cpu \
    && pip install --no-cache-dir .

EXPOSE 7860
CMD ["sam3-viewer"]
