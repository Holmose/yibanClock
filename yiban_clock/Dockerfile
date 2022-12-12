FROM golang:1.19-alpine AS build-env

ARG YIBAN_FILENAME=yiban3_V1.0.5
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download && rm -f go.mod go.sum
ADD $YIBAN_FILENAME.tar.gz ./
RUN mv ${YIBAN_FILENAME} yiban_src && cd yiban_src && go build -o /yiban_clock

FROM alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update && apk add ca-certificates &&  update-ca-certificates\
    && apk add tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build-env /yiban_clock /
COPY --from=build-env /app/yiban_src/config/config.json /
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
VOLUME /app/config/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/yiban_clock", "-clock_now=true"]
