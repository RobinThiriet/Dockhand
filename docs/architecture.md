# Architecture

## Vue d'ensemble

```mermaid
flowchart LR
    U[Utilisateur] --> B[Navigateur]
    B --> G[Nginx optionnel]
    B --> P[Port hote 3001]
    G --> C[Conteneur Dockerhand]
    P --> C
    C --> D[/var/run/docker.sock]
    C --> V[data/]
    V --> DB[(SQLite)]
    V --> KEY[Cle de chiffrement]
    V --> REPOS[Repos locaux]
    S[Script backup] --> V
    S --> A[(Archives backups/)]
    R[Script restore] --> V
```

## Composants

- `docker-compose.yaml`: declare le service Dockerhand et ses volumes
- `docker-compose.auth.yaml`: ajoute un proxy Nginx avec Basic Auth en mode optionnel
- `data/`: persistance locale de l'application
- `scripts/backup.sh`: encapsule une sauvegarde complete du volume de donnees
- `scripts/restore.sh`: restaure une archive et protege l'etat courant avant remplacement
- `Makefile`: simplifie les operations frequentes

## Flux techniques

1. l'utilisateur accede a Dockerhand via le port publie sur l'hote
2. Dockerhand pilote l'environnement local via le socket Docker monte
3. les donnees applicatives restent persistantes dans `./data`
4. les sauvegardes empaquettent ce dossier pour faciliter la restauration
5. en mode protege, Nginx devient le point d'entree utilisateur et Dockerhand n'est plus expose publiquement
