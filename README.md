# letsencrypt

Requires the following environment variables:

- `LE_CERTS_DIR`: location for the generated certificates
- `LE_EMAIL`: email address for Let’s Encrypt account
- `LE_DOMAINS`: space separated list of domain names
- `LE_DEFAULT_ROOT`: location of the Let’s Encrypt challenge files

`docker-compose` example:

```
version: "3"

services:
  letsencrypt:
    depends_on:
      - nginx_letsencrypt
    image: fieldwork/letsencrypt
    volumes:
      - /certs:/certs
      - le_root:/tmp/letsencrypt/www
    environment:
      LE_CERTS_DIR: /certs
      LE_EMAIL: hi@example.com
      LE_DOMAINS: example.com
      LE_DEFAULT_ROOT: /tmp/letsencrypt/www

  nginx_letsencrypt:
    image: nginx:stable-alpine
    ports:
      - "80:80"
    volumes:
      - ./letsencrypt.conf:/etc/nginx/conf.d/default.conf
      - le_root:/tmp/letsencrypt/www
    command: ["nginx", "-g", "daemon off;"]

  web:
    image: nginx:stable-alpine
    ports:
      - "443:443"
    volumes:
    - ./conf.d/example.com.conf:/etc/nginx/conf.d/default.conf
    - le_root:/tmp/letsencrypt/www
    - /certs:/etc/ssl/certs

volumes:
  le_root: {}
```
