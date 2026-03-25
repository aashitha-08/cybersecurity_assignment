import subprocess
import platform
import re

# function to ping a single host
def ping_host(host):
    # detect OS (windows / linux / mac)
    system = platform.system().lower()

    # set correct ping command based on OS
    if system == "windows":
        cmd = ["ping", "-n", "4", host]
    else:
        cmd = ["ping", "-c", "4", host]
    #error handling for ping command
    try:
        # run the ping command
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=10)
        output = result.stdout

        # check if host is reachable
        if result.returncode == 0:
            status = "Reachable"
        else:
            status = "Not reachable"

        # extract average response time
        avg_time = get_avg_time(output, system)

        return status, avg_time

    except Exception as e:
        # if something goes wrong
        return "Error", str(e)


# function to extract average ping time using regex
def get_avg_time(output, system):
    if system == "windows":
        # example: Average = 20ms
        match = re.search(r'Average = (\d+)ms', output)
    else:
        # example: rtt min/avg/max/mdev = 10.123/20.456/30.789/...
        match = re.search(r'avg[/=](\d+\.\d+)', output)

    if match:
        return match.group(1) + " ms"
    else:
        return "Not found"


# main portion of the program
if __name__ == "__main__":
    print("=== Ping Scanner ===")

    # ask user if they want multiple hosts
    choice = input("Do you want to scan multiple hosts? (y/n): ")

    # scanning for multiple hosts
    if choice.lower() == "y":
        hosts_input = input("Enter hosts separated by comma: ")
        hosts = hosts_input.split(",")

        print("\nResults:\n")

        # loop through all hosts
        for host in hosts:
            host = host.strip()  # remove extra spaces

            status, time = ping_host(host)

            print("Host:", host)
            print("Status:", status)
            print("Average time:", time)
            

    # scanning for single host
    else:
        host = input("Enter IP or hostname: ")

        status, time = ping_host(host)

        print("\nResult:")
        print("Host:", host)
        print("Status:", status)
        print("Average time:", time)