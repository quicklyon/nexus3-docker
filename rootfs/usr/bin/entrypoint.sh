#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

[ -n "${DEBUG:+1}" ] && set -x

# Load libraries
. /opt/easysoft/scripts/liblog.sh
. /opt/easysoft/scripts/libeasysoft.sh

print_welcome_page

/usr/bin/nohup /bin/bash /usr/bin/fixpass.sh &

exec /opt/sonatype/nexus/bin/nexus run
