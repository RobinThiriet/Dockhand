#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATA_DIR="${ROOT_DIR}/data"
BACKUP_DIR="${ROOT_DIR}/backups"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
ARCHIVE_PATH="${BACKUP_DIR}/dockhand-data-${TIMESTAMP}.tar.gz"

if [[ ! -d "${DATA_DIR}" ]]; then
  echo "Le dossier ${DATA_DIR} est introuvable." >&2
  exit 1
fi

mkdir -p "${BACKUP_DIR}"

tar -czf "${ARCHIVE_PATH}" -C "${ROOT_DIR}" data

echo "Sauvegarde creee: ${ARCHIVE_PATH}"
