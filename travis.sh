#!/bin/bash -x

script=$(readlink -f $0)
script_dir=$(dirname $script)

TRAVIS_REPO_NAME=$(echo $TRAVIS_REPO_SLUG | cut -d '/' -f 2)
DOCKER_REPO=tarantool/build

DOCKER_EXTRA=""

case ${PACK} in
    deb)
        TARANTOOL_IMAGE=${DOCKER_REPO}:${OS}-${DIST}
        DOCKER_EXTRA="RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections"
        ;;
    rpm)
        TARANTOOL_IMAGE=${DOCKER_REPO}:${OS}${DIST}
        ;;
    *)
        echo "Packaging ${PACK} is not supported."
        echo 1
        ;;
esac

mkdir shared

cp "${script_dir}/build_${PACK}.sh" "${script_dir}/test.sh" shared

echo "FROM ${TARANTOOL_IMAGE}" > Dockerfile
echo "RUN useradd -s ${SHELL} -u $(id -u) -d ${HOME} ${USER}" >> Dockerfile
[ -z "${DOCKER_EXTRA}" ] || echo "${DOCKER_EXTRA}" >> Dockerfile
echo "RUN usermod -a -G wheel ${USER} || :;\\" >> Dockerfile
echo "    usermod -a -G adm ${USER} || :;\\" >> Dockerfile
echo "    usermod -a -G sudo ${USER} || :;\\" >> Dockerfile
echo "    usermod -a -G mock ${USER} || :" >> Dockerfile
echo "USER ${USER}" >> Dockerfile


echo "Dockerfile:"

cat Dockerfile

mv Dockerfile shared/
cp test.sh build_deb.sh build_rpm.sh shared/

docker build --rm=true --quiet=true -t ${TARANTOOL_IMAGE}-for-${USER} shared

docker run --volume ${PWD}/shared:/home/${USER}/result --workdir /home/${USER}/result --rm=true --user=${USER} ${TARANTOOL_IMAGE}-for-${USER} bash -x /home/${USER}/result/build_${PACK}.sh "${PLATFORM}"

