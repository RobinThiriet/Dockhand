#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SECRETS_DIR="${ROOT_DIR}/secrets"
USER_NAME="${1:-}"

if [[ -z "${USER_NAME}" ]]; then
  echo "Usage: $0 <user_name>" >&2
  exit 1
fi

read -rsp "Mot de passe pour ${USER_NAME}: " PASSWORD
echo

mkdir -p "${SECRETS_DIR}"

docker run --rm --entrypoint htpasswd httpd:2.4-alpine -nbB "${USER_NAME}" "${PASSWORD}" > "${SECRETS_DIR}/htpasswd"

echo "Fichier cree: ${SECRETS_DIR}/htpasswd"
