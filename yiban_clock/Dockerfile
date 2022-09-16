FROM golang:1.19-alpine AS build-env
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download && rm -f go.mod go.sum
ADD Yiban_Clock_V2.8.tar.gz ./
RUN cd Yiban_Clock_V2.8 && go build -o /yiban_clock

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
COPY --from=build-env /app/Yiban_Clock_V2.8/config/config.json /
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
VOLUME /app/config/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/yiban_clock"]