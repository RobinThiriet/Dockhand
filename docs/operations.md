# Guide d'exploitation

## Prerequis

- Docker et Docker Compose installes
- acces au socket Docker local `/var/run/docker.sock`
- espace disque suffisant pour `data/` et `backups/`

## Installation initiale

```bash
cp .env.example .env
mkdir -p data/db data/git-repos backups
docker compose up -d
```

## Commandes utiles

```bash
make up
make down
make restart
make logs
make validate
make backup
```

## Sauvegarde

Le script archive l'integralite de `data/` pour conserver:

- la base SQLite
- la cle de chiffrement
- les depots clones localement par l'application

Commande:

```bash
make backup
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

## Points de vigilance

- ne jamais committer `data/` ni `.env`
- conserver la cle `data/.encryption_key` avec les sauvegardes
- limiter l'acces au socket Docker a des machines et utilisateurs de confiance
