### Prerequisites
### Setup minikube if not already installed
```bash
chmod +x init.sh
./init.sh
```
### Assuming Jenkins servers configured with the following
- Jenkin slaves have access to `k8s cluster`
- `yq` - Command-line yaml processor.
- `trivy` - Vulnerability scanner for containers and other artifacts.
- Sensitive data (API_KEY,docker hub) are configured in Jenkins as credentials.

### Docker-hub as image registry
- Using my personal docker hub to store images.
