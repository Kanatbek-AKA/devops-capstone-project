FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY service/ ./service
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

ENV PORT 8000
EXPOSE $PORT 
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
