#!/usr/bin/env sh
set -e

DIR=~/Downloads
MIRROR=https://github.com/up9inc/mizu/releases/download

# https://github.com/up9inc/mizu/releases/download/36.0/mizu_darwin_amd64.sha256

dl()
{
    local app="mizu"
    local ver=$1
    local os=$2
    local arch=$3
    local platform="${os}_${arch}"
    local url=$MIRROR/$ver/${app}_${platform}.sha256
    printf "      # %s\n" $url
    printf "      %s: sha256:%s\n" $platform $(curl -sSLf $url | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver darwin amd64
    dl $ver darwin arm64
    dl $ver linux amd64
    dl $ver linux arm64
    dl $ver windows amd64
}

dl_ver ${1:-36.0}
