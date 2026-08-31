FROM python:3.12-slim

WORKDIR /app

COPY pyproject.toml uv.lock ./

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN uv sync --frozen --no-dev

ENV PATH="/app/.venv/bin:$PATH"

COPY app ./app

EXPOSE 4333

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "4333"]