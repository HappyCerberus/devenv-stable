set TAG=20240708

docker manifest create happycerberus/devenv-stable:latest --amend happycerberus/devenv-stable:latest-arm64 --amend happycerberus/devenv-stable:latest-amd64
docker manifest annotate happycerberus/devenv-stable:latest happycerberus/devenv-stable:latest-amd64 --arch amd64
docker manifest annotate happycerberus/devenv-stable:latest happycerberus/devenv-stable:latest-arm64 --arch arm64
docker manifest push happycerberus/devenv-stable:latest

docker manifest create happycerberus/devenv-stable:%TAG% --amend happycerberus/devenv-stable:%TAG%-arm64 --amend happycerberus/devenv-stable:%TAG%-amd64
docker manifest annotate happycerberus/devenv-stable:%TAG% happycerberus/devenv-stable:%TAG%-amd64 --arch amd64
docker manifest annotate happycerberus/devenv-stable:%TAG% happycerberus/devenv-stable:%TAG%-arm64 --arch arm64
docker manifest push happycerberus/devenv-stable:%TAG%