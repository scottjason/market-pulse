FROM python:3.11-slim

WORKDIR /app

COPY ./backend/requirements.txt /app/requirements.txt

RUN ls -la /app

RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

COPY ./backend /app/

ENV PYTHONUNBUFFERED=1

EXPOSE 8000

CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

