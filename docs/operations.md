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
make up-auth
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

## Restauration

La restauration remplace le contenu actuel de `data/` par celui de l'archive choisie.

Commande:

```bash
make restore ARCHIVE=backups/dockhand-data-YYYYMMDD-HHMMSS.tar.gz
```

Le script prend automatiquement une sauvegarde de precaution du dossier `data/` courant avant ecrasement.

## Mode protege optionnel

Ce mode ajoute un conteneur Nginx devant Dockerhand avec authentification HTTP Basic.

1. Generer le fichier d'authentification:

```bash
make auth-file USER_NAME=admin
```

2. Definir `DOCKHAND_BIND_IP=127.0.0.1` dans `.env`

3. Lancer la stack:

```bash
make up-auth
```

Effet attendu:

- Dockerhand reste accessible uniquement en local sur `127.0.0.1:${DOCKHAND_PORT}` si `DOCKHAND_BIND_IP=127.0.0.1`
- les utilisateurs passent par Nginx sur `:${DOCKHAND_GATEWAY_PORT}`
- la suppression de ce mode se fait simplement en arretant la stack et en relancant `make up`

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
- ne jamais committer `secrets/htpasswd`
- conserver la cle `data/.encryption_key` avec les sauvegardes
- limiter l'acces au socket Docker a des machines et utilisateurs de confiance
