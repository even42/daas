start:
	@cd docker && docker-compose -f docker-compose-dev.yml up --build -d

start-sync:
	@cd docker && docker-sync start && docker-compose -f docker-compose-dev-sync.yml up --build -d

install: start
	@cd drupal && composer install && cd ../docker

status:
	@cd docker && docker-compose -f docker-compose-dev.yml ps

destroy:
	@cd docker && docker-compose -f docker-compose-dev.yml kill && docker-compose -f docker-compose-dev.yml rm --force

stop:
	@cd docker && docker-compose -f docker-compose-dev.yml stop

stop-sync:
	@cd docker && docker-compose -f docker-compose-dev.yml stop && docker-sync stop

ssh:
	@docker exec -ti hermes_php bash
