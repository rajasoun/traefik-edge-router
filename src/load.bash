#!/usr/bin/env bash

## To get all functions : bash -c "source src/load.bash && declare -F"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=dev-tools/src/cli/_docker.bash
source "$SCRIPT_DIR/cli/_docker.bash"
# shellcheck source=dev-tools/src/cli/traefik.bash
source "$SCRIPT_DIR/cli/traefik.bash"
# shellcheck source=dev-tools/src/lib/os.bash
source "$SCRIPT_DIR/lib/os.bash"
# shellcheck source=dev-tools/src/lib/etc_hosts.bash
source "$SCRIPT_DIR/lib/etc_hosts.bash"
# shellcheck source=dev-tools/src/lib/web.bash
source "$SCRIPT_DIR/lib/web.bash"