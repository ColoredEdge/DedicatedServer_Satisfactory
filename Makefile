.PHONY: all build up down logs install update restart shell backup

BACKUP_DIR := satisfactory_data/backups/$(shell date +%Y%m%d_%H%M%S)

up:
	docker compose up -d

backup:
	@echo "Backing up save files and server configurations..."
	@mkdir -p $(BACKUP_DIR)
	@cp -r satisfactory_data/saves $(BACKUP_DIR)
	@echo "Backup completed at $(BACKUP_DIR)"

install:
	@echo "Starting installation..."
	./setup.sh
	docker compose build
	docker compose run --rm --entrypoint /home/steam/install.sh satisfactory-server

update:
	@echo "Starting update..."
	make backup
	docker compose run --rm --entrypoint /home/steam/install.sh satisfactory-server

build:
	docker compose build

down:
	docker compose down

logs:
	docker compose logs -f

restart:
	docker compose restart

shell:
	docker compose exec -it satisfactory-server /bin/bash
