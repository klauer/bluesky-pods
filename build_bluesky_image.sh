#! /usr/bin/bash
set -e
set -o xtrace


container=$(buildah from bluesky-base)
buildah run $container -- dnf -y install git python3-redis
buildah run $container -- pip3 install ophyd databroker bluesky caproto[standard] jupyter pyzmq nslsii
buildah run $container -- pip3 install git+https://github.com/bluesky/bluesky-adaptive.git@master#egg=bluesky-adaptive
buildah run $container -- pip3 install git+https://github.com/bluesky/bluesky-queueserver.git@master#egg=bluesky-queueserver

buildah run $container -- pip3 uninstall pyepics

buildah unmount $container
buildah commit $container bluesky
