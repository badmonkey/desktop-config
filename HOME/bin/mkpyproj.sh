#!/bin/bash

# ${1} project_name
# ${2} git-url

NAME="${1}"

if [ "xx${NAME}xx" == "xxxx" ] ; then
	echo "No project name specified"
	exit -1
fi

VENV_DIR="${HOME}/.virtualenvs/${NAME}"
if [ -e "$VENV_DIR" ] ; then
	echo "Virtual env ${NAME} already exists"
	exit -1
fi


PROJECT_DIR="/opt/projects/${NAME}"

if [ ! -e "$PROJECT_DIR" ] ; then
	mkdir "$PROJECT_DIR"
fi


if [ -e "${PROJECT_DIR}/.git" ] ; then
	echo "Directory appears to already be a git repo"
	exit -1
fi


CLONEURL="${2}"

if [ "xx${CLONEURL}xx" == "xxxx" ] ; then
	echo "No git url specified"
	exit -1
fi

git ls-remote -h "${CLONEURL}" &> /dev/null
if [ $? -ne 0 ] ; then
    echo "URL doesn't appear to be a valid git repository"
	exit -1
fi


source /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv -a "$PROJECT_DIR"  "$NAME"


git clone "${CLONEURL}"  "${PROJECT_DIR}"
cd $PROJECT_DIR

ln -s $VENV_DIR .venv


#workon $NAME
#pip install -U pip
#pip install -e .
