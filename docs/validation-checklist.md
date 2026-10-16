Monitoring Project Validation Checklist

Prometheus

- [ ] Prometheus service starts successfully.
- [ ] Prometheus configuration passes validation.
- [ ] The "network_icmp" job appears on the Targets page.
- [ ] Metrics are returned for multiple target IPs.

Blackbox Exporter

- [ ] Blackbox Exporter service is running.
- [ ] The ICMP module is configured.
- [ ] Probe requests return the expected metrics.
- [ ] Failed probes are investigated before marking a host as down.

Network Discovery

- [ ] The discovery script runs successfully.
- [ ] The generated JSON is valid.
- [ ] The target list contains the expected addresses.
- [ ] The script does not overwrite valid target data after a failed scan.
- [ ] The systemd timer schedules discovery as intended.

Grafana

- [ ] Grafana connects to Prometheus.
- [ ] The time-series panel displays multiple IP addresses.
- [ ] The legend identifies each IP clearly.
- [ ] A table panel displays the latest status for each IP.
- [ ] Dashboard changes are saved.

Security and Documentation

- [ ] No credentials or tokens are committed.
- [ ] Internal network information is sanitized or approved for publication.
- [ ] Screenshots reflect the actual project.
- [ ] Example configurations are clearly labeled.
- [ ] Documentation matches the deployed setup.

Mark an item complete only after testing it.
