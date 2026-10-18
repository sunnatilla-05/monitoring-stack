# --- stage 1: сборка зависимостей ---
FROM python:3.12-slim AS builder
WORKDIR /build
COPY app/requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# --- stage 2: минимальный рантайм ---
FROM python:3.12-slim
ARG APP_VERSION=dev
ENV APP_VERSION=${APP_VERSION} PYTHONUNBUFFERED=1
RUN useradd --create-home --uid 1000 appuser
WORKDIR /srv
COPY --from=builder /install /usr/local
COPY app/app.py .
USER appuser
EXPOSE 8000
HEALTHCHECK --interval=30s --timeout=3s CMD python -c "import urllib.request as u; u.urlopen('http://localhost:8000/health')" || exit 1
CMD ["gunicorn", "-b", "0.0.0.0:8000", "-w", "2", "app:app"]
