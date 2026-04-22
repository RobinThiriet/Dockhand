.PHONY: up down restart logs update ps validate

up:
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

update:
	./scripts/update.sh

validate:
	docker compose config >/dev/null
	@echo "Configuration Docker Compose valide."
