# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "docker/map.jinja" import docker with context %}

docker-service:
  service.running:
    - name: {{ docker.service.name }}
    - enable: True
