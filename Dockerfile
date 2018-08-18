FROM debian:stretch

WORKDIR /etc/

RUN apt-get -y update && \
	apt-get -y install \
		acl \
		git \
		curl \
		build-essential \
		libsodium-dev \
		libcurl4-openssl-dev \
		libxml2-dev \
		pkg-config \
		adduser \
		debianutils \
		libacl1 \
		libcap2 \
		libmemcached11 \
		libmemcachedutil2 \
		libncurses5 \
		libpam-runtime \
		libpam0g \
		libpcre3 \
		libssl1.0.2 \
		libtinfo5 \
		libwrap0 \
		lsb-base \
		netbase \
		sed \
		ucf \
		zlib1g \
		openssl \
		openbsd-inetd \
		libssl-dev \
		default-libmysqlclient-dev

# Clone ProFTPd version 3.6
RUN git clone https://github.com/proftpd/proftpd.git \
	&& cd proftpd \
	&& git checkout master

# Configure and build ProFTPd with the desired modules
# Modules used:
#	https://htmlpreview.github.io/?https://github.com/Castaglia/proftpd-mod_vroot/blob/master/mod_vroot.html
#	http://www.castaglia.org/proftpd/modules/mod_case.html
#	http://www.proftpd.org/docs/contrib/mod_unique_id.html
#	http://www.proftpd.org/docs/contrib/mod_ban.html
#	http://www.proftpd.org/docs/contrib/mod_tls.html
#	http://www.proftpd.org/docs/contrib/mod_sftp.html
#	http://www.proftpd.org/docs/contrib/mod_sql.html
#	http://www.proftpd.org/docs/contrib/mod_sql_passwd.html
#	http://www.proftpd.org/docs/contrib/mod_sftp_sql.html
#	https://htmlpreview.github.io/?https://github.com/Castaglia/proftpd-mod_aws/blob/master/mod_aws.html
RUN cd proftpd && ./configure --enable-openssl --enable-ctrls \
    --with-includes=/usr/include/libxml2 \
	--with-libraries=/usr/lib \
	--with-modules=mod_tls:mod_sql:mod_sql_mysql \
	&& make \
	&& make install

# setup ftpgroup and ftpuser
RUN groupadd -g 2100 ftpgroup
RUN useradd -g ftpgroup -d /home/ftpusers -s /dev/null -u 2100 ftpuser

# Add log directory and files
RUN mkdir -p /var/log/proftpd && touch /var/log/proftpd/sql.log

# Copy in the proftpd.conf files
COPY config/*.conf /etc/proftpd/

# Make the ftp and cert volumes
VOLUME /var/ftp /var/cert
RUN setfacl -Rbdm g:ftpgroup:rw,u:ftpuser:rw /var/ftp/

EXPOSE 20 21 23 30000-30050

# Environment variable defaults
ENV PROFTPD_DEBUG_LEVEL="1" \
	PROFTPD_REQUIRE_VALID_SHELL="off" \
	PROFTPD_TIMEOUT_NO_TRANSFER="600" \
	PROFTPD_TIMEOUT_STALLED="600" \
	PROFTPD_TIMEOUT_IDLE="600" \
	PROFTPD_MAX_INSTANCES="300"

# Start FTP service
CMD /etc/proftpd/proftpd -n -c /etc/proftpd/proftpd.conf