start:
	docker-compose -f docker-compose.yml up --build -d

stop:
	@cd docker && docker-compose -f docker-compose.yml stop

install: start
	@docker exec -ti daas_php sh -c "cd /var/www/html/backend/drupal/ && composer install"
	@docker exec -ti daas_php sh -c "cd /var/www/html/backend/symfony/ && composer install"
