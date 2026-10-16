Troubleshooting Guide

1. Prometheus Target Is Down

Check:

- Prometheus service status.
- Prometheus target page at "/targets".
- Blackbox Exporter availability on port "9115".
- Firewall and network connectivity.

2. ICMP Probe Returns 0

Query:

probe_success{job="network_icmp"}

A value of "0" means the latest probe failed. Check routing, host availability, ICMP filtering and exporter logs.

3. IPs Are Missing

- Check the generated target JSON.
- Confirm the file path in Prometheus configuration.
- Check Prometheus configuration and reload status.
- Confirm the target responds to the discovery method.

4. Grafana Shows Only One IP

- Use "probe_success{job="network_icmp"}" without an instance filter.
- Select Instant for a current-status table.
- Use Table visualization.
- Remove transformations that group or discard instances.
- Inspect Query Inspector to confirm the returned labels.

5. Useful Commands

systemctl status prometheus
systemctl status blackbox_exporter
promtool check config /etc/prometheus/prometheus.yml
journalctl -u prometheus --since "15 minutes ago"

Service names can differ depending on installation. Verify the actual unit names on your server.
