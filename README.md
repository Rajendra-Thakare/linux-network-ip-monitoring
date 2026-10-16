🚀 Linux Network IP Reachability Monitoring

<p align="center">
  <strong>Automated Network Monitoring with Prometheus, Blackbox Exporter & Grafana</strong>
</p><p align="center">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Ubuntu-orange?style=for-the-badge&logo=linux&logoColor=white" alt="Linux and Ubuntu" />
  <img src="https://img.shields.io/badge/Metrics-Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white" alt="Prometheus" />
  <img src="https://img.shields.io/badge/Monitoring-Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white" alt="Grafana" />
  <img src="https://img.shields.io/badge/Automation-Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white" alt="Bash" />
</p>A Linux-based network monitoring project designed to discover authorized network targets, check their ICMP reachability, and visualize monitoring metrics through Grafana.

The project combines network discovery, Prometheus file-based service discovery, Blackbox Exporter probes, and Grafana dashboards to provide a centralized view of network reachability.

---

📌 Project Overview

Component| Responsibility
Network Discovery Script| Identifies responding hosts in an authorized network range
File-Based Service Discovery| Supplies target IP addresses to Prometheus
Blackbox Exporter| Performs ICMP probes against target IPs
Prometheus| Collects and stores monitoring metrics
Grafana| Visualizes reachability status
systemd Timer| Schedules automatic target discovery

🏗️ Architecture

flowchart TD
    A["Authorized Network Range"] --> B["Bash Discovery Script"]
    B --> C["Target JSON File"]
    C --> D["Prometheus File SD"]
    D --> E["Prometheus Server"]
    E -->|"Probe request"| F["Blackbox Exporter"]
    F -->|"ICMP probe"| G["Target IP Addresses"]
    F -->|"Probe metrics"| E
    E -->|"PromQL queries"| H["Grafana Dashboard"]
    I["systemd Timer"] --> B

    classDef automation fill:#e8f5e9,stroke:#2e7d32,color:#111
    classDef monitoring fill:#e3f2fd,stroke:#1565c0,color:#111
    classDef dashboard fill:#fff3e0,stroke:#ef6c00,color:#111

    class B,C,I automation
    class D,E,F,G monitoring
    class H dashboard

✨ Key Features

- 🔍 Automated discovery of responding network hosts
- 📡 ICMP reachability monitoring through Blackbox Exporter
- 📊 Centralized metric collection using Prometheus
- 📈 Dashboard visualization with Grafana
- ⚙️ Scheduled discovery using systemd timers
- 🧰 PromQL queries for identifying successful and failed probes
- 🛠️ Troubleshooting and configuration documentation

🧰 Technology Stack

Technology| Purpose
Linux / Ubuntu| Monitoring server
Bash| Network discovery automation
Nmap| Host discovery in the example script
Prometheus| Metrics collection and storage
Blackbox Exporter| ICMP reachability checks
Grafana| Dashboards and visualization
JSON| Target configuration
systemd| Service management and scheduling
PromQL| Metrics querying

🔌 Default Service Ports

Service| Port| Purpose
Prometheus| "9090"| Metrics and query interface
Blackbox Exporter| "9115"| Probe endpoint
Grafana| "3000"| Dashboard interface

These are default ports; verify them against the deployed configuration.

📈 Prometheus Queries

1. Current reachability status

probe_success{job="network_icmp"}

- "1" — the latest ICMP probe succeeded.
- "0" — the latest ICMP probe failed.
- No result — the target may not be discovered or the metric may be unavailable.

2. Count monitored probe results

count(probe_success{job="network_icmp"})

3. Count successful probes

sum(probe_success{job="network_icmp"} == 1)

4. Show failed targets

probe_success{job="network_icmp"} == 0

⚙️ Automation Workflow

1. The discovery script scans a configured, authorized network range.
2. Responding hosts are written to a JSON target list.
3. Prometheus reads targets through file-based service discovery.
4. Prometheus requests probes from Blackbox Exporter.
5. Blackbox Exporter performs ICMP checks against the target IPs.
6. Prometheus stores the resulting metrics.
7. Grafana queries Prometheus and presents the results.
8. A systemd timer can schedule repeated discovery runs.

📁 Repository Structure

linux-network-ip-monitoring/
├── README.md
├── LICENSE
├── .gitignore
├── prometheus/
│   ├── prometheus.yml.example
│   └── file_sd/
│       └── network-icmp.json.example
├── scripts/
│   └── network-discovery.sh
├── systemd/
│   ├── network-discovery.service
│   └── network-discovery.timer
├── grafana/
│   └── README.md
└── docs/
    ├── architecture.md
    ├── installation.md
    ├── troubleshooting.md
    ├── promql-queries.md
    └── security.md

This structure describes the planned repository layout. Keep it synchronized with the files actually committed to the repository.

🛠️ Validation and Troubleshooting

Check the Prometheus target page:

http://<monitoring-server>:9090/targets

Check the Blackbox Exporter endpoint:

http://<monitoring-server>:9115/

Useful commands on the Linux monitoring server:

systemctl status prometheus
systemctl status blackbox_exporter
promtool check config /etc/prometheus/prometheus.yml
journalctl -u prometheus --since "15 minutes ago"

Service names can vary depending on the installation. Confirm the actual systemd unit names before using these commands.

🔐 Security Considerations

- Monitor only networks you own or are authorized to administer.
- Do not publish internal IP inventories or confidential network details.
- Never commit passwords, tokens, private keys, or credentials.
- Sanitize configuration files, dashboard exports, logs, and screenshots.
- Restrict access to monitoring interfaces according to your environment.

🗺️ Future Improvements

- Finalize a Grafana table displaying each target as a separate row.
- Add alert rules for failed probes.
- Configure Alertmanager notifications.
- Improve discovery error handling and reporting.
- Add verified dashboard exports and demonstration screenshots.
- Document deployment and validation steps.

👨‍💻 Skills Demonstrated

Linux Administration · Network Troubleshooting · Bash Scripting · Prometheus · Blackbox Exporter · Grafana · PromQL · systemd · JSON Configuration · Monitoring Automation

⚠️ Project Status

This repository documents the monitoring design, configuration examples, and automation workflow. Verify the actual deployment, scheduled discovery, and Grafana dashboard behavior before describing those features as fully operational.

📄 License

Distributed under the MIT License. See "LICENSE" (LICENSE).

---

<p align="center">
  <strong>Linux • Monitoring • Automation • Observability</strong>
</p>
