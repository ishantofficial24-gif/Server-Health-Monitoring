# 🖥 Linux Server Health Monitoring Tool

A Bash-based Linux server monitoring tool that collects important system metrics and generates health reports with configurable threshold-based alerts.

---

## ✨ Features

- Monitor CPU Usage
- Monitor RAM Usage
- Monitor Disk Usage
- Display Hostname
- Display Current User
- Display Date & Time
- Display System Uptime
- Display IP Address
- Check SSH Service Status
- Configurable Threshold Limits
- Generate Health Reports
- Maintain Log Files
- Overall Server Health Status
- Exit Codes for Automation

---

## 🛠 Tech Stack

- Linux
- Bash Shell Scripting
- AWK
- Git
- GitHub

---

## 📂 Project Structure

```text
server-health-monitor/
│
├── monitor.sh
├── README.md
├── .gitignore
│
├── config/
│   └── threshold.conf
│
├── logs/
│   └── sample_server.log
│
└── reports/
    └── sample_server_report.txt
```

---

## ⚙ Configuration

Edit the threshold values inside:

```text
config/threshold.conf
```

Example:

```bash
CPU_LIMIT=80
RAM_LIMIT=80
DISK_LIMIT=80
```

---

## 🚀 Run the Project

```bash
chmod +x monitor.sh
./monitor.sh
```

---

## 📸 Sample Output

<img width="657" height="404" alt="image" src="https://github.com/user-attachments/assets/f7817989-7b1e-4fa7-a20e-6d2a397d93fb" />


---

## 📚 What I Learned

- Bash Functions
- AWK
- Configuration Files
- Logging
- Threshold Monitoring
- Linux System Administration
- Git & GitHub

---


##  Author

**Ishant Sharma**

