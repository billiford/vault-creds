# Download and verify the integrity of the download first
FROM sethvargo/hashicorp-installer AS installer
RUN /install-hashicorp-tool "vault" "1.2.2"

# Now copy the binary over into a smaller base image
FROM alpine

RUN apk add ca-certificates bash curl jq && \
  rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8

COPY --from=installer /software/vault /usr/local/bin

COPY download.sh .

RUN ["chmod", "+x", "./download.sh"]

ENTRYPOINT [ "./download.sh" ]
