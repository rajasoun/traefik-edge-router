#!/usr/bin/env bash

function check_preconditions() {
  if ! [ -x "$(command -v docker)" ]; then
    echo 'Error: docker is not installed.' >&2
    exit 1
  fi

  if ! [ -x "$(command -v docker-compose)" ]; then
    echo 'Error: docker-compose is not installed.' >&2
    exit 1
  fi
}

# Function requires the services array to be initialized and exported
function execute_action(){
  action=$1
  for service in "${SERVICES[@]}"
  do
    $action "$service.${BASE_DOMAIN}"
  done
}

function construct_compose_files(){
  COMPOSE_FILE_LIST=$1
  COMPOSE_FILES=""
  while IFS= read -r line
  do
    # display $line or do somthing with $line
    if [ ! -z $line ];then
      LINE=" -f $line"
      COMPOSE_FILES=$COMPOSE_FILES$LINE
    fi
  done <"$COMPOSE_FILE_LIST"
  echo $COMPOSE_FILES
}

# Returns the IP or .
function get_local_ip(){
    case "$OSTYPE" in
        darwin*) IP=$(ifconfig en0 | grep inet | grep -v inet6 | cut -d" " -f2)
                 echo "$IP"
                 return 0
                 ;;
        linux*)  IP=$(hostname -I |  cut -d" " -f1)
                 echo "$IP"
                 return 0
                 ;;
        cygwin* | mingw* | msys*)
                IP=$(netstat -rn | grep -w '0.0.0.0' | awk '{ print $4 }')
                 echo "$IP"
                 return 0
                 ;;
        *)echo "unknown: $OSTYPE"
                 return 1
                 ;;
    esac
}
