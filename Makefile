all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build all images"
	@echo "   2. make pull             - pull all images"
	@echo "   3. make clean            - remove all images"
	@echo ""

build:
	@docker build --tag=dmitrizhao/ubuntu-vnc-desktop-base:bionic \
		--build-arg http_proxy="${http_proxy}" --build-arg https_proxy="${http_proxy}" \
		ubuntu-vnc-desktop-base/.
	@docker build --tag=dmitrizhao/ubuntu-vnc-ros-perception-desktop:melodic \
		--build-arg http_proxy="${http_proxy}" --build-arg https_proxy="${http_proxy}" \
		ubuntu-vnc-ros-perception-desktop/.
	@docker build --tag=dmitrizhao/ubuntu-vnc-ros-webots:melodic \
		--build-arg http_proxy="${http_proxy}" --build-arg https_proxy="${http_proxy}" \
		ubuntu-vnc-ros-webots/.

pull:
	@docker pull dmitrizhao/ubuntu-vnc-desktop-base:bionic
	@docker pull dmitrizhao/ubuntu-vnc-ros-perception-desktop:melodic
	@docker pull dmitrizhao/ubuntu-vnc-ros-webots:melodic

clean:
	@docker rmi -f dmitrizhao/ubuntu-vnc-desktop-base:bionic
	@docker rmi -f dmitrizhao/ubuntu-vnc-ros-perception-desktop:melodic
	@docker rmi -f dmitrizhao/ubuntu-vnc-ros-webots:melodic