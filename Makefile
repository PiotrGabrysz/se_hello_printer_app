
.PHONY: test

deps:
	pip install -r requirements.txt; \
	pip install -r test_requirements.txt


test:
	PYTHONPATH=. py.test  --verbose -s

run:
	PYTHONPATH=. FLASK_APP=hello_world flask run

lint:
	flake8 hello_world test

docker_build:
	docker build -t hello-world-printer .


docker_run: docker_build
		docker run \
		--name hello_world_printer-dev \
		-p 5000:5000 \
		-d hello-world-printer

USERNAME=pigabr
TAG=$(USERNAME)/hello-world-printer

docker_push:
		@docker login --username $(USERNAME) --password $${DOCKER_PASSWORD}; \
		docker tag hello-world-printer $(TAG); \
		docker push $(TAG); \
		docker logout;

test_smoke:
		curl --fail 127.0.0.1:5000
