FROM golang:1.19-alpine AS build-env
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download && rm -f go.mod go.sum
ADD Yiban_Clock_V2.8.tar.gz ./
RUN cd Yiban_Clock_V2.8 && go build -o /yiban_clock

FROM alpine
RUN apk update && \
   apk add ca-certificates && \
   update-ca-certificates && \
   rm -rf /var/cache/apk/*
WORKDIR /app
COPY --from=build-env /yiban_clock /
COPY --from=build-env /app/Yiban_Clock_V2.8/config/config.json /app/config/
#RUN mkdir /app/config/
VOLUME /app/config/
CMD ["/yiban_clock"]
