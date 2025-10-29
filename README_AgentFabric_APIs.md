# Agent Fabric O&G Webinar APIs

This package contains 5 OpenAPI 3.1 specs and a Postman collection for demos.

## Files
- maintenance-api.yaml
- work-order-api.yaml
- procurement-api.yaml
- turnaround-api.yaml
- o2c-api.yaml
- Agent-Fabric-OandG-Webinar-APIs.postman_collection.json
- publish_to_exchange.sh

## Quick Start: Publish to Anypoint Exchange
1. Install the Anypoint CLI v4:
   ```bash
   npm i -g anypoint-cli-v4
   ```

2. Export credentials (or use a .env file and `source` it):
   ```bash
   export ANYPOINT_USERNAME="you@example.com"
   export ANYPOINT_PASSWORD="your-password-or-token"
   export ANYPOINT_ORG_ID="YOUR_ORG_ID"
   export ANYPOINT_BG_ID="YOUR_BUSINESS_GROUP_ID"
   ```

3. Run the script from this folder:
   ```bash
   ./publish_to_exchange.sh
   ```

The script creates or replaces 5 assets in Exchange with labels:
**Agent Fabric**, **Oil & Gas AI**, **A2A**, **MCP**.

## Postman
Import `Agent-Fabric-OandG-Webinar-APIs.postman_collection.json`.
Set an environment variable `access_token` and hit Send.
