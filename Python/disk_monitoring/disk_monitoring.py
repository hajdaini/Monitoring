"""
@Author : AJDAINI Hatim
@GitHub : https://github.com/Hajdaini
"""
import psutil


def byte_convert(n):
    symbols = ('K', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y')
    prefix = {}
    for i, s in enumerate(symbols):
        prefix[s] = 1 << (i + 1) * 10
    for s in reversed(symbols):
        if n >= prefix[s]:
            value = float(n) / prefix[s]
            return '%.1f%s' % (value, s)
    return "%sB" % n

partitions = psutil.disk_partitions()

print("---------------------------------------------------------------------------------")
for p in partitions:
    if p.opts != "cdrom":
        print("Partition {} ({}) | systeme de fichier : {}".format(p.device, p.opts, p.fstype))
        disk_info = psutil.disk_usage(p.mountpoint)
        print("Total = {} | Utilisé = {} | Libre = {} | Pourcentage= {}% utilisé".format(
            byte_convert(disk_info.total), byte_convert(disk_info.used), byte_convert(disk_info.free),
            disk_info.percent))
        print("---------------------------------------------------------------------------------")