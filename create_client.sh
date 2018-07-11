docker-compose run --rm hydra clients create \
    --endpoint http://hydra:4444 \
    --id app \
    --secret secret \
    --grant-types authorize_code,refresh_token,client_credentials \
    --response-types token,code,id_token \
    --scope openid,offline \
    --callbacks http://localhost:3000/sessions/callback
