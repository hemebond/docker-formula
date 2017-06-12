# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "docker/map.jinja" import docker with context %}

include:
  - docker.install
  - docker.service

extend:
  docker-service:
    service:
      - require:
        - pkg: docker-pkg
