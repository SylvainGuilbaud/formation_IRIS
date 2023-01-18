import time
start = time.time()
time.sleep(1.001)    # Pause 1 second + 1 millisecond
end = time.time()
print(end - start)