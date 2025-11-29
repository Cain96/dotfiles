---
name: github-assets
description: GitHub issue and PR image/asset analysis for implementation planning. Analyzes visual requirements from mockups, diagrams, and screenshots. Activated when working with GitHub issues/PRs.
allowed-tools: ['Bash', 'Read']
---

# GitHub Asset Management Expert

This skill provides guidance on downloading and analyzing GitHub assets (images, mockups, diagrams) to inform technical decisions and implementation planning.

## 🖼️ Image Analysis for Implementation Planning

### Why Analyze GitHub Assets?

When GitHub issues, PRs, or project READMEs contain image links (mockups, diagrams, screenshots), analyzing these visual elements ensures:

- **Complete Context**: All visual requirements captured in implementation
- **Accurate Planning**: Technical decisions based on actual designs
- **Better Communication**: Reference specific visual elements in discussions
- **Reduced Misunderstandings**: Avoid gaps from missing visual context

## 🎯 Implementation Guidelines

### YOU MUST: Download Images Before Planning

**Always download and analyze images before creating implementation plans when**:
- GitHub issues contain mockups or design screenshots
- PRs include visual changes or UI updates
- Project README has architecture diagrams
- Design documents reference external images

### Tool: gh-asset

Use `gh-asset` CLI to download GitHub assets:

```bash
# Install gh-asset
# See: https://github.com/YuitoSato/gh-asset

# Download specific asset
gh-asset download <asset_id> .claude/local/assets

# Download all assets from issue
gh-asset download-issue <issue_number> .claude/local/assets

# Download all assets from PR
gh-asset download-pr <pr_number> .claude/local/assets
```

## 📋 Workflow

### 1. Identify Visual Assets

When reviewing GitHub issues/PRs, check for:
- Screenshots of expected behavior
- UI mockups (Figma, Sketch exports)
- Architecture diagrams
- Flowcharts
- Error screenshots
- Before/after comparisons

### 2. Download Assets

```bash
# Create assets directory
mkdir -p .claude/local/assets

# Download from issue
gh-asset download-issue 123 .claude/local/assets

# Or download specific asset URL
gh-asset download https://user-images.githubusercontent.com/.../image.png .claude/local/assets
```

### 3. Analyze Visual Requirements

For each asset, identify:

**UI Mockups**:
- Layout structure (grid, flexbox, specific dimensions)
- Color schemes and theming
- Typography (fonts, sizes, weights)
- Component hierarchy
- Interactive elements (buttons, inputs, dropdowns)
- Responsive breakpoints
- Spacing and padding

**Architecture Diagrams**:
- System components and their relationships
- Data flow directions
- External dependencies
- Technology stack requirements
- Integration points

**Flowcharts**:
- User journeys and decision trees
- Business logic flow
- Error handling paths
- State transitions

**Screenshots**:
- Current behavior vs expected
- Bug reproduction steps
- Edge cases and error states

### 4. Document Visual Requirements

Create structured notes from visual analysis:

```markdown
## Visual Requirements from Issue #123

### Mockup Analysis (image-1.png)

**Layout**:
- 3-column grid layout
- Left sidebar: 280px fixed width
- Main content: Flexible
- Right sidebar: 320px fixed width

**Components Required**:
- Navigation bar with search
- User profile dropdown
- Notification bell icon
- Card components with shadow

**Interactions**:
- Hover states on cards
- Dropdown menu on profile click
- Search with autocomplete

**Responsive**:
- Mobile: Stack to single column
- Tablet: 2-column layout
- Desktop: 3-column layout

### Architecture Diagram (architecture.png)

**Services**:
- Frontend: React + TypeScript
- API Gateway: Express
- Database: PostgreSQL
- Cache: Redis
- Queue: RabbitMQ

**Data Flow**:
1. User request → API Gateway
2. Gateway → Auth Service
3. Auth Service → Database
4. Response caching in Redis
```

### 5. Reference in Implementation

When implementing, reference specific visual elements:

```typescript
// Implementation based on mockup (image-1.png)
// Left sidebar: 280px as specified in design
const SIDEBAR_WIDTH = 280;

// Card shadow matches mockup specifications
const cardStyles = {
  boxShadow: '0 2px 4px rgba(0,0,0,0.1)', // From mockup
  borderRadius: '8px',                     // From mockup
  padding: '16px',                          // From mockup
};
```

## 🔍 Common Asset Types

### 1. UI Mockups & Designs

**Extract**:
- Exact pixel dimensions
- Color hex codes
- Font families and sizes
- Spacing values
- Border radius values
- Shadow specifications

**Tools to help**:
- Browser DevTools (inspect elements)
- Image editors (measure dimensions)
- Color pickers (extract colors)

### 2. Architecture Diagrams

**Extract**:
- Component names and technologies
- Connection types (HTTP, WebSocket, gRPC)
- Data stores (DB, cache, queue)
- External services
- Security boundaries

### 3. Sequence Diagrams

**Extract**:
- Actor interactions
- Message flow order
- Response patterns
- Error scenarios
- Timeout handling

### 4. Wireframes

**Extract**:
- Page structure
- Navigation flow
- Content hierarchy
- Call-to-action placement

## 💡 Best Practices

1. **Download early** - Get assets before starting implementation
2. **Organize assets** - Use consistent naming and folders
3. **Version control** - Keep asset references in documentation
4. **Update when designs change** - Re-download updated mockups
5. **Reference in code comments** - Link to specific visual elements
6. **Share analysis** - Document visual requirements for team

## 📊 Asset Organization

### Recommended Directory Structure

```
.claude/local/assets/
├── issues/
│   ├── issue-123/
│   │   ├── mockup-login.png
│   │   ├── mockup-dashboard.png
│   │   └── analysis.md
│   └── issue-456/
│       └── error-screenshot.png
├── prs/
│   ├── pr-789/
│   │   ├── before.png
│   │   └── after.png
│   └── pr-101/
│       └── architecture.png
└── designs/
    ├── figma-exports/
    └── wireframes/
```

### Asset Naming Convention

```
<type>-<description>-<version>.<ext>

Examples:
- mockup-login-page-v1.png
- diagram-system-architecture-v2.svg
- screenshot-error-state.png
- wireframe-checkout-flow.pdf
```

## 🎯 Analysis Checklist

Before starting implementation:

- [ ] All referenced images downloaded
- [ ] Visual requirements documented
- [ ] Specific values extracted (colors, dimensions)
- [ ] Component hierarchy identified
- [ ] Responsive behavior defined
- [ ] Interactive elements noted
- [ ] Edge cases from screenshots captured
- [ ] Architecture dependencies mapped

## 🚀 Integration with Development

### Link Assets in Issues

```markdown
## Implementation Plan

Based on mockup analysis (see .claude/local/assets/issues/issue-123/mockup.png):

1. Create 3-column grid layout
2. Implement sidebar navigation (280px width)
3. Add card components with specified shadow
4. Implement responsive breakpoints
```

### Link Assets in PRs

```markdown
## Visual Changes

### Before
![Before](.claude/local/assets/prs/pr-789/before.png)

### After
![After](.claude/local/assets/prs/pr-789/after.png)

### Changes Made
- Updated button colors to match brand guidelines
- Increased spacing between cards (16px → 24px)
- Added hover states as specified in mockup
```

## 🔗 Reference

- [gh-asset GitHub Repository](https://github.com/YuitoSato/gh-asset)
- GitHub API for fetching issue/PR assets
- Image optimization tools
- Design handoff best practices
