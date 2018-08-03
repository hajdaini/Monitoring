#!/bin/sh
### BEGIN INIT INFO
# Provides: monitoring
# Required-Start: $local_fs $syslog $network
# Required-Stop: $local_fs $syslog $network
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: Lancer tous les services de supervisions
# Description: Script pour lancer tous les services nécessaire à la supervision pour nagios3, cacti, ntopng
### END INIT INFO

###
# @Author : AJDAINI Hatim
# @GitHub : https://github.com/Hajdaini
###

case "$1" in
    start)
        echo "Starting all services for monitoring"
        service apache2 start
        service mysql start
        service postfix start
        service nagios3 start
        service nagios-nrpe-server start
        service ndoutils start
        echo "Starting nagios service check acceptator daemon: nsca"
        start-stop-daemon --start --quiet --exec $NscaBin -- -c $NscaCfg --daemon
        #service lancé en background
        ntopng -i eth0 -w 3000
        echo "stop"
        echo "All services have been started"
    ;;

    restart)
        echo "Restarting all services for monitoring"
        service apache2 restart
        service mysql restart
        service postfix restart
        service nagios3 restart
        service nagios-nrpe-server restart
        service ndoutils restart
        echo "Restarting nagios service check acceptator daemon: nsca"
        start-stop-daemon --stop --quiet --exec $NscaBin
        start-stop-daemon --start --quiet --exec $NscaBin -- -c $NscaCfg --daemon
        echo "All services have been restarted !!"
        echo "please run 'ps aux | grep ntopng'"
        echo "then you will get the process id and kill it with 'kill 9 id_of_theprocess' "
        echo "then run this 'ntopng -i eth0 -w 3000 &'"
    ;;

    status)
        service apache2 status
        service mysql status
        service postfix status
        service nagios3 status
        service nagios-nrpe-server status
        service ndoutils status
        start-stop-daemon --status
        echo -n "if you dont the see the process ntopng, it mean's that you didnt start ntopng 'ntopng -i eth0 -w 3000' to run ntopng"
        ps aux | grep ntopng
    ;;

    stop)
        echo "Stoping all services for monitoring"
        service apache2 stop
        service mysql stop
        service postfix stop
        service nagios3 stop
        service nagios-nrpe-server stop
        service ndoutils stop
        echo "Stopping nagios service check acceptator daemon: nsca"
        start-stop-daemon --stop --quiet --exec $NscaBin
        echo "All services have been stoppedd BUT !!"
        echo "please run 'ps aux | grep ntopng'"
        echo "then you will get the process id and kill it with 'kill 9 id_of_theprocess' "
    ;;

    *)
        echo 'Usage: /etc/init.d/monitoring {start|restart|stop|status}'
        exit 1
    ;;
esac
