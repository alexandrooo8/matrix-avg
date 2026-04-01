FROM ubuntu:latest

COPY *.deb /app/

RUN apt update && \
    apt install -y dpkg && \
    dpkg -i /app/*.deb || apt-get install -f -y && \
    find / -name "matrix_avg" 2>/dev/null

CMD ["/bin/sh", "-c", "find / -name matrix_avg 2>/dev/null && $(find / -name matrix_avg 2>/dev/null | head -1)"]
