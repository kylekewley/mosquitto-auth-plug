FROM eclipse-mosquitto

RUN apk update && \
  apk add --no-cache openssl libressl-dev make build-base curl-dev mosquitto-dev

COPY . /src
WORKDIR /src

RUN wget https://mosquitto.org/files/source/mosquitto-${VERSION}.tar.gz -O /tmp/mosq.tar.gz && \
    mkdir -p /build/mosq && \
    tar --strip=1 -xf /tmp/mosq.tar.gz -C /build/mosq && \
    rm /tmp/mosq.tar.gz && \
    make && \
    mkdir /mosquitto/plug && \
    cp auth-plug.so /mosquitto/plug/auth-plug.so && \
    chown -R mosquitto:mosquitto /mosquitto/plug && \
    rm -rf /var/cache/apk/* /src

WORKDIR /
#RUN apk del libressl-dev make build-base mosquitto-dev curl-dev