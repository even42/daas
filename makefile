start:
	@cd docker && docker-compose -f docker-compose.yml up --build -d

stop:
	@cd docker && docker-compose -f docker-compose.yml stop
