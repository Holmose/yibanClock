FROM golang:1.19-alpine AS build-env

ARG YIBAN_FILENAME=yiban3_V1.0.1
ARG OUTFILENAME=yiban_clock

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download && rm -f go.mod go.sum
ADD $YIBAN_FILENAME.tar.gz ./
RUN cd $YIBAN_FILENAME && go build -o /$OUTFILENAME

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
COPY --from=build-env /app/$YIBAN_FILENAME/config/config.json /
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
VOLUME /app/config/
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/$OUTFILENAME", "-clock_now=true"]
