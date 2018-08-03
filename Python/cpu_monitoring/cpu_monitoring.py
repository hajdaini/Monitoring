"""
@Author : AJDAINI Hatim
@GitHub : https://github.com/Hajdaini
"""
import psutil
from datetime import datetime
import threading
from queue import Queue

q = Queue()
process = psutil.process_iter()
process_list_with_memory = []
TOP_PROCESS_NBR = 5
top_process_counter = 0
logical_processor = psutil.cpu_count()


print("----------------------------------------CPU STATS----------------------------------------")
total_process = psutil.cpu_percent(interval=1, percpu=True)
print("Nombre de Processeur logique : {} ".format(logical_processor))
print("Nombre de coeurs : {} ".format(psutil.cpu_count(logical=False)))
print("-------------------------------------CONSOMMATION CPU-------------------------------------")
i = 1
for p in total_process:
    print("Processeur logique n°{} : {}%".format(i, p))
    i += 1
i = 0
print("-----------------------------------------------------------------------------------------")


def cpu_percent_calc(p):
    global process_list_with_memory
    process_list_with_memory.append(
        {"name": p.name(), "pid": p.pid, "cpu_percent": p.cpu_percent(1)/logical_processor, "created_time": p.create_time()})


def threader():
    while True:
        worker = q.get()
        cpu_percent_calc(worker)
        q.task_done()


for x in range(100):
    t = threading.Thread(target=threader)
    t.daemon = True
    t.start()

for p in process:
    q.put(p)

q.join()

process_memory_sorted = sorted(process_list_with_memory, key=lambda k: k['cpu_percent'], reverse=True)

for p in process_memory_sorted:
    if top_process_counter < TOP_PROCESS_NBR:
        top_process_counter += 1
        print("[Top {}] Le process '{}' (pid={} et crée le {}) consomme {}% du cpu".format(
            top_process_counter, p.get("name"), p.get("pid"),
            datetime.fromtimestamp(p.get("created_time")).strftime("%Y-%m-%d à %H:%M:%S"), p.get("cpu_percent")))
    else:
        top_process_counter = 0
        break