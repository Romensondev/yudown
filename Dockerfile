FROM debian:latest

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean


WORKDIR /app


RUN python3 -m venv /app/venv

COPY requirements.txt requirements.txt
RUN /app/venv/bin/pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["/app/venv/bin/python", "app.py"]
