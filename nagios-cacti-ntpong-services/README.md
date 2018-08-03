# automatic-monitoring-service

## Description
Script to start/restart/stop/ all services needed for a debian monitoring (nagios3, cacti, ntopng) or to see status of all monitoring services.

## Prerequisites
- Server with Debian (**mine is ubuntu 16.04 lts**) with :
  1. nagios (nrpe and nsca (for windows monitoring)
  2. cacti
  3. ntopng (**mine is downloaded from source https://www.ntop.org/get-started/download/**) 

## How to use it

do it once :
```sh
chmod 755 monitoring
mv monitoring /etc/init.d/
cd /etc/init.d/
update-rc.d monitoring defaults
```

There are different ways to run the script :
```sh
./monitoring start
```
or
```sh
./etc/init.id/monitoring start
```
or
```sh
service monitoring start
```
