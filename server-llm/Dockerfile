FROM python:3.11.11-slim

ENV PYTHONUNBUFFERED = 1

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

CMD ["python3", "manage,py", "migrate"]
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]