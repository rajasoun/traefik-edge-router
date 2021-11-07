#!/usr/bin/env bash

set -eo pipefail

function enter() {
  container_name="$3"
  case $container_name in
  traefik)
    echo "Entering /bin/sh session in the traefik container..."
    eval docker-compose  "-f $BASE_DIR/docker-compose/traefik.yml " exec traefik sh
    ;;
  *)
    echo "traefik enter (traefik )"
    ;;
  esac
}

function logs() {
  container_name="$3"
  case $container_name in
  traefik)
    echo "traefik logs "
    eval docker-compose  "${COMPOSE_FILES}" logs -f traefik
    ;;
  all)
    echo "Logs "
    eval docker-compose  "${COMPOSE_FILES}" logs -f
    ;;
  *)
    echo "traefik logs (traefik | all)"
    ;;
  esac
}

function traefik() {
  action="$2"
  case $action in
  up)
    echo "Spinning up Docker Images..."
    echo "If this is your first time starting sandbox this might take a minute..."
    eval docker-compose  "${COMPOSE_FILES}" up -d --build
    add_host_entries
    ;;
  down)
    echo "Stopping sandbox containers..."
    echo "This Will Make All Apps Containers - In Accesible"
    eval docker-compose   "${COMPOSE_FILES}" down -v  --remove-orphans
    remove_host_entries
    docker container prune -f
    ;;
  status)
    echo "Querying sandbox containers status..."
    eval docker-compose "${COMPOSE_FILES}"  ps
    display_app_status
    display_api_status
    ;;
  enter)
    enter "$@"
    ;;
  logs)
    logs "$@"
    ;;
  *)
    cat <<-EOF
sandbox commands:
----------------
  up                                       -> spin up the dev-tools sandbox environment
  down                                     -> tear down the dev-tools sandbox environment
  status                                   -> displays status of  services
  enter (traefik | traefik-fa)             -> enter the specified container
  logs  (traefik | traefik-fa | all)       -> stream logs for the specified container
EOF
    ;;
  esac
}