#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARCHIVE_PATH="${1:-}"
DATA_DIR="${ROOT_DIR}/data"
SAFETY_DIR="${ROOT_DIR}/backups/pre-restore"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

if [[ -z "${ARCHIVE_PATH}" ]]; then
  echo "Usage: $0 backups/dockhand-data-YYYYMMDD-HHMMSS.tar.gz" >&2
  exit 1
fi

if [[ ! -f "${ARCHIVE_PATH}" ]]; then
  echo "Archive introuvable: ${ARCHIVE_PATH}" >&2
  exit 1
fi

mkdir -p "${SAFETY_DIR}"

if [[ -d "${DATA_DIR}" ]]; then
  tar -czf "${SAFETY_DIR}/data-before-restore-${TIMESTAMP}.tar.gz" -C "${ROOT_DIR}" data
fi

rm -rf "${DATA_DIR}"
tar -xzf "${ARCHIVE_PATH}" -C "${ROOT_DIR}"

echo "Restauration terminee depuis ${ARCHIVE_PATH}"
echo "Sauvegarde de precaution: ${SAFETY_DIR}/data-before-restore-${TIMESTAMP}.tar.gz"
