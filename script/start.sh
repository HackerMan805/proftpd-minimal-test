#!/bin/bash
lsof -t
netstat -tulpn

# Start FTP service
/etc/proftpd/proftpd -n -c /etc/proftpd/proftpd.conf