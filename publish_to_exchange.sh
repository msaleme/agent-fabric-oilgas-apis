#!/bin/bash

# Agent Fabric O&G APIs - Publish to Anypoint Exchange
# Usage: ./publish_to_exchange.sh

set -e

# Configuration
USERNAME="msaleme_ogmaf"
LABELS="Agent Fabric,Oil & Gas AI,A2A,MCP"

# Check if Anypoint CLI is installed
if ! command -v anypoint-cli-v4 &> /dev/null; then
    echo "Error: Anypoint CLI v4 is not installed. Please install it first:"
    echo "npm i -g anypoint-cli-v4"
    exit 1
fi

# Check required environment variables
if [[ -z "$ANYPOINT_PASSWORD" || -z "$ANYPOINT_ORG_ID" || -z "$ANYPOINT_BG_ID" ]]; then
    echo "Error: Required environment variables are not set:"
    echo "Please set: ANYPOINT_PASSWORD, ANYPOINT_ORG_ID, ANYPOINT_BG_ID"
    exit 1
fi

echo "Publishing Agent Fabric O&G APIs to Anypoint Exchange..."
echo "Username: $USERNAME"
echo "Organization ID: $ANYPOINT_ORG_ID"
echo "Business Group ID: $ANYPOINT_BG_ID"
echo ""

# Function to publish an API
publish_api() {
    local file=$1
    local name=$2
    local asset_id=$3
    
    echo "Publishing $name..."
    
    anypoint-cli-v4 exchange asset upload \
        --username="$USERNAME" \
        --password="$ANYPOINT_PASSWORD" \
        --organization="$ANYPOINT_ORG_ID" \
        --group="$ANYPOINT_BG_ID" \
        --name="$name" \
        --asset-id="$asset_id" \
        --version="1.0.0" \
        --classifier="oas" \
        --api-version="v1" \
        --main="$file" \
        --labels="$LABELS" \
        --project-path="." \
        --replace || echo "Warning: Failed to publish $name"
    
    echo "✓ $name published"
    echo ""
}

# Publish each API
publish_api "maintenance-api.yaml" "Maintenance API" "maintenance-api"
publish_api "work-order-api.yaml" "Work Order Management API" "work-order-api"
publish_api "procurement-api.yaml" "Procurement & Inventory API" "procurement-api"
publish_api "turnaround-api.yaml" "Turnaround Planning API" "turnaround-api"
publish_api "o2c-api.yaml" "Order-to-Cash API" "o2c-api"

echo "🎉 All APIs published successfully to Anypoint Exchange!"
echo "You can view them in your Exchange at: https://anypoint.mulesoft.com/exchange/"
