"""
@Author : AJDAINI Hatim
@GitHub : https://github.com/Hajdaini
"""
import psutil
import time


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


total_bytes_sent = 0
total_bytes_recv = 0

while True:
    network_info = psutil.net_io_counters()
    total_bytes_sent += network_info.bytes_sent
    total_bytes_recv += network_info.bytes_recv
    stats_before = psutil.net_io_counters()
    time.sleep(1)
    stats_after = psutil.net_io_counters()
    print("bytes_sent = {} | bytes_recv = {} | Speed = {}/s".format(byte_convert(total_bytes_sent), byte_convert(total_bytes_recv), byte_convert(stats_after.bytes_sent - stats_before.bytes_sent)), end='\r')
