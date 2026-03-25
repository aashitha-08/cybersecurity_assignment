import subprocess

# check if nmap is installed on the system
def check_nmap():
    try:
        result = subprocess.run(["nmap", "--version"], capture_output=True, text=True)
        return result.returncode == 0
    except:
        return False


# function to run selected scan
def run_scan(target, choice):
    # choose scan type based on user input
    if choice == "1":
        cmd = ["nmap", "-sn", target]   # host discovery
    elif choice == "2":
        cmd = ["nmap", target]          # basic port scan
    elif choice == "3":
        cmd = ["nmap", "-sV", target]   # service version detection
    elif choice == "4":
        cmd = ["nmap", "-O", target]    # OS detection
    else:
        print("Invalid choice")
        return

    try:
        print("\nScanning... please wait\n")

        # run the command
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=60)

        print("Scan completed!\n")
        print(result.stdout)

    except subprocess.TimeoutExpired:
        print("Scan took too long and was stopped.")
    except Exception as e:
        print("Error:", e)


# main part of the program
if __name__ == "__main__":
    print("=== Nmap Scanner ===")

    # first check if nmap is available
    if not check_nmap():
        print("Nmap is not installed. Please install it first.")
    else:
        print("Nmap is installed\n")

        # take target input
        target = input("Enter target IP or network: ")

        # show menu options
        print("\nSelect scan type:")
        print("1. Host Discovery (-sn)")
        print("2. Port Scan (default)")
        print("3. Service Version Detection (-sV)")
        print("4. OS Detection (-O)")

        choice = input("Enter choice (1-4): ")

        # run selected scan
        run_scan(target, choice)