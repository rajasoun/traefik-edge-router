#!/usr/bin/env bash

function display_url_status(){
    HOST="$1"
    # shellcheck disable=SC1083
    HTTP_STATUS="$(curl -s -o /dev/null -L -w ''%{http_code}'' "https://${HOST}")"
    if [[ "${HTTP_STATUS}" != "200" ]] ; then
        echo "https://${HOST}  -> Down"
    else
        echo "https://${HOST}  -> Up"
    fi
}


function display_app_status(){
    echo "Status"
    execute_action "display_url_status"
}

function display_api_status(){
  for api in "${API_ENDPOINTS[@]}"
  do
    display_url_status "${TRAEFIK_DOMAIN}.${BASE_DOMAIN}/$api"
  done
}
