# Observability
## Scale considerations
The choice of observability architecture, tools, and processes depends on the scale of the monitored system, tech stack specifics and organisation size and structure.
I assume the following specs:
- B2C web service, simple single page web app
- served from a single region
- behind a CDN
- running in EKS
- deployed with ArgoCD
- organisation has slight preference for open source over SaaS solutions

## Purpose considerations
Observabiliy data serves different purposes, to name a few:
- status overview: place to go to see how the site is doing
- incident response: tools to inform us when there are problems requiring attention
- prevention: warnings and trends to inform us on coming problems
- scaling automation: metrics ingested by autoscalers to make informed decisions
- cost tracking: optimize cost based on usage data
- optimization: use historical data and trends to find bottlenecks
- troubleshooting: use historical data to find root causes
- release management: observe changes post release to make informed decision
- security: audit logs

It's important to keep "alert fatigue" in mind when designing alerting and incident response

## Storage considerations
Different kinds of observability data may require different retention periods. 
Not all data needs to be accessible at all times. Some data may be retained in cold storage over longer periods.

## Example technical design
All components deployed with operator helm charts or if no operator available standalone helm charts

### Metrics
- collect using Prometheus, Victoria Metrics, OTEL collector or Grafana Alloy
- exporters for kubernetes data plane, especially events and AWS
- Thanos for long term storage
- Grafana for visualization
- for network visibility consider Cillium and Cillium Hubble 
- collect metrics from the CDN
- collect metrics from ArgoCD
- collect metrics from CI if possible
- kubecost for cost tracking

### Logs
- collect using Vector.dev or Grafana Alloy if supported
- aggregate per availability zone
- store and analyze in Grafana Loki

### Traces
- collect with OTEL collector or Grafana Alloy
- use eBPF autoinstrumentation to fill the gaps
- store and visualize in Grafana Tempo

### RUM
- use a SaaS such as NewRelic

### Synthetic Monitoring
- use a SaaS, such as Checkly

### Alerting
- push from Prometheus Alert manager to a SaaS incident management tool such as Opsgenie
- define SLOs, and create alerts using Pyrra
- make sure only items that require immediate attention are sent to on-call


