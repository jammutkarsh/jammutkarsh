FROM golang:alpine as builder
LABEL maintainer="Utkarsh Chourasia <5.utkarshchourasia@gmail.com"
RUN apk update && apk add --no-cache git
WORKDIR /app
RUN git clone https://github.com/charmbracelet/glow
WORKDIR /app/glow
RUN go build -o glow
FROM alpine
WORKDIR /root/
COPY --from=builder /app/glow/glow glow
COPY  INTRO.md INTRO.md
ENV TERM xterm-256color
CMD ["./glow", "INTRO.md"]