all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build all images"
	@echo "   2. make pull             - pull all images"
	@echo "   3. make clean            - remove all images"
	@echo ""

define docker_build
	docker build --tag=$(1)/$(2):$(3) \
		--build-arg http_proxy="${http_proxy}" --build-arg https_proxy="${http_proxy}" \
		$(2)/.
endef

build:
#	$(call docker_build,dmitrizhao,ubuntu-vnc-desktop-base,bionic)
#	$(call docker_build,dmitrizhao,ubuntu-vnc-desktop-wrapper,bionic)
	$(call docker_build,dmitrizhao,ubuntu-vnc-webots,melodic)
	$(call docker_build,dmitrizhao,ubuntu-vnc-ros-webots,melodic)

pull:
	@docker pull dmitrizhao/ubuntu-vnc-desktop-base:bionic
	@docker pull dmitrizhao/ubuntu-vnc-desktop-wrapper:bionic
	@docker pull dmitrizhao/ubuntu-vnc-webots:melodic
	@docker pull dmitrizhao/ubuntu-vnc-ros-webots:melodic

clean:
	@docker rmi -f dmitrizhao/ubuntu-vnc-desktop-base:bionic
	@docker rmi -f dmitrizhao/ubuntu-vnc-desktop-wrapper:bionic
	@docker rmi -f dmitrizhao/ubuntu-vnc-webots:melodic
	@docker rmi -f dmitrizhao/ubuntu-vnc-ros-webots:melodic
