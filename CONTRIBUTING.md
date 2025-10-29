# Contributing to Agent Fabric Oil & Gas APIs

Thank you for your interest in contributing to the Agent Fabric Oil & Gas APIs project! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues
- Use the [GitHub Issues](https://github.com/msaleme/agent-fabric-oilgas-apis/issues) page to report bugs or request features
- Search existing issues before creating a new one
- Provide detailed information including:
  - Clear description of the issue
  - Steps to reproduce (for bugs)
  - Expected vs actual behavior
  - API specification file affected
  - Environment details

### Submitting Changes

1. **Fork the Repository**
   ```bash
   gh repo fork msaleme/agent-fabric-oilgas-apis
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow the coding standards outlined below
   - Test your changes thoroughly
   - Update documentation as needed

4. **Commit Your Changes**
   ```bash
   git commit -m "feat: add new endpoint for asset monitoring
   
   - Added GET /assets/{id}/monitoring endpoint
   - Includes real-time telemetry data
   - Updated security scopes documentation"
   ```

5. **Push and Create Pull Request**
   ```bash
   git push origin feature/your-feature-name
   gh pr create --title "Add asset monitoring endpoint" --body "Description of changes"
   ```

## 📋 Development Guidelines

### OpenAPI Specification Standards

#### File Structure
```yaml
openapi: 3.1.0
info:
  title: "API Name"
  version: "1.0.0"
  description: "Comprehensive description"
  contact:
    name: "Agent Fabric Team"
    email: "support@agentfabric.com"
  license:
    name: "MIT"
    url: "https://opensource.org/licenses/MIT"

servers:
  - url: "https://api.agentfabric.com/v1"
    description: "Production server"
```

#### Security Implementation
All APIs must include:
```yaml
security:
  - oauth2: [domain:read, domain:write, domain:specific]

components:
  securitySchemes:
    oauth2:
      type: oauth2
      flows:
        clientCredentials:
          tokenUrl: https://auth.agentfabric.com/oauth/token
          scopes:
            domain:read: "Read access to domain data"
            domain:write: "Write access to domain data"
```

#### Standard Components
Include these standard components in all APIs:

```yaml
components:
  headers:
    X-Correlation-Id:
      description: "Unique request correlation identifier"
      schema:
        type: string
        format: uuid
    X-Agent-Context:
      description: "Agent communication context"
      schema:
        $ref: '#/components/schemas/AgentContext'
    X-RateLimit-Remaining:
      description: "Number of requests remaining in current window"
      schema:
        type: integer
    X-Total-Count:
      description: "Total number of items (for paginated responses)"
      schema:
        type: integer

  schemas:
    Error:
      type: object
      required: [code, message, timestamp, correlationId]
      properties:
        code:
          type: string
          description: "Error code"
        message:
          type: string
          description: "Human-readable error message"
        details:
          type: string
          description: "Additional error details"
        timestamp:
          type: string
          format: date-time
        correlationId:
          type: string
          format: uuid

    AgentContext:
      type: object
      required: [sourceAgent, correlationId]
      properties:
        sourceAgent:
          type: string
          description: "Identifier of the source agent"
        targetAgent:
          type: string
          description: "Identifier of the target agent"
        correlationId:
          type: string
          format: uuid
        policies:
          type: array
          items:
            type: string
        priority:
          type: string
          enum: [low, normal, high, critical]
```

#### Health Check Endpoint
Every API must include:
```yaml
paths:
  /health:
    get:
      summary: "Health check endpoint"
      description: "Returns the health status of the API service"
      security: []
      responses:
        "200":
          description: "Service is healthy"
          content:
            application/json:
              schema:
                type: object
                properties:
                  status:
                    type: string
                    enum: [healthy, degraded, unhealthy]
                  version:
                    type: string
                  timestamp:
                    type: string
                    format: date-time
```

### Documentation Standards

#### API Documentation
- Each endpoint must have comprehensive descriptions
- Include realistic examples for all request/response bodies
- Document all possible error responses
- Provide clear parameter descriptions

#### Code Comments
```yaml
# Example of well-documented endpoint
/assets/{assetId}/maintenance:
  get:
    summary: "Retrieve maintenance records for an asset"
    description: |
      Returns a paginated list of maintenance records for the specified asset.
      Includes both scheduled and unscheduled maintenance activities.
      
      **Agent Context**: This endpoint is commonly called by maintenance-agent
      and work-order-agent for maintenance planning and execution.
    parameters:
      - name: assetId
        in: path
        required: true
        description: "Unique identifier for the asset (e.g., 'A-1001')"
        schema:
          type: string
          pattern: '^[A-Z]-\d{4}$'
          example: "A-1001"
```

### Testing Requirements

#### Postman Collection Updates
When adding new endpoints:
1. Add corresponding requests to the Postman collection
2. Include example data and environment variables
3. Test both success and error scenarios
4. Document any special setup requirements

#### Validation
Before submitting:
```bash
# Validate OpenAPI specification
swagger-parser validate your-api.yaml

# Run linting
spectral lint your-api.yaml

# Test with Postman collection
newman run Agent-Fabric-OandG-Webinar-APIs.postman_collection.json
```

## 🏗️ Architecture Principles

### Agent-First Design
- Design APIs for agent-to-agent communication
- Include agent context in all requests
- Support correlation tracking across agent interactions
- Implement proper error handling for automated systems

### Enterprise Standards
- Follow OAuth2 client credentials flow
- Implement granular permission scopes
- Include rate limiting considerations
- Support monitoring and observability

### Consistency
- Use consistent naming conventions
- Follow RESTful principles
- Maintain uniform error response formats
- Apply standard HTTP status codes

## 📊 Version Management

### Semantic Versioning
Follow [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes to API contract
- **MINOR**: New functionality, backward compatible
- **PATCH**: Bug fixes, backward compatible

### API Versioning Strategy
- Use URL versioning: `/v1/`, `/v2/`
- Maintain backward compatibility for at least 2 major versions
- Provide migration guides for breaking changes
- Update version in OpenAPI specification

## 🔍 Code Review Process

### Review Checklist
- [ ] OpenAPI specification is valid
- [ ] All endpoints include proper security
- [ ] Documentation is comprehensive
- [ ] Examples are realistic and helpful
- [ ] Error handling is consistent
- [ ] Agent context is properly implemented
- [ ] Health check endpoint is included
- [ ] Postman collection is updated

### Review Criteria
- **Functionality**: Does it work as intended?
- **Security**: Are security best practices followed?
- **Documentation**: Is it well documented?
- **Consistency**: Does it follow project standards?
- **Testing**: Are there adequate tests/examples?

## 🏷️ Commit Message Format

Use conventional commits:
```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test additions/modifications
- `chore`: Maintenance tasks

Examples:
```
feat(maintenance): add vibration monitoring endpoint

- Added GET /assets/{id}/vibration endpoint
- Includes real-time vibration data
- Updated OAuth2 scopes documentation

Closes #123
```

## 🆘 Getting Help

- **Documentation**: Check existing documentation first
- **Issues**: Search [GitHub Issues](https://github.com/msaleme/agent-fabric-oilgas-apis/issues)
- **Discussions**: Use [GitHub Discussions](https://github.com/msaleme/agent-fabric-oilgas-apis/discussions)
- **Contact**: Reach out to the maintainers

## 📄 License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to Agent Fabric Oil & Gas APIs! 🚀
