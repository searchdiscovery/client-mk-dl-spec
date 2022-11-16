FROM python:3.10.0-alpine3.13

ARG WITH_PLUGINS=false

COPY requirements.txt requirements.txt
COPY requirements-plugins.txt requirements-plugins.txt

RUN pip install --no-cache-dir -r requirements.txt \
  && \
    if [ "${WITH_PLUGINS}" = "true"]; then \
      pip install --no-cache-dir -r requirements-plugins.txt; \
    fi

WORKDIR /docs

EXPOSE 8080

ENTRYPOINT ["mkdocs"]
CMD ["serve"]