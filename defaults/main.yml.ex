
docker_builder:
  pull:
    base_images:                                  # List of images to download
      centos68:
        name:    centos                           # image name
        version: "6.8"                            # image version
        docker_host: "unix://var/run/docker.sock" # optional a host to download
                                                  #  an image
  build:
    build_path:   "../tmp"                      # Where images are built
    images_to_build:
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
            location: "webserver"
            dst:      /var/www/html/index1.html               # File location on the image
            cnt: |                                            # File content
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
