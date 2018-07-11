docker-compose up --build
docker-compose run --rm hydra clients create \
    --endpoint http://hydra:4444 \
    --id app \
    --secret secret \
    --grant-types authorization_code,refresh_token \
    --response-types code,id_token \
    --scope openid,offline \
    --callbacks http://localhost:3000/callback
