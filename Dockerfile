# Compile
FROM    alpine:3.10

RUN     apk update --quiet
RUN     apk add curl
RUN     apk add build-base
RUN     apk add libressl-dev

RUN     curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

WORKDIR /meilisearch-rust

ENV     RUSTFLAGS="-C target-feature=-crt-static"

RUN     apk add -q --no-cache libgcc tini curl && \
        curl -L https://install.meilisearch.com | sh && \
        chmod +x meilisearch

COPY    . .

ENTRYPOINT ["tini", "--"]
CMD     ["./scripts/run-test.sh"]