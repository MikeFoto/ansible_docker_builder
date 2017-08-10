# Simple docker pull and build module
Use it to create  your own images

# Requirements

just [docker_image requirements](http://docs.ansible.com/ansible/latest/docker_image_module.html).

# Usage

Define the Configuration hash some place . Check Examples at defaults.yml.ex

## Configuration Capabilities

```yaml

docker_builder:
  pull:
    base_images:
      centos66:
        name:    centos
        version: "6.6"
      centos69:
        name:    centos
        version: "6.9"
      centoslatest:
        name:    centos
        version: "latest"
      ubuntults:
        name:    ubuntu
        version: "14.04"
  build:
    build_path:   "../tmp"
    images_to_build:
      - image_name: webserver
        build:      True
        base_image:
          name:     centos
          version:  "6.9"
        name:       "{{ docker_builder_aux.img_names.webserver }}"
        repo:       "{{ docker_builder_aux.repo }}"
        tag:        "v0.08"
        files:
          - name:     index1.html
            location: "webserver"
            dst:      /var/www/html/index1.html
            cnt: |
              <h1>
                default index page from ansible (1)
              </h1>
          - name:     index2.html
            location: "webserver"
            dst:      /var/www/html/index2.html
            cnt: |
              <h1>
                default index page from ansible (2)
              </h1>
        script: |
          # httpd
          RUN yum -y  install httpd
          #
          # PHP
          RUN yum -y  install php
          ADD index1.html /var/www/html/index.html
          CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
      - image_name: loadb
        build:      True
        base_image:
          name:     centos
          version:  "latest"
        name:       "{{ docker_builder_aux.img_names.loadb}}"
        repo:       "{{ docker_builder_aux.repo }}"
        tag:        "v0.05"
        files:
          - name:     index3.html
            location: "loadb"
            dst:      /var/www/html/index3.html
            cnt: |
              <h1>
                default index page from ansible (3)
              </h1>
        script: |
          # line 1 of script ( latest )
          # ....
          # last line of script

```


# License

MIT

# Author Information

Created by Miguel Rodrigues.
