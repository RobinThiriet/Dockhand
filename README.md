# Dockerhand

Depot d'infrastructure pour deployer Dockerhand via Docker Compose, avec une base propre pour l'exploitation:

- configuration externalisee via `.env`
- sauvegardes locales des donnees
- validation de configuration
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

## Structure

- [`docker-compose.yaml`](./docker-compose.yaml): stack Docker Compose
- [`Makefile`](./Makefile): commandes courantes
- [`scripts/backup.sh`](./scripts/backup.sh): sauvegarde archivee du dossier `data/`
- [`scripts/preflight.sh`](./scripts/preflight.sh): verification avant lancement
- [`docs/operations.md`](./docs/operations.md): exploitation courante
- [`docs/architecture.md`](./docs/architecture.md): schema et flux techniques

## Donnees sensibles

Le dossier `data/` contient la base SQLite et la cle de chiffrement. Il est ignore par git et ne doit pas etre pousse.

## Sauvegardes

```bash
make backup
```

Les archives sont creees dans `backups/`.

## Validation

```bash
make validate
```

## Documentation

- [Guide d'exploitation](./docs/operations.md)
- [Architecture](./docs/architecture.md)
