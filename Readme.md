# ISOD-notificator

An extension to [ISOD student electronic diary](https://isod.ee.pw.edu.pl/) that features publishing news notification from ISOD to [Discord](https://discord.com/). It's written in bash and functions on top of ISOD WAPI and Discord Webhooks.

![isodnewsexample](https://user-images.githubusercontent.com/37814427/151696851-6e8fd11a-49af-401d-9566-0959aa559b40.png)

## Usage

You need to have an active [ISOD](https://isod.ee.pw.edu.pl/) account and generate your WAPI key - see [WAPI docs](https://hub.docker.com/r/saadbruno/minecraft-discord-webhook). Then prepare the integration with Discord by creating a [Discord Webhook](https://support.discord.com/hc/pl/articles/228383668-Intro-to-Webhooks). 

### Environment variables
The script uses following variables:
- **WAPI_USER** *(ISOD username)*,
- **WAPI_KEY** *(ISOD wapi key)*,
- **WEBHOOK_URL** *(Discord Webhook url)*,
- **DISCORD_UID** *(optional discord user ID)*.

If DISCORD_UID is not empty, discord webhook will use it to ping the user with DISCORD_UID id.

### Pull and run from docker registry

There is an application image available at [DockerHub](https://hub.docker.com/repository/docker/danielsporysz/isod-notificator).

```
docker pull danielsporysz/isod-notificator:latest
docker run \
    -e WAPI_USER="" \
    -e WAPI_KEY="" \
    -e WEBHOOK_URL="" \
    -e DISCORD_UID="" \
    danielsporysz/isod-notificator:latest
```

## Disclaimer

[WAPI docs](https://hub.docker.com/r/saadbruno/minecraft-discord-webhook) do not state any usage policy and rate limiting but use this script at your own risk of having your ISOD account suspended.
