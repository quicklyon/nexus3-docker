#!/bin/bash

# shellcheck disable=SC1091

[ -n "${DEBUG:+1}" ] && set -x

# https://copyprogramming.com/howto/nexus-admin-password-file-is-missing-in-version-3-28-1#nexus-adminpassword-file-is-missing-in-version-3281

. /opt/easysoft/scripts/liblog.sh

NEW_PASSWORD=${PASSWORD:-nexus4Quick0n}

while ((1))
do
  if [ -f "/nexus-data/.fixdone" ]; then
    break
  fi
  curl -Is http://localhost:8081 | grep HTTP | grep 200
  code=$?
  if [ "$code" == "0" ]; then
    if [ -f "/nexus-data/admin.password" ]; then
      OLD_PASSWORD=$(cat /nexus-data/admin.password)
      curl -ifu admin:"${OLD_PASSWORD}" \
        -XPUT -H 'Content-Type: text/plain' \
        --data "${NEW_PASSWORD}" \
        127.0.0.1:8081/service/rest/v1/security/users/admin/change-password
      echo $? || grep 0 && (
        info "update password done"
        touch /nexus-data/.fixdone
      )
    fi
  fi
  debug "try update password"
  sleep 2
done
