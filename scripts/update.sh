#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

docker compose -f "${ROOT_DIR}/docker-compose.yaml" pull
docker compose -f "${ROOT_DIR}/docker-compose.yaml" up -d

echo "Mise a jour terminee."
