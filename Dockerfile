
FROM golang:1.18 AS build

WORKDIR /app

COPY . .

RUN go build -o app cmd/main.go

FROM linuxserver/ffmpeg

WORKDIR /app

COPY --from=build /app/app .

RUN adduser --system runner
RUN chown runner runtime

USER runner

ENTRYPOINT [ "./app" ]