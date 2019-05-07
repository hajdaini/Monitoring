# Monitoring-powershell

Some powershell scripts to monitor your machine


# How tu use it 

First in your windows machine put the script in this folder ***"C:\Program Files\NSClient++\scripts"*** and in your ***"C:\Program Files\NSClient++\nsclient.ini"*** add those lines :

```
CheckExternalScripts = enabled
[/settings/external scripts/scripts]
mps = cmd /c echo scripts\memory_cpu_processus_check.ps1 $ARG1$ $ARG2$ $ARG3$; exit($lastexitcode) | powershell.exe -command -
```

# memory_cpu_processus_check.ps1

In your centreon/Nagios server :

```
cd /usr/lib/nagios/plugins
./check_nrpe -H YOUR_IP -c mps -a YOUR_IP_AGAIN 98 99
```

**Output Example:**

```
OK: Memory is 68 % used, CPU % is 1 and CPU Queue is  |'Memory'=68% 'CPU'=1%
----CPU---- ':
1)'=0 'Le'=0 'Le procesus'=0 'sqlservr'=0 'utilise'=0 '9.51%'=0 'du'=0 'cpu_____
2)'=0 'Le'=0 'procesus'=0 'w3wp'=0 'utilise'=0 '0.01%'=0 'du'=0 'cpu_____
3)'=0 'Le'=0 'procesus'=0 'w3wp'=0 'utilise'=0 '0.01%'=0 'du'=0 'cpu_____
4)'=0 'Le'=0 'procesus'=0 'tomcat8'=0 'utilise'=0 '0%'=0 'du'=0 'cpu_____
5)'=0 'Le'=0 'procesus'=0 'OWSTIMER'=0 'utilise'=0 '0.02%'=0 'du'=0 'cpu_____
_____
-----RAM----_____
1)'=0 'Le'=0 'procesus'=0 'sqlservr'=0 'utilise'=0 '677.21875'=0 'MB'=0 'de'=0 'la'=0 'RAM_____
2)'=0 'Le'=0 'procesus'=0 'w3wp'=0 'utilise'=0 '352.5546875'=0 'MB'=0 'de'=0 'la'=0 'RAM_____
3)'=0 'Le'=0 'procesus'=0 'w3wp'=0 'utilise'=0 '276.62109375'=0 'MB'=0 'de'=0 'la'=0 'RAM_____
4)'=0 'Le'=0 'procesus'=0 'tomcat8'=0 'utilise'=0 '169.16015625'=0 'MB'=0 'de'=0 'la'=0 'RAM_____
5)'=0 'Le'=0 'procesus'=0 'OWSTIMER'=0 'utilise'=0 '122.53515625'=0 'MB'=0 'de'=0 'la'=0 'RAM_____'
```

# folder_size.ps1

In your centreon/Nagios server :

```shell
cd /usr/lib/nagios/plugins
./check_nrpe -H YOUR_IP -c folder_size -a "your_folder_path"
```

**Output Example:**

```
Espace utilise 23,66 GB |'used'=23.66GB
```
