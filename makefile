build:
	docker-compose -f docker-compose.yml up --build -d

start:
	docker-compose -f docker-compose.yml up --build -d

stop:
	docker-compose -f docker-compose.yml stop

install: start
	cd app/backend/drupal/ && composer install
#	@docker exec -ti daas_drupal sh -c "cd /var/www/html/daas/backend/drupal/ && composer install"
#	@docker exec -ti daas_nginx sh -c "cd /var/www/html/daas/backend/drupal/  && composer install"
#	@docker exec -ti daas_php sh -c "cd /var/www/html/symfony/ && composer install"
#	@docker exec -ti daas_fontendjs sh -c "cd /var/www/html/ && npm install && npm run build"
