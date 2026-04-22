.PHONY: preflight up down restart logs backup update ps validate

preflight:
	./scripts/preflight.sh

up: preflight
	docker compose up -d

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d

logs:
	docker compose logs -f dockhand

ps:
	docker compose ps

backup:
	./scripts/backup.sh

update: preflight
	./scripts/update.sh

validate:
	docker compose config >/dev/null
	@echo "Configuration Docker Compose valide."
