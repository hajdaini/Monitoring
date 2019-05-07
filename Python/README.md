## Description
Some python scripts to monitor your machine

# Prerequisites before running the script :

- Install python 3
- Install psutil

  ```shell
  sudo apt-get -y install python3-pip
  pip3 install psutil
  ````

# Disk monitoring

- Indicates the different partitions and their file system of your machine 
- Indicates the total, used, and free disk space of each partition

**Output Example:**

```
---------------------------------------------------------------------------------
Partition C:\ (rw,fixed) | systeme de fichier : NTFS
Total = 930.9G | Utilisé = 154.5G | Libre = 776.4G | Pourcentage= 16.6% utilisé
---------------------------------------------------------------------------------
Partition D:\ (rw,fixed) | systeme de fichier : NTFS
Total = 499.0M | Utilisé = 452.9M | Libre = 46.1M | Pourcentage= 90.8% utilisé
---------------------------------------------------------------------------------
```

# Memory monitoring
- Indicates the total, used, datetime creation and free memory usage
- Indicates top 5 process that use the most memory

**Output Example:**
```
----------------------------------MEMORY STATS----------------------------------
Total=11.9G | Utilisé=5.0G | Libre=6.9G | Pourcentage= 42.1% utilisé
--------------------------------------------------------------------------------
[Top 1] Le process 'chrome.exe' (pid=6396 et crée le 2018-06-12 à 14:11:44) consomme 99.8M de la RAM
[Top 2] Le process 'ShellExperienceHost.exe' (pid=5464 et crée le 2018-06-12 à 13:32:35) consomme 95.4M de la RAM
[Top 3] Le process 'chrome.exe' (pid=7964 et crée le 2018-06-12 à 14:29:20) consomme 95.2M de la RAM
[Top 4] Le process 'svchost.exe' (pid=2504 et crée le 2018-06-12 à 13:32:25) consomme 9.8M de la RAM
[Top 5] Le process 'winlogon.exe' (pid=1076 et crée le 2018-06-12 à 13:32:24) consomme 9.7M de la RAM
```

# CPU monitoring

- Indicates percent cpu used of each logical processor
- Indicates top 5 process that use the most cpu

**Output Example:**

```
----------------------------------------CPU STATS----------------------------------------
Nombre de Processeur logique : 4 
Nombre de coeurs : 2 
-------------------------------------CONSOMMATION CPU-------------------------------------
Processeur logique n°1 : 12.1%
Processeur logique n°2 : 6.2%
Processeur logique n°3 : 9.4%
Processeur logique n°4 : 1.6%
-----------------------------------------------------------------------------------------
[Top 1] Le process 'System Idle Process' (pid=0 et crée le 2018-06-12 à 13:31:57) consomme 80.075% du cpu
[Top 2] Le process 'pycharm64.exe' (pid=7232 et crée le 2018-06-12 à 14:10:06) consomme 5.85% du cpu
[Top 3] Le process 'python.exe' (pid=8208 et crée le 2018-06-12 à 14:40:46) consomme 3.525% du cpu
[Top 4] Le process 'audiodg.exe' (pid=3172 et crée le 2018-06-12 à 13:32:25) consomme 2.725% du cpu
[Top 5] Le process 'VirtualBox.exe' (pid=8364 et crée le 2018-06-12 à 14:23:40) consomme 1.55% du cpu
```

# Networking monitoring

- Indicates in realtime Bytes receive/sent and your networking speed

***Output Example:***

```
bytes_sent = 43.2M | bytes_recv = 1.4G | Speed = 128B/s
```
