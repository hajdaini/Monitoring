"""
@Author : AJDAINI Hatim
@GitHub : https://github.com/Hajdaini
"""
import psutil
from datetime import datetime


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

memory_info = psutil.virtual_memory()
print("----------------------------------MEMORY STATS----------------------------------")
print("Total={} | Utilisé={} | Libre={} | Pourcentage= {}% utilisé".format(
            byte_convert(memory_info.total), byte_convert(memory_info.used), byte_convert(memory_info.free),
    memory_info.percent))
print("--------------------------------------------------------------------------------")

process = psutil.process_iter()
process_list_with_memory = []
TOP_PROCESS_LIMIT = 5
top_process_counter = 0

# Create a list of process with the right arguments
for p in process:
        process_list_with_memory.append({"name": p.name(), "pid": p.pid, "memory_usage": byte_convert(p.memory_info().rss), "created_time": p.create_time()})

# Sorting the process list with the most memory usage
process_memory_sorted = sorted(process_list_with_memory, key=lambda k: k['memory_usage'], reverse=True)

# printing the top process memory usage
for p in process_memory_sorted:
    if top_process_counter < TOP_PROCESS_LIMIT:
        top_process_counter += 1
        print("[Top {}] Le process '{}' (pid={} et crée le {}) consomme {} de la RAM".format(top_process_counter, p.get("name"), p.get("pid"),  datetime.fromtimestamp(p.get("created_time")).strftime("%Y-%m-%d à %H:%M:%S"), p.get("memory_usage")))
    else:
        top_process_counter = 0
        break
