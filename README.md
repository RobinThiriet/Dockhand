# Dockerhand

Depot d'infrastructure pour deployer Dockerhand via Docker Compose, avec une base propre pour l'exploitation:

- configuration externalisee via `.env`
- sauvegardes locales des donnees
- restauration de sauvegarde
- validation de configuration
- mode d'acces protege optionnel via Nginx + Basic Auth
- documentation d'installation et d'exploitation
- schema d'architecture

## Demarrage rapide

1. Copier le fichier d'exemple:

```bash
cp .env.example .env
```

2. Demarrer le service:

```bash
docker compose up -d
```

3. Consulter les logs:

```bash
docker compose logs -f dockhand
```

Dockerhand sera expose sur `http://localhost:3001` par defaut, ou sur le port defini dans `.env`.

## Mode protege optionnel

Un mode additionnel et completement reversible est disponible pour placer Dockerhand derriere un proxy Nginx avec authentification HTTP Basic.

1. Generer le fichier d'authentification:

```bash
./scripts/generate-htpasswd.sh admin
```

2. Dans `.env`, rebinder Dockerhand en local:

```bash
DOCKHAND_BIND_IP=127.0.0.1
```

3. Lancer la stack securisee:

```bash
docker compose -f docker-compose.yaml -f docker-compose.auth.yaml up -d
```

Dans ce mode, l'acces utilisateur passe par Nginx sur `http://localhost:8080` par defaut.

## Structure

- [`docker-compose.yaml`](./docker-compose.yaml): stack Docker Compose
- [`Makefile`](./Makefile): commandes courantes
- [`scripts/backup.sh`](./scripts/backup.sh): sauvegarde archivee du dossier `data/`
- [`scripts/restore.sh`](./scripts/restore.sh): restauration d'une sauvegarde
- [`scripts/generate-htpasswd.sh`](./scripts/generate-htpasswd.sh): creation du mot de passe pour le mode protege
- [`scripts/preflight.sh`](./scripts/preflight.sh): verification avant lancement
- [`docker-compose.auth.yaml`](./docker-compose.auth.yaml): surcouche optionnelle Nginx + Basic Auth
- [`docs/operations.md`](./docs/operations.md): exploitation courante
- [`docs/architecture.md`](./docs/architecture.md): schema et flux techniques

## Donnees sensibles

Le dossier `data/` contient la base SQLite et la cle de chiffrement. Il est ignore par git et ne doit pas etre pousse.

## Sauvegardes

```bash
make backup
```

Les archives sont creees dans `backups/`.

## Restauration

```bash
./scripts/restore.sh backups/dockhand-data-YYYYMMDD-HHMMSS.tar.gz
```

## Validation

```bash
make validate
```

## Documentation

- [Guide d'exploitation](./docs/operations.md)
- [Architecture](./docs/architecture.md)
