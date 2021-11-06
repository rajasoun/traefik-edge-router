#!/usr/bin/env bash

set -eo pipefail
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=src/load.bash
source "$SCRIPT_DIR/src/load.bash"

export BASE_DOMAIN=cisco.com
export TRAEFIK_DOMAIN=htd-bizapps-monitor

IP="$(get_local_ip)"
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMPOSE_FILES=$(construct_compose_files "apps/apps.list")
echo "docker-compose $COMPOSE_FILES"

SERVICES=(htd-bizapps-monitor)
API_ENDPOINTS=(dashboard/ metrics health)

export IP
export BASE_DIR
export COMPOSE_FILES
export SERVICES
export API_ENDPOINTS

# export DOCKER_NETWORK=docker-compose_traefik

opt="$1"
choice=$( tr '[:upper:]' '[:lower:]' <<<"$opt" )
case $choice in
  up)
    echo "Spinning up Docker Images..."
    echo "If this is your first time starting sandbox this might take a minute..."
    eval docker-compose  "${COMPOSE_FILES}" up -d --build
    ;;
  down)
    echo "Stopping sandbox containers..."
    eval docker-compose   "${COMPOSE_FILES}" down -v  --remove-orphans
    docker container prune -f
    ;;
  status)
    echo "Querying sandbox containers status..."
    display_app_status
    display_api_status
    eval docker-compose "${COMPOSE_FILES}"  ps
    ;;
  logs)
    eval docker-compose "${COMPOSE_FILES}"  logs -f
    ;;
  *)
    cat <<-EOF
apps commands:
----------------
  up        -> spin up the dev-tools sandbox environment
  down      -> tear down the dev-tools sandbox environment
  status    -> displays status of  services
  logs      -> stream logs for the specified container
EOF
    ;;
esac

