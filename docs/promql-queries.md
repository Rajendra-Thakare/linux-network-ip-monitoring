PromQL Queries

1. Current ICMP Status

probe_success{job="network_icmp"}

Returns the latest success metric for each matching target.

2. Count Discovered Probe Results

count(probe_success{job="network_icmp"})

Counts the matching time series returned by Prometheus. It does not guarantee that every intended IP was discovered.

3. Count Successful Probes

sum(probe_success{job="network_icmp"} == 1)

Counts series whose current value is 1.

4. Count Failed Probes

sum(probe_success{job="network_icmp"} == 0)

Counts series whose current value is 0.

5. Show Only Failed Targets

probe_success{job="network_icmp"} == 0

Returns matching targets whose current probe value is zero.

Note

These queries depend on the metric labels and scrape configuration in your environment.
