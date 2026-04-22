#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker n'est pas installe ou non disponible dans le PATH." >&2
  exit 1
fi

mkdir -p "${ROOT_DIR}/data/db" "${ROOT_DIR}/data/git-repos" "${ROOT_DIR}/backups"

if [[ ! -S /var/run/docker.sock ]]; then
  echo "Le socket Docker /var/run/docker.sock est introuvable." >&2
  exit 1
fi

if [[ ! -f "${ROOT_DIR}/.env" ]]; then
  echo "Fichier .env absent. Copiez .env.example vers .env avant le lancement." >&2
  exit 1
fi

docker compose -f "${ROOT_DIR}/docker-compose.yaml" config >/dev/null

echo "Preflight OK."
