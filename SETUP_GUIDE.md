# Agent Fabric O&G APIs - Setup Guide

## Prerequisites
✅ **Anypoint CLI v4** - Already installed
✅ **Publish Script** - Created and ready
✅ **API Improvements** - Applied to maintenance API

## Publishing to Anypoint Exchange

### Step 1: Set Environment Variables
You need to set the following environment variables with your Anypoint Platform credentials:

```bash
export ANYPOINT_PASSWORD="your-password-or-token"
export ANYPOINT_ORG_ID="YOUR_ORG_ID"
export ANYPOINT_BG_ID="YOUR_BUSINESS_GROUP_ID"
```

### Step 2: Find Your Organization and Business Group IDs

#### Option A: Using Anypoint CLI
```bash
# Login first
anypoint-cli-v4 auth login --username msaleme_ogmaf

# List organizations
anypoint-cli-v4 organization list

# List business groups (after selecting org)
anypoint-cli-v4 business-group list --organization-id YOUR_ORG_ID
```

#### Option B: Using Anypoint Platform UI
1. Log into [Anypoint Platform](https://anypoint.mulesoft.com)
2. Go to **Access Management** → **Organization**
3. Copy the **Organization ID** from the URL or page
4. Go to **Business Groups** to find your **Business Group ID**

### Step 3: Run the Publish Script
Once environment variables are set:

```bash
./publish_to_exchange.sh
```

The script will publish all 5 APIs:
- ✅ Maintenance API
- ✅ Work Order Management API  
- ✅ Procurement & Inventory API
- ✅ Turnaround Planning API
- ✅ Order-to-Cash API

## What Gets Published

Each API will be published to Anypoint Exchange with:
- **Username**: `msaleme_ogmaf`
- **Version**: `1.0.0`
- **Classifier**: `oas` (OpenAPI Specification)
- **API Version**: `v1`
- **Labels**: `Agent Fabric`, `Oil & Gas AI`, `A2A`, `MCP`

## Verification

After publishing, you can verify the APIs in:
- **Anypoint Exchange**: https://anypoint.mulesoft.com/exchange/
- Search for "Agent Fabric" or "Oil & Gas AI" labels
- All 5 APIs should appear in your organization's Exchange

## Troubleshooting

### Authentication Issues
```bash
# If you get authentication errors, try logging in first:
anypoint-cli-v4 auth login --username msaleme_ogmaf
```

### Permission Issues
- Ensure your user has **Exchange Contributor** or **Exchange Administrator** permissions
- Verify you have access to the specified Business Group

### API Upload Issues
- Check that all YAML files are valid OpenAPI 3.1 specifications
- Ensure file paths are correct in the current directory

## Next Steps

After successful publishing:

1. **Test APIs in Exchange**
   - Use the built-in API Console to test endpoints
   - Verify examples and documentation

2. **Apply Improvements to Remaining APIs**
   - Use the enhanced `maintenance-api.yaml` as a template
   - Apply same patterns to other 4 APIs

3. **Set Up API Governance**
   - Configure policies in API Manager
   - Set up monitoring and analytics

4. **Update Postman Collection**
   - Fix remaining URL structures
   - Add environment configurations

## Support

For issues with:
- **Anypoint CLI**: Check [MuleSoft Documentation](https://docs.mulesoft.com/anypoint-cli/)
- **Exchange Publishing**: See [Exchange Documentation](https://docs.mulesoft.com/exchange/)
