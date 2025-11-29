---
name: doc-generator
description: Automated documentation generation including JSDoc, API docs, README sections, and ADRs. Activated when creating or updating documentation.
allowed-tools: ['Read', 'Glob', 'Grep']
---

# Documentation Generation Expert

This skill provides templates and guidelines for comprehensive automated documentation generation.

## 📚 Documentation Types

### 1. Code Documentation (JSDoc/TSDoc)

Auto-generate for all public functions:

```typescript
/**
 * Fetch user profile and aggregate related data
 *
 * @description
 * Retrieves user information from database and combines
 * related posts and follower information. Prioritizes cache.
 *
 * @param userId - Unique user identifier (UUID format)
 * @param options - Fetch options
 * @param options.includePosts - Include posts (default: true)
 * @param options.includeFollowers - Include followers (default: false)
 *
 * @returns User profile with related data
 *
 * @throws {UserNotFoundError} When user doesn't exist
 * @throws {DatabaseError} When database connection fails
 *
 * @example
 * ```typescript
 * // Basic usage
 * const profile = await getUserProfile('user-123');
 * console.log(profile.username);
 *
 * // With options
 * const fullProfile = await getUserProfile('user-123', {
 *   includePosts: true,
 *   includeFollowers: true
 * });
 * ```
 *
 * @see {@link updateUserProfile} Update profile
 * @see {@link deleteUser} Delete user
 *
 * @since 2.0.0
 */
```

### 2. API Documentation

Auto-generate endpoint documentation:

```markdown
## API Endpoint: GET /api/users/:id

**Description**: Fetch user profile for specified user ID

**Authentication**: Bearer Token required

**Parameters**:
- `id` (string, required): User ID (UUID format)

**Query Parameters**:
- `include_posts` (boolean, optional): Include posts (default: false)
- `include_followers` (boolean, optional): Include followers (default: false)

**Response**:
\`\`\`json
{
  "id": "user-123",
  "username": "john_doe",
  "email": "john@example.com",
  "posts": [...],      // if include_posts=true
  "followers": [...]   // if include_followers=true
}
\`\`\`

**Error Codes**:
- `404`: User not found
- `401`: Authentication error
- `500`: Server error

**Rate Limiting**: 100 requests per minute

**Example Request**:
\`\`\`bash
curl -H "Authorization: Bearer TOKEN" \\
  "https://api.example.com/api/users/user-123?include_posts=true"
\`\`\`
```

### 3. README Sections

Auto-generate project-specific sections:

```markdown
## Installation

\`\`\`bash
# Using pnpm (recommended)
pnpm install

# Set up environment variables
cp .env.example .env
# Edit .env with required values
\`\`\`

## Usage

\`\`\`typescript
import { getUserProfile } from './api/users';

// Fetch user profile
const profile = await getUserProfile('user-123');
\`\`\`

## Development

\`\`\`bash
# Start development server
pnpm dev

# Run tests
pnpm test

# Run linter
pnpm lint

# Build
pnpm build
\`\`\`

## Testing

\`\`\`bash
# Run all tests
pnpm test

# Run with coverage
pnpm test -- --coverage

# Run specific test file
pnpm test -- user.test.ts

# Watch mode
pnpm test -- --watch
\`\`\`

## Project Structure

\`\`\`
src/
├── api/          # API endpoints
├── components/   # React components
├── lib/          # Utility libraries
├── types/        # TypeScript type definitions
└── utils/        # Helper functions
\`\`\`

## Environment Variables

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `DATABASE_URL` | PostgreSQL connection string | Yes | - |
| `API_KEY` | External API key | Yes | - |
| `PORT` | Server port | No | 3000 |
| `NODE_ENV` | Environment (development/production) | No | development |
```

### 4. Architecture Decision Records (ADRs)

Record important design decisions:

```markdown
# ADR-001: Use TypeScript strict mode

**Date**: 2025-01-15
**Status**: Accepted

## Context

Need to improve type safety and reduce runtime errors.

## Decision

Adopt TypeScript's `strict: true` mode across the project.

## Consequences

### Positive
- Catch null/undefined errors at compile time
- Improved type inference accuracy
- Safer refactoring

### Negative
- Migration time required for existing code
- Steeper learning curve for team

### Mitigation
- Gradual adoption (apply to new code first)
- Team training sessions
- Code review guidelines updated

## Alternatives Considered

1. **Partial strict mode** - Rejected due to inconsistency
2. **Gradual migration** - Accepted as implementation strategy
3. **Keep loose mode** - Rejected due to poor type safety
```

## 🎯 Auto-Generation Rules

Generate documentation automatically when:

1. **New function created**: Add JSDoc/TSDoc
2. **API endpoint added**: Generate API documentation
3. **Important design decision**: Suggest ADR creation
4. **README sections missing**: Generate relevant sections

## 📋 Documentation Checklist

- [ ] All public functions have documentation
- [ ] Examples included
- [ ] Parameters and return values explained
- [ ] Error conditions described
- [ ] Links to related functionality provided
- [ ] Version information (`@since`) included
- [ ] Complex logic has inline comments

## 🚀 Documentation Templates

### Function Documentation Template
```typescript
/**
 * [Brief one-line description]
 *
 * @description
 * [Detailed explanation of business logic and purpose.
 * Multiple lines allowed for complex functions.]
 *
 * @param paramName - [Parameter description]
 * @returns [Return value description]
 * @throws {ErrorType} [When this error occurs]
 *
 * @example
 * ```typescript
 * // [Usage example]
 * const result = functionName(arg);
 * ```
 *
 * @see {@link RelatedFunction} [Related functionality]
 * @since [Version number]
 */
```

### Class Documentation Template
```typescript
/**
 * [Class purpose and responsibility]
 *
 * @description
 * [Detailed explanation of the class design and usage patterns]
 *
 * @example
 * ```typescript
 * const instance = new ClassName(config);
 * instance.method();
 * ```
 *
 * @since [Version number]
 */
export class ClassName {
  /**
   * [Constructor description]
   *
   * @param config - [Configuration object description]
   */
  constructor(config: Config) {
    // Implementation
  }

  /**
   * [Method description]
   *
   * @param param - [Parameter description]
   * @returns [Return value description]
   */
  public method(param: Type): ReturnType {
    // Implementation
  }
}
```

### API Endpoint Template
```markdown
## [METHOD] [Path]

**Description**: [Endpoint purpose]

**Authentication**: [Required auth type]

**Parameters**:
- `param` ([type], [required/optional]): [Description]

**Request Body**:
\`\`\`json
{
  "field": "value"
}
\`\`\`

**Response** ([status code]):
\`\`\`json
{
  "result": "value"
}
\`\`\`

**Error Responses**:
- `[code]`: [Description]

**Example**:
\`\`\`bash
curl -X [METHOD] "[URL]" \\
  -H "Authorization: Bearer TOKEN" \\
  -d '{"field": "value"}'
\`\`\`
```

## 💡 Best Practices

1. **Keep documentation close to code** - Update docs when code changes
2. **Use examples liberally** - Show real usage patterns
3. **Document the "why", not just the "what"** - Explain design decisions
4. **Version your documentation** - Use `@since` tags
5. **Link related items** - Use `@see` for cross-references
6. **Update ADRs when decisions change** - Keep decision history

## 🔍 Documentation Quality

### Good Documentation
- Clear and concise
- Includes examples
- Explains edge cases
- Links to related docs
- Updated regularly

### Poor Documentation
- Repeats code in words
- No examples
- Outdated information
- Broken links
- Missing error cases
