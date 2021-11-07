#!/usr/bin/env bash

set -eo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=src/load.bash
source "$SCRIPT_DIR/provision/src/load.bash"

function help(){
    echo "Usage: $0  {router|docker}" >&2
    echo
    echo "   router             Manage Mock Service Sandbox"
    echo "   docker             House Keep Docker"
    echo "   debug              Display docker-compose command"
    echo
    return 1
}

export BASE_DOMAIN=cisco.com
export TRAEFIK_DOMAIN=htd-bizapps-monitor

IP="$(get_local_ip)"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILES=$(construct_compose_files "compose.list")

SERVICES=(htd-bizapps-monitor)
API_ENDPOINTS=(dashboard/ metrics web web/health)

export IP
export BASE_DIR
export COMPOSE_FILES
export SERVICES
export API_ENDPOINTS

# export DOCKER_NETWORK=docker-compose_traefik

opt="$1"
choice=$( tr '[:upper:]' '[:lower:]' <<<"$opt" )
case $choice in
    router)     traefik "$@" ;;
    docker)
      check_preconditions
      _docker "$@"
      ;;
    debug)
      echo "export BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)""
      echo "docker-compose $COMPOSE_FILES"
    ;;
    *)  help ;;
esac

