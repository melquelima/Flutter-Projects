FROM python:3.8.12-bullseye

# Fix timezone container
ENV TZ=America/Sao_Paulo
ENV TERM=xterm
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


WORKDIR /app

COPY . .

RUN pip install -r requirements.txt
