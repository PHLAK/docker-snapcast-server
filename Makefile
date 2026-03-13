IMAGE_NAME="phlak/snapcast-server"
SNAPCAST_VERSION="$$(grep 'ARG SNAPCAST_VERSION' Dockerfile | awk -F = '{print $$2}')"
LIBRESPOT_VERSION="$$(grep 'ARG LIBRESPOT_VERSION' Dockerfile | awk -F = '{print $$2}')"

build:
	@docker build --force-rm --pull --tag $(IMAGE_NAME):$(SNAPCAST_VERSION)-$(LIBRESPOT_VERSION) .

purge:
	@docker image rm --force $(IMAGE_NAME):$(SNAPCAST_VERSION)-$(LIBRESPOT_VERSION)
