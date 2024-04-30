FROM python:3.12.3-alpine

WORKDIR /sources

RUN pip install uvicorn fastapi prometheus-fastapi-instrumentator

COPY app.py app.py

ENTRYPOINT ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "1", "--proxy-headers", "--no-access-log"]