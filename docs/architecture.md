# Architecture

## Vue d'ensemble

```mermaid
flowchart LR
    U[Utilisateur] --> B[Navigateur]
    B --> P[Port hote 3001]
    P --> C[Conteneur Dockerhand]
    C --> D[/var/run/docker.sock]
    C --> V[data/]
    V --> DB[(SQLite)]
    V --> KEY[Cle de chiffrement]
    V --> REPOS[Repos locaux]
    S[Script backup] --> V
    S --> A[(Archives backups/)]
```

## Composants

- `docker-compose.yaml`: declare le service Dockerhand et ses volumes
- `data/`: persistance locale de l'application
- `scripts/backup.sh`: encapsule une sauvegarde complete du volume de donnees
- `Makefile`: simplifie les operations frequentes

## Flux techniques

1. l'utilisateur accede a Dockerhand via le port publie sur l'hote
2. Dockerhand pilote l'environnement local via le socket Docker monte
3. les donnees applicatives restent persistantes dans `./data`
4. les sauvegardes empaquettent ce dossier pour faciliter la restauration
