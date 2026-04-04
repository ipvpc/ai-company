sudo docker run -it --rm \
  -e DATABASE_URL=${DATABASE_URL:-postgres://paperclip:paperclip@postgres.alpha5.finance:5432/paperclip} \
  -e HOST=127.0.0.1 \
  -e PORT=3100 \
  -e PAPERCLIP_DEPLOYMENT_MODE=authenticated \
  -e PAPERCLIP_DEPLOYMENT_EXPOSURE=private \
  -e PAPERCLIP_PUBLIC_URL=http://127.0.0.1:3100 \
  -e BETTER_AUTH_SECRET=${BETTER_AUTH_SECRET:-SRdHO4pO2UaeKvVKHIE0HC2x+iiB7gcRrETKiLUkHn8=} \
  -e PAPERCLIP_AGENT_JWT_SECRET=${PAPERCLIP_AGENT_JWT_SECRET:-yJaFGQ6fnznlTzUas1QXfIJbXc1XcHwctQqGoGjijzA} \
  -v /data/services/paperclip:/home/paperclip \
  registry.alpha5.finance/trade-system/paperclip:latest bash