#! /bin/sh

LABEL_NAME=$1
CURRENT_VERSION=$2
WORKFLOW_TYPE=$3

version_bump_logic()
{
    label_name=$1
    current_version=$2

    if [ ${label_name} == "major" ]; then
        echo $current_version | awk 'BEGIN { FS="." } { printf "%01d.%01d.%01d\n", ++$1, 0, 0 }'
    elif [ ${label_name} == "minor" ]; then
        echo $current_version | awk 'BEGIN { FS="." } { printf "%01d.%01d.%01d\n", $1, ++$2, 0 }'
    elif [ ${label_name} == "patch" ]; then
        echo $current_version | awk 'BEGIN { FS="." } { printf "%01d.%01d.%01d\n", $1, $2, ++$3 }'
    else
        echo "Pull request assigned a wrong label"
    fi
}

if [ "${WORKFLOW_TYPE}" = "PR" ]; then
    build_number=$(shuf -i 1-100000 -n 1)
    echo "${CURRENT_VERSION}-build${build_number}"
fi

if [ "${WORKFLOW_TYPE}" = "CI" ]; then
    version_bump_logic ${LABEL_NAME} ${CURRENT_VERSION}
fi