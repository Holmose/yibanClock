FROM golang:1.19-alpine

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download && rm -f go.mod go.sum
ADD Yiban_Clock_V2.6.tar.gz ./
RUN cd Yiban_Clock_V2.6 && go build -o /yiban_clock
RUN mkdir /app/config/ && cp Yiban_Clock_V2.6/config/config.json /app/config/
VOLUME /app/config/
CMD ["/yiban_clock"]
