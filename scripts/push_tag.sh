#! /bin/sh

VERSION_INFO=$1
GITHUB_TOKEN=$2

git tag -a "$VERSION_INFO" -m "Arch CPP build container : $VERSION_INFO"
git push --tags