Security and Privacy

- Monitor only networks you own or are authorized to administer.
- Never commit passwords, tokens, private keys or credentials.
- Do not publish internal IP inventories, private hostnames or office network details without authorization.
- Review terminal logs and screenshots before uploading.
- Do not commit Prometheus time-series database data.
- Sanitize Grafana dashboard exports before publishing.
- Use least-privilege permissions for services where practical.
- Restrict access to Prometheus, Grafana, Blackbox Exporter and Alertmanager.
- Review firewall rules before exposing monitoring ports.

This repository is an example project. Deployment security depends on the actual environment and configuration.
