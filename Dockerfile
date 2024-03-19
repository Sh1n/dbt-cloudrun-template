FROM python:3.9-slim

ENV MODEL=""
ENV TARGET="dev"
ENV KEY_FILE=""

WORKDIR /dbt
COPY . .

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x entrypoint.sh

# Ensure we have all the project's packages installed in the container
RUN dbt deps

WORKDIR /dbt

ENTRYPOINT ["./entrypoint.sh"]