# Simple docker pull and build module

 * Allow to download arbitray number of images from any docker repo
 * Build arbitrary number of images, with configurable script content and arbitrary number of files to upload to the image 

# Requirements

just [docker_image requirements](http://docs.ansible.com/ansible/latest/docker_image_module.html).

# Usage

Define the Configuration hash some place . Check Examples at defaults/main.yml.ex

## Configuration Capabilities

```yaml


docker_builder:
  pull:
    base_images:                                  # List of images to download
      centos68:
        name:    centos                           # image name
        version: "6.8"                            # image version
        docker_host: "unix://var/run/docker.sock" # optional a host to download
                                                  #  an image
      centoslatest:
        name:    centos
        version: "latest"
  build:
    build_path:   "../tmp"                      # Where images are built
    images_to_build:                            # List of images to build
      - image_name: webserver
        build:      True                        # If build is done
        base_image:                             # Base image for this build
          name:     centos
          version:  "6.9"
        name:       MyImage_Name                 # Name to this image
        repo:       My_Repo                      # Repo for this image
        tag:        "v0.08"                      # Image Tag
        files:                                   # File list to be created on
                                                 #  the image
          - name:     index1.html
            location: "webserver"                # local file name
            dst:      /var/www/html/index1.html  # File location on the image
            cnt: |                               # File content
              <h1>
                default index page from ansible (1)
              </h1>
        script: |                       # scrip to be included in the Dockerfile
          # httpd
          RUN yum -y  install httpd
          #
          # PHP
          RUN yum -y  install php
          ADD index1.html /var/www/html/index.html
          CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]

```


# License

MIT

# Author Information

Created by Miguel Rodrigues.
