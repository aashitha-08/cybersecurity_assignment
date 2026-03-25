# Network Scanning Automation

## Project Description

This project involves creating simple Python programs to automate basic network scanning tasks using tools like ping, arp, and nmap.


## Tools Used

* Python 3
* subprocess module
* platform module
* re module
* Nmap

## Installation

### Python

Check if Python is installed:

```
python --version
```

If not installed, download it from:
https://www.python.org/



### Nmap

Download and install Nmap from:
https://nmap.org/download.html

For Linux:

```
sudo apt install nmap
```



## How to Run

Open terminal in the project folder and run:

### Ping Scanner

```
python ping_scanner.py
```

### ARP Scanner

```
python arp_scanner.py
```

### Nmap Scanner

```
python nmap_scanner.py
```



## Usage

### Ping Scanner

* Enter an IP address or hostname
* It checks if the host is reachable
* Displays average response time



### ARP Scanner

* Gets the ARP table from the system
* Extracts IP and MAC addresses
* Displays them in a simple table
* Shows total number of entries



### Nmap Scanner

* Enter target IP or network
* Select the scan type from menu
* Displays the scan results



## Screenshots

Output screenshots are added in the `screenshots` folder:

* ping_output.png
* arp_output.png
* nmap_output.png


## Notes

* These programs should only be used on networks you have permission to scan
* Some Nmap scans may need admin/root privileges
* Tested on local system


## Project Structure

```
network-scanning-tools/
│── ping_scanner.py
│── arp_scanner.py
│── nmap_scanner.py
│── README.md
└── screenshots/
    ├── ping_output.png
    ├── arp_output.png
    ├── nmap_output1.png
    ├── nmap_output2.png
    ├── nmap_output3.png
    ├── nmap_output4.png
```


## Conclusion

In this project, basic network scanning tools were automated using Python. It helped in understanding how system commands can be executed from Python and how their outputs can be processed.
