FROM registry.access.redhat.com/ubi8/ubi:8.0

MAINTAINER Red Hat Training <training@redhat.com>

# DocumentRoot for Apache
ENV DOCROOT=/var/www/html 

# Install the package inside the container
RUN   yum install -y --nodocs --disableplugin=subscription-manager httpd && \
yum clean all --disableplugin=subscription-manager -y && \
echo "<h1>Hello from the httpd container!</h1>" > ${DOCROOT}/index.html

# Expose to the outside world
EXPOSE 8080

# This stuff is needed to ensure a clean start
RUN rm -rf /run/httpd && mkdir /run/httpd
RUN chgrp -R 0 /var/run/httpd /var/log/httpd && chmod -R g=u /var/run/httpd /var/log/httpd
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf

# Run as the user
USER 1001

# Launch httpd
CMD /usr/sbin/httpd -DFOREGROUND

