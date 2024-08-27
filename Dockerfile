FROM ghcr.io/openfaas/classic-watchdog:0.3.1 AS watchdog

FROM ubuntu

RUN apt-get update && apt-get install -y \
    unzip \
    texlive-full \
    pdf2svg

RUN mkdir -p /home/app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog
COPY bin/ /usr/local/bin
RUN chmod +x /usr/local/bin/*

# Add non root user
RUN groupadd --system app && useradd app --system -g app
RUN chown app /home/app

WORKDIR /home/app

USER app

# Populate example here - i.e. "cat", "sha512sum" or "node index.js"
ENV fprocess="pdflatex"
# Set to true to see request in function logs
ENV write_debug="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]
