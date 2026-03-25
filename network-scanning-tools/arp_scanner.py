import subprocess
import re

# function to run arp command and get output
def get_arp_table():
    try:
        # execute arp -a
        result = subprocess.run(["arp", "-a"], capture_output=True, text=True)
        return result.stdout
    except Exception as e:
        print("Error running ARP command:", e)
        return ""


# function to extract IP and MAC from output
def parse_arp_output(output):
    entries = []

    # regex pattern-matching for IP and MAC address
    pattern = r'(\d+\.\d+\.\d+\.\d+)[^\n]*?([a-fA-F0-9:-]{17})'

    matches = re.findall(pattern, output)

    # store results as (IP, MAC)
    for match in matches:
        ip = match[0]
        mac = match[1]
        entries.append((ip, mac))

    return entries


# function to display results in table format
def display_table(entries):
    print("\n=== ARP Table ===\n")
    print("IP Address\t\tMAC Address")
    print("-" * 40)

    for ip, mac in entries:
        print(f"{ip}\t{mac}")

    # total count of entries
    print("\nTotal entries:", len(entries))


# main program starts here
if __name__ == "__main__":
    output = get_arp_table()

    if output:
        entries = parse_arp_output(output)
        display_table(entries)
    else:
        print("No data found.")