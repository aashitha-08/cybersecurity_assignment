import socket
import time

target = input("Enter target IP: ")
ports = input("Enter ports (comma separated): ")

port_list = [int(p) for p in ports.split(",")]

start_time = time.time()

file = open("scan_results.txt", "w")

for port in port_list:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(1)

    result = s.connect_ex((target, port))

    if result == 0:
        output = f"Port {port}: OPEN\n"
    else:
        output = f"Port {port}: CLOSED\n"

    print(output.strip())
    file.write(output)

    s.close()

end_time = time.time()

print(f"\nScan completed in {end_time - start_time:.2f} seconds")

file.close()