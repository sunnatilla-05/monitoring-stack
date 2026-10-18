# monitoring-stack
Flask-сервис с метриками, multi-stage Dockerfile, запуск не от root и HEALTHCHECK. docker-compose.yml поднимает сервис, Prometheus и Grafana, есть алерты AppDown и HighErrorRate. CI-пайплайны для GitHub Actions и GitLab CI: линтер, тесты, сборка образа с кэшем. Он подтверждает пункт резюме про multi-stage builds и кэширование в CI/CD.
