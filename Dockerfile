FROM alpine:3.15.0
RUN apk add --no-cache bash curl jq

ARG script="isod-wapi-checker.sh"

ENV WAPI_USER=""
ENV WAPI_KEY=""
ENV WEBHOOK_URL=""
ENV DISCORD_UID=""

WORKDIR /app
COPY "isod-wapi-checker.sh" .

CMD ["bash", "-c", "WAPI_USER=$WAPI_USER WAPI_KEY=$WAPI_KEY WEBHOOK_URL=$WEBHOOK_URL DISCORD_UID=$DISCORD_UID ./isod-wapi-checker.sh"]