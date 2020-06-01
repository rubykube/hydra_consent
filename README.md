# hydra_consent
Ruby version of https://github.com/ory/hydra-login-consent-node

## Start docker container
```shell script
docker-compose up
```

## Create OAuth 2.0 Client
```shell script
docker-compose run --rm hydra clients create \
    --endpoint http://hydra:4445 \
    --id app \
    --secret secret \
    --grant-types authorize_code,refresh_token,client_credentials \
    --response-types code \
    --scope openid,offline \
    --callbacks http://localhost:3000/sessions/callback \
    --token-endpoint-auth-method client_secret_basic
```
