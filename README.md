Linux Network IP Reachability Monitoring

A Linux-based network monitoring project using Prometheus, Blackbox Exporter, and Grafana to monitor the ICMP reachability of multiple IP addresses and visualize the results in a dashboard.

Project Overview

This project automates network target discovery and monitors whether configured IP addresses respond to ICMP probes. Prometheus collects and stores the resulting metrics, while Grafana queries Prometheus to visualize network reachability.

The project also uses a discovery script, file-based service discovery, and a systemd timer to refresh the monitored target list automatically.

Architecture

flowchart TD
    A["Network IP Range"] --> B["Network Discovery Script"]
    B --> C["network-icmp.json"]
    C --> D["Prometheus File SD"]
    D --> E["Prometheus"]
    E -->|Scrapes probe metrics| F["Blackbox Exporter"]
    F -->|ICMP probes| G["Target IP Addresses"]
    E --> H["Grafana Dashboard"]
    I["systemd Timer"] --> B

Monitoring flow:

1. The discovery script identifies IP addresses within the configured network range.
2. The script updates the file-based discovery target list.
3. Prometheus reads the target list.
4. Blackbox Exporter performs ICMP probes against the target IP addresses.
5. Prometheus scrapes and stores the probe metrics.
6. Grafana queries Prometheus and visualizes reachability information.

Technology Stack

Technology| Purpose
Linux / Ubuntu| Monitoring server operating system
Prometheus| Metrics collection and time-series storage
Blackbox Exporter| ICMP reachability probes
Grafana| Monitoring dashboards and visualization
Bash| Network discovery automation
JSON| File-based service discovery targets
systemd| Automated execution using a timer
PromQL| Querying monitoring metrics

Services and Ports

Component| Port| Purpose
Prometheus| 9090| Metrics and query interface
Blackbox Exporter| 9115| Probe endpoint
Grafana| 3000| Dashboard interface

Ports are the project's configured defaults and should be verified against the deployed environment.

Key Metric

The main metric used for ICMP reachability monitoring is:

probe_success{job="network_icmp"}

Interpretation:

- "1" — the probe succeeded.
- "0" — the probe failed.

To inspect the latest result for each target, use an Instant query in Grafana. To count results by IP address, use:

count by (instance) (
  probe_success{job="network_icmp"}
)

Example Configuration

The Prometheus scrape job uses Blackbox Exporter and file-based service discovery.

- job_name: "network_icmp"
  metrics_path: /probe
  params:
    module: [icmp]
  file_sd_configs:
    - files:
        - "/etc/prometheus/file_sd/network-icmp.json"
      refresh_interval: 60s
  relabel_configs:
    - source_labels: [__address__]
      target_label: __param_target
    - source_labels: [__param_target]
      target_label: instance
    - target_label: __address__
      replacement: localhost:9115

Adapt this example to your environment. The target file must contain valid file-discovery JSON, and the Blackbox Exporter must have an appropriate ICMP module configured.

Automation

A Bash discovery script and systemd timer are used to refresh the monitored target list periodically.

The discovery script should validate its output before replacing the active target file. Network ranges, permissions, and the minimum-host safety check must be adjusted to the intended environment.

Dashboard

The intended Grafana dashboard includes:

- IP address ("instance")
- ICMP reachability status
- Monitoring job
- Last query or observation time, where appropriate

The dashboard export and screenshots should be added after the table visualization has been verified to display distinct IP addresses correctly.

Troubleshooting

Prometheus returns multiple IP addresses, but Grafana does not display them correctly

1. Confirm that Grafana uses the intended Prometheus data source.
2. Test "probe_success{job="network_icmp"}" in Grafana.
3. Select Instant for a current-status table.
4. Select Table rather than Time series for a list of IP addresses.
5. Inspect the query response and remove unintended transformations or field overrides.
6. Verify that the "instance" label contains distinct target IP addresses.

A target reports "0"

Check network reachability, routing, firewall rules, ICMP permissions, and the Blackbox Exporter logs. A failed probe does not necessarily mean the host is powered off.

Security and Privacy

- Never commit passwords, tokens, credentials, or private keys.
- Do not publish internal network details without authorization.
- Replace real internal IP addresses and domains in example files.
- Review exported Grafana dashboards and configuration files before publishing.
- Do not upload Prometheus data directories, database files, or terminal logs containing sensitive information.

Project Status

The monitoring stack and IP discovery workflow have been configured in a Linux environment. The Grafana visualization is still being finalized to ensure that all monitored IP addresses appear as distinct rows in the reachability table.

Future Improvements

- Finalize the all-IP Grafana table.
- Add alert rules for failed ICMP probes.
- Configure Alertmanager notifications.
- Add additional Blackbox Exporter checks where appropriate.
- Improve discovery error handling and logging.
- Document installation and validation steps.

Learning Outcomes

This project provides hands-on practice with Linux service management, Bash automation, Prometheus scrape configuration, file-based service discovery, relabeling, PromQL, ICMP monitoring, Grafana visualization, and troubleshooting.

Disclaimer

This repository is intended for learning and authorized network monitoring. Adapt all configurations to your own environment and obtain permission before probing networks you do not administer.
