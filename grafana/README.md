Grafana Dashboard

Purpose

This dashboard visualizes ICMP reachability metrics collected by Prometheus through Blackbox Exporter.

Data Flow

Grafana → Prometheus → Blackbox Exporter → Target IP addresses

Configure the Data Source

1. Open Grafana.
2. Go to Connections → Data sources.
3. Add or select Prometheus.
4. Enter the Prometheus server URL.
5. Save and test the connection.

Create a Network Reachability Panel

1. Create a dashboard and add a visualization.
2. Select the Prometheus data source.
3. Enter this PromQL query:

probe_success{job="network_icmp"}

4. Select Instant to show the latest collected value.
5. Choose the Table visualization to display targets as separate rows.
6. Ensure no transformation or filter removes the "instance" label.
7. Save the dashboard.

Metric Interpretation

- "1" — the latest ICMP probe succeeded.
- "0" — the latest ICMP probe failed.

A missing result does not necessarily mean the host is down; the target may not be discovered, or the probe or scrape may have failed.

Export the Dashboard

After testing the dashboard:

1. Open the dashboard.
2. Open its menu and choose Export or Download dashboard JSON (wording varies by Grafana version).
3. Review the JSON for internal hostnames, addresses, credentials, or other sensitive details.
4. Save the sanitized export as "grafana/network-ip-dashboard.json" in this repository.

Only commit a dashboard export after confirming that it displays multiple IP addresses correctly.
