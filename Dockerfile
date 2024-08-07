FROM ghcr.io/openfaas/classic-watchdog:0.1.4 as watchdog

FROM ubuntu

RUN apt-get update && apt-get install -y \
    texlive

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog
COPY latex2pdf /usr/bin/latex2pdf
RUN chmod +x /usr/bin/latex2pdf

# Add non root user
RUN adduser --system --group app
USER app

WORKDIR /tmp

ENV write_debug="false"
ENV combine_output="false"

EXPOSE 8080

HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]