TAG=20240708
docker buildx build --no-cache --push --platform linux/amd64 --tag happycerberus/devenv-stable:latest-amd64 --tag happycerberus/devenv-stable:${TAG}-amd64 .