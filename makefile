start:
	@cd docker && docker-compose -f docker-compose.yml up --build -d

stop:
	@cd docker && docker-compose -f docker-compose.yml stop

install: start
	@cd app/backend/drupal/ && composer install
	@cd app/backend/symfony/ && composer install