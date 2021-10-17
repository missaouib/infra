FROM traefik:v2.5.3
RUN mkdir -p /etc/traefik/acme \
  && touch /etc/traefik/acme/acme.json \
  && chmod 600 /etc/traefik/acme/acme.json
COPY ./traefik/traefik.yml /etc/traefik