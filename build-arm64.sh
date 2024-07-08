TAG=20240708
docker buildx build --no-cache --push --platform linux/arm64 --tag happycerberus/devenv-stable:latest-arm64 --tag happycerberus/devenv-stable:${TAG}-arm64 .