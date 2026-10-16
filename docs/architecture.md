Monitoring Architecture

flowchart TD
    A[Network IP Range] --> B[Network Discovery Script]
    B --> C[File-Based Target List]
    C --> D[Prometheus Service Discovery]
    D --> E[Prometheus]
    E -->|Probe requests| F[Blackbox Exporter]
    F -->|ICMP| G[Target IPs]
    F -->|Probe metrics| E
    E -->|PromQL queries| H[Grafana Dashboard]
    I[systemd Timer] --> B

Data Flow

1. A discovery script generates a list of monitoring targets.
2. Prometheus reads the target list through file-based service discovery.
3. Blackbox Exporter checks each target using ICMP.
4. Prometheus collects and stores the probe metrics.
5. Grafana queries Prometheus and visualizes the results.

Main Metric

"probe_success" indicates whether an ICMP probe succeeded.

- "1": probe succeeded.
- "0": probe failed.
