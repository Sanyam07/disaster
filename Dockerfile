# base-image declaration & credentials
FROM python:3.6-slim
## For PySpark projects use this image below instead:
# FROM neowaylabs/docker-spark:2.3.1-hadoop-2.9.1

# Show Python version on build step
RUN python -V

# Build application
ARG APP_DIR=/app
WORKDIR ${APP_DIR}
RUN mkdir -p ${APP_DIR}/workspace/data/
RUN mkdir -p ${APP_DIR}/workspace/download/
RUN mkdir -p ${APP_DIR}/workspace/features/
RUN mkdir -p ${APP_DIR}/workspace/models/
RUN mkdir -p ${APP_DIR}/workspace/predict/

# Install requirements
RUN apt-get update && apt-get install -y build-essential
ADD requirements.txt .
RUN pip --disable-pip-version-check install -r requirements.txt

COPY . ${APP_DIR}
RUN pip --disable-pip-version-check install -e .
RUN chmod -R a+w ${APP_DIR}
ENTRYPOINT ["disaster"]

# Install 'nltk' and download 'punkt'
RUN pip --disable-pip-version-check install nltk==3.4.5
RUN python -m nltk.downloader -d /nltk_data punkt

