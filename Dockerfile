FROM alpine:3.20.0

EXPOSE 8080

COPY mondoohelloworld /bin/

USER 65534

ENTRYPOINT [ "/bin/mondoohelloworld" ]

