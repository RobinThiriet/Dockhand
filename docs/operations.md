# Guide d'exploitation

## Prerequis

- Docker et Docker Compose installes
- acces au socket Docker local `/var/run/docker.sock`
- espace disque suffisant pour `data/`

## Installation initiale

```bash
cp .env.example .env
mkdir -p data/db data/git-repos
docker compose up -d
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

## Mise a jour de version

1. Modifier `DOCKHAND_IMAGE` dans `.env`
2. Valider la configuration:

```bash
make validate
```

3. Redemarrer le service:

```bash
make restart
```

Ou, pour recuperer l'image configuree et recreer automatiquement le service:

```bash
make update
```

## Restriction d'exposition reseau

Par defaut, Dockerhand ecoute sur toutes les interfaces de l'hote.

Pour limiter l'acces a la machine locale uniquement, definir dans `.env`:

```bash
DOCKHAND_BIND_IP=127.0.0.1
```

## Points de vigilance

- ne jamais committer `data/` ni `.env`
- conserver la cle `data/.encryption_key` avec les sauvegardes
- limiter l'acces au socket Docker a des machines et utilisateurs de confiance
