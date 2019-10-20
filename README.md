# lsiobase-cronicle

ENV variables: https://github.com/jhuckaby/Cronicle#environment-variables

```
docker run -d \
--name cronicle \
--hostname cronicle.example.com \
--restart unless-stopped \
--network private-network \
-e TZ=Europe/Prague \
-e CRONICLE_base_app_url='http://cronicle.example.com' \
-e CRONICLE_client__custom_live_log_socket_url='http://cronicle.example.com' \
-e CRONICLE_master_ping_timeout=5 \
-e PUID=1000 \
-e PGID=1000 \
-v /data/docker-data/cronicle/data:/config/data \
-v /data/docker-data/cronicle/plugins:/config/plugins \
-p 3012:3012 \
lukasmrtvy/lsiobase-cronicle
```

# optional variables
- DOCKER_HOST
- TZ
- https://github.com/jhuckaby/Cronicle#environment-variables


# traefik labels
```
--label "traefik.enable=true" \
--label "traefik.basic.frontend.rule=Host:cronicle.example.com" \
--label "traefik.basic.port=3012" \
```

# batteries included
- docker-cli
- bash
- jq
- curl

# docker proxy
```
docker run -d \
    --privileged \
    --name dockerproxy \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --network private-network \
    -e INFO=1 \
    -e CONTAINERS=1 \
    -e POST=1 \
    tecnativa/docker-socket-proxy
```

# ACME CF DNS-Challenge DIND - docker-cli
```
docker run --rm \
-e CLOUDFLARE_EMAIL=foobar@example.com \
-e CLOUDFLARE_API_KEY=xxxxx \
-v /tmp/.lego/:/.lego/ \
goacme/lego --accept-tos --email foobar@example.com --domains foobar.example.com --dns cloudflare  run
```

# list containers -> job example - curl
```
curl -s http://proxy:2375/containers/json | jq
```

# run container from Cronicle ( didn ) -> job example - curl
```
curl - s \
  "http://proxy:2375/containers/create?name=foobar" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{ "Image": "alpine:latest", "Cmd": [ "echo", "hello world" ] }' | jq '.'
```
