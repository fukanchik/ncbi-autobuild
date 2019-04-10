#!/bin/bash -x

script=$(readlink -f $0)
script_dir=$(dirname $script)

mkdir shared

DOCKER_IMAGE='${OS}:${DIST}'

echo "FROM ${DOCKER_IMAGE}" > Dockerfile
echo "RUN useradd -s ${SHELL} -u $(id -u) -d ${HOME} ${USER}" >> Dockerfile
echo "RUN usermod -a -G wheel ${USER} || :;\\" >> Dockerfile
echo "    usermod -a -G adm ${USER} || :;\\" >> Dockerfile
echo "    usermod -a -G sudo ${USER} || :;\\" >> Dockerfile
echo "    usermod -a -G mock ${USER} || :" >> Dockerfile
echo "USER ${USER}" >> Dockerfile


echo "Dockerfile:"

cat Dockerfile

mv Dockerfile shared/
cp test.sh build_deb.sh build_rpm.sh shared/

docker build --rm=true --quiet=true -t ${DOCCKER_IMAGE}-for-${USER} shared

docker run --name cxxbuild --rm=true --volume ${PWD}/shared:/home/${USER}/result --workdir /home/${USER}/result --user=${USER} ${DOCKER_IMAGE}-for-${USER} bash -x /home/${USER}/result/build_${PACK}.sh "${PLATFORM}"

