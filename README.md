# monitoring-stack

Учебный проект: небольшой Python-сервис, упакованный в Docker, с мониторингом
(Prometheus + Grafana), алертами и CI-пайплайном (GitHub Actions и GitLab CI).

## Что демонстрирует проект

- **Multi-stage Dockerfile**: зависимости ставятся в отдельном слое, в итоговый образ попадает только рантайм; контейнер работает не от root, есть `HEALTHCHECK`.
- **Docker Compose**: сервис, Prometheus и Grafana поднимаются одной командой.
- **Метрики и алерты**: счётчик запросов, гистограмма задержек, правила `AppDown` и `HighErrorRate`.
- **CI/CD**: линтер, тесты, сборка образа с кэшем слоёв.

## Быстрый старт

```bash
docker compose up -d --build
curl localhost:8000/health        # {"status":"ok"}
```

| Сервис     | Адрес                  |
|------------|------------------------|
| App        | http://localhost:8000  |
| Prometheus | http://localhost:9090  |
| Grafana    | http://localhost:3000  |

В Grafana добавьте источник данных Prometheus (`http://prometheus:9090`) и постройте
панель по запросу `rate(app_requests_total[1m])`.

Пароль Grafana задаётся переменной `GRAFANA_PASSWORD` (по умолчанию `change-me`: смените его).

## Тесты локально

```bash
pip install -r app/requirements.txt pytest
pytest -q
```

## Идеи для развития

- Добавить Alertmanager и отправку алертов в Telegram.
- Деплой на VM через Ansible-роль (см. проект `ansible-server-baseline`).
- Дашборд Grafana в виде JSON в репозитории (provisioning).
