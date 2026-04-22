.PHONY: preflight up up-auth down restart logs backup restore validate auth-file

preflight:
	./scripts/preflight.sh

up: preflight
	docker compose up -d

up-auth: preflight
	docker compose -f docker-compose.yaml -f docker-compose.auth.yaml up -d

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d

logs:
	docker compose logs -f dockhand

backup:
	./scripts/backup.sh

restore:
	@if [ -z "$(ARCHIVE)" ]; then echo "Usage: make restore ARCHIVE=backups/<archive>.tar.gz"; exit 1; fi
	./scripts/restore.sh "$(ARCHIVE)"

auth-file:
	@if [ -z "$(USER_NAME)" ]; then echo "Usage: make auth-file USER_NAME=<user>"; exit 1; fi
	./scripts/generate-htpasswd.sh "$(USER_NAME)"

validate:
	docker compose config >/dev/null
	docker compose -f docker-compose.yaml -f docker-compose.auth.yaml config >/dev/null
	@echo "Configuration Docker Compose valide."
