import socket

target = input("Enter target IP: ")
ports = [21, 22, 80, 443]

results = []

for port in ports:
    s = socket.socket()
    s.settimeout(1)

    result = s.connect_ex((target, port))

    if result == 0:
        status = "OPEN"
    else:
        status = "CLOSED"

    results.append((port, status))
    print(f"Port {port}: {status}")

    s.close()

# Generate HTML report
with open("report.html", "w") as file:
    file.write("<html><body>")
    file.write("<h2>Security Audit Report</h2>")
    file.write(f"<p>Target: {target}</p>")

    for port, status in results:
        file.write(f"<p>Port {port}: {status}</p>")

    file.write("</body></html>")

print("Report generated: report.html") 