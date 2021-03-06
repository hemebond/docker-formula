# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "docker/map.jinja" import docker with context %}

docker-repo-dependencies:
  pkg.installed:
    - pkgs: {{ docker.dependencies|json }}
    - reload_modules: True

#
# Replacing docker-py with docker module
#
docker-python-module-remove-old:
  pip.removed:
    - name: docker-py

docker-python-module:
  pip.installed:
    - name: docker
    - reload_modules: True

#
# This is the official Docker repo
#
docker-repo:
  pkgrepo.managed:
    - name: deb https://apt.dockerproject.org/repo {{ grains["os"]|lower }}-{{ grains["oscodename"] }} main
    - humanname: {{ grains["os"] }} {{ grains["oscodename"]|capitalize }} Docker Package Repository
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
    - refresh_db: True
    - require_in:
      - pkg: docker-pkg
    - require:
      - pkg: docker-repo-dependencies

docker-pkg:
  pkg.installed:
    - name: {{ docker.pkg }}
