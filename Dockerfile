FROM python:latest
MAINTAINER Manfred Schmid <manfred.schmid@it-schmid.com>
WORKDIR /
COPY entrypoint.sh /entrypoint.sh
COPY pi-uwsgi.ini /pi-uwsgi.ini
COPY privacyideaadm.py /privacyideaadm.py
RUN git clone https://github.com/privacyidea/privacyidea.git && \
pip install -r privacyidea/requirements.txt && \
pip install privacyidea==3.6.3 && \
pip install pymysql-sa PyMySQL uwsgi && \
mkdir -p /etc/privacyidea && \
mkdir -p /var/log/privacyidea && \
mkdir -p /data && \
mkdir -p /scripts && \
chmod a+x /entrypoint.sh && \
rm -r privacyidea

ENV ADMIN_USER=admin
ENV ADMIN_PASSWORD=admin
ENV PI_DBDRIVER=sqlite

VOLUME /etc/privacyidea
VOLUME /data
VOLUME /scripts
VOLUME /var/log/privacyidea
EXPOSE 5001
ENTRYPOINT ["/entrypoint.sh"]


