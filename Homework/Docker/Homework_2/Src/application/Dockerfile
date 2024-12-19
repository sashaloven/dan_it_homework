FROM python:3.9-slim

WORKDIR /app

RUN pip install flask gunicorn

COPY . .

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
