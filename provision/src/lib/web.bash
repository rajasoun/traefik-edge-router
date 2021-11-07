#!/usr/bin/env bash

function display_url_status(){
    local max_secs_run="2"
    HOST="$1"
    # shellcheck disable=SC1083
    HTTP_STATUS="$(curl -s --max-time "${max_secs_run}" -o /dev/null -L -w ''%{http_code}'' "https://${HOST}")"
    case $choice in
      200)  echo "https://${HOST}  -> Up" ;;
        *)  echo "https://${HOST}  -> Down" ;;
    esac
}


function display_app_status(){
    echo ""
    execute_action "display_url_status"
}

function display_api_status(){
  for api in "${API_ENDPOINTS[@]}"
  do
    display_url_status "${TRAEFIK_DOMAIN}.${BASE_DOMAIN}/$api"
  done
}
