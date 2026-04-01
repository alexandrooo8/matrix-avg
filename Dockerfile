FROM ubuntu:latest

COPY *.deb /app/

RUN apt update && \
    apt install -y dpkg && \
    dpkg -i /app/*.deb || apt-get install -f -y

CMD ["/usr/local/bin/matrix_avg"]
