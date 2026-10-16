Installation Overview

This document describes the main deployment stages. Commands and paths must be adapted to the installed service names and environment.

Components

- Prometheus: stores and queries monitoring metrics.
- Blackbox Exporter: probes targets using ICMP.
- Grafana: displays metrics in dashboards.
- Network discovery script: generates the target list.
- systemd timer: schedules discovery.

Deployment Stages

1. Install Prometheus, Blackbox Exporter and Grafana using their official installation instructions.
2. Configure the Blackbox Exporter with an ICMP module.
3. Create the file-based service discovery directory.
4. Configure Prometheus to scrape the Blackbox Exporter.
5. Install and test the discovery script.
6. Configure the systemd service and timer.
7. Validate the configuration before reloading Prometheus.
8. Create and test a Grafana dashboard.

Validation

Check the Prometheus web interface at "/targets" and confirm that the "network_icmp" job is healthy.

Query:

probe_success{job="network_icmp"}

Important

Do not copy example configurations directly into a production server without reviewing paths, permissions, network access and service names.
