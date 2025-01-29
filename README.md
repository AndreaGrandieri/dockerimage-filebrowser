# andreagrandieri/filebrowser

Wrapper for filebrowser from: https://filebrowser.org/.

## Basic config with docker.compose

```yaml
services:
  minecraft:
    image: andreagrandieri/filebrowser:latest
    tty: true
    stdin_open: true
    ports:
      - "<EXPOSED_PORT_1>:80"
    volumes:
      - "<BIND_VOLUME_PATH>:/data"
    networks:
      - stacknet
    restart: unless-stopped

networks:
  stacknet:
```

## Env variables

| Variable Name | Required | Default Value | Description                                                    |
| ------------- | -------- | ------------- | -------------------------------------------------------------- |
| FB_INIT_USER  | NO       | admin         | Username for user creation when settings do not already exist. |
| FB_INIT_PASS  | NO       | admin         | Password for user creation when settings do not already exist. |
