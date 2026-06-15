# VineCare — Web App (Backend + Frontend)

This folder will hold the web platform code for VineCare:

- **backend/** — Django microservices (data, notifications, phenology, etc.), deployed on a single AWS EC2 instance with path-based routing (`/data/*`, `/notifications/*`, `/phenology/*`).
- **frontend/** — Web dashboard frontend.

## Status

Not yet added to this repo. Existing backend/frontend code will be moved here in a follow-up.

## Suggested structure (once added)

```
web-app/
├── backend/
│   ├── data_service/
│   ├── notifications_service/
│   ├── phenology_service/
│   └── ...
└── frontend/
    └── ...
```
