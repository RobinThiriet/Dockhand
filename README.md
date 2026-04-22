<h1 align="center">Dockerhand</h1>

<p align="center">
  Stack Docker Compose propre et legere pour deployer Dockerhand avec une base d'exploitation claire.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/Docker_Compose-1D63ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker Compose">
  <img src="https://img.shields.io/badge/SQLite-0F80CC?style=for-the-badge&logo=sqlite&logoColor=white" alt="SQLite">
  <img src="https://img.shields.io/badge/Makefile-1F2328?style=for-the-badge&logo=gnu&logoColor=white" alt="Makefile">
  <img src="https://img.shields.io/badge/Self--Hosted-111827?style=for-the-badge&logo=linux&logoColor=white" alt="Self Hosted">
</p>

---

## Vue d'ensemble

Dockerhand est ici presente comme un depot d'infrastructure simple, maintenable et agreable a exploiter:

- configuration externalisee via `.env`
- mise a jour d'image simplifiee avec `make update`
- validation rapide de la stack avec `make validate`
- exposition reseau configurable via `DOCKHAND_BIND_IP`
- documentation d'exploitation et schema d'architecture inclus

## Demarrage rapide

```bash
cp .env.example .env
mkdir -p data/db data/git-repos
docker compose up -d
```

Application disponible par defaut sur `http://localhost:3001`.

Si tu veux limiter l'exposition a la machine locale uniquement:

```bash
DOCKHAND_BIND_IP=127.0.0.1
```

## Commandes utiles

```bash
make up
make down
make restart
make logs
make ps
make validate
make update
```

## Ce Que Le Depot Contient

| Fichier | Role |
| --- | --- |
| [`docker-compose.yaml`](./docker-compose.yaml) | Service Dockerhand et persistance locale |
| [`.env.example`](./.env.example) | Variables d'environnement de base |
| [`Makefile`](./Makefile) | Commandes d'exploitation courantes |
| [`scripts/update.sh`](./scripts/update.sh) | Pull de l'image puis recreation du service |
| [`docs/operations.md`](./docs/operations.md) | Guide d'exploitation |
| [`docs/architecture.md`](./docs/architecture.md) | Schema et vue technique |

## Architecture

```mermaid
flowchart LR
    U["Utilisateur"] --> B["Navigateur"]
    B --> P["Port hote 3001"]
    P --> C["Conteneur Dockerhand"]
    C --> D["Socket Docker: /var/run/docker.sock"]
    C --> V["Dossier data/"]
    V --> DB["Base SQLite"]
    V --> KEY["Cle de chiffrement"]
    V --> REPOS["Repos locaux"]
```

## Exploitation

### Validation

```bash
make validate
```

### Mise a jour

```bash
make update
```

### Logs

```bash
make logs
```

## Points de vigilance

- ne jamais committer `data/` ni `.env`
- conserver `data/.encryption_key` avec les donnees existantes
- limiter l'acces au socket Docker a des utilisateurs de confiance

## Documentation

- [Guide d'exploitation](./docs/operations.md)
- [Architecture](./docs/architecture.md)
