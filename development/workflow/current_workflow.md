# Current Workflow (Agent-Based)

## Overview

This document describes the **current operational workflow** for the echeckers project, based on the implemented agent roles. This workflow is active and should be followed for all development activities.

---

## Agent Roster

| Agent | Role | Primary Responsibility |
|-------|------|----------------------|
| **Code Agent** | Implementation Specialist | Source code in `game/` directory |
| **Build Agent** | Build System Guardian | Build scripts and configurations |
| **Test Agent** | Validation Specialist | Automated testing and validation |
| **Quality Agent** | Code Quality Guardian | Quality checks and review tracking |
| **Docs Agent** | Documentation Synchronizer | Documentation maintenance |
| **Architect Agent** | Architecture Guardian | Global state and dependencies |
| **Release Agent** | Release Coordinator | Release preparation and deployment |

---

## Workflow States

```
┌─────────────────────────────────────────────────────────────┐
│  Current Workflow State Machine                              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  [IDLE] ──> [DEVELOPMENT] ──> [VALIDATION] ──> [REVIEW]     │
│     ^           |                  |              |          │
│     |           v                  v              v          │
│     |      [CODE_AGENT]      [TEST_AGENT]   [QUALITY_AGENT] │
│     |      [ARCHITECT_AGENT] [BUILD_AGENT]  [DOCS_AGENT]    │
│     |                                  |                     │
│     |                                  v                     │
│     └────────────────────────── [RELEASE_AGENT] ──> [IDLE]  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Active Workflows

### 1. Feature Development Workflow

**Trigger:** New task from `development/TODO_macro.md`

```
┌─────────────────────────────────────────────────────────────┐
│  Step N.M: Feature Implementation                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  PHASE 1: PLANNING                                           │
│  ═════════════════                                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Architect Agent                                       │   │
│  │ - Review feature scope                                │   │
│  │ - Identify global state impact                        │   │
│  │ - Approve architectural changes                       │   │
│  │ - Update .development/global_state.yml                │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ▼                                   │
│  PHASE 2: IMPLEMENTATION                                     │
│  ═══════════════════════                                     │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Code Agent                                            │   │
│  │ - Implement feature in game/                          │   │
│  │ - Add @state-change declarations                      │   │
│  │ - Document public API                                 │   │
│  │ - Run local syntax validation                         │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ▼                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Build Agent                                           │   │
│  │ - Update build_main.txt or build_battle.txt           │   │
│  │ - Verify paths exist                                  │   │
│  │ - Test Bash and PowerShell builds                     │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ▼                                   │
│  PHASE 3: VALIDATION                                         │
│  ════════════════════                                        │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Test Agent                                            │   │
│  │ - Run syntax checks (lua -p)                          │   │
│  │ - Execute unit tests                                  │   │
│  │ - Validate global state consistency                   │   │
│  │ - Run regression tests                                │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ▼                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Quality Agent                                         │   │
│  │ - Run luacheck                                        │   │
│  │ - Check anti-patterns from reviews.md                 │   │
│  │ - Validate naming conventions                         │   │
│  │ - Generate quality report                             │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ▼                                   │
│  PHASE 4: DOCUMENTATION                                      │
│  ════════════════════════                                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Docs Agent                                            │   │
│  │ - Update changelog.md                                 │   │
│  │ - Sync TODO_micro.md                                  │   │
│  │ - Generate API docs                                   │   │
│  │ - Update architecture docs                            │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ▼                                   │
│  PHASE 5: COMMIT                                             │
│  ════════════                                                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Release Agent                                         │   │
│  │ - Verify all gates passed                             │   │
│  │ - Prepare commit message                              │   │
│  │ - Create commit with proper format                    │   │
│  │ - Notify all agents                                   │   │
│  └──────────────────────────────────────────────────────┘   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

**Handoff Sequence:**
```
Architect → Code → Build → Test → Quality → Docs → Release → [Git]
```

---

### 2. Bug Fix Workflow (Hotfix)

**Trigger:** Quality Agent detects issue or user report

```
┌─────────────────────────────────────────────────────────────┐
│  Hotfix: Critical Bug Fix                                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Quality Agent                                            │
│     └─> Identify bug priority (P1-P17)                      │
│     └─> Create issue report                                 │
│                                                              │
│  2. Code Agent                                               │
│     └─> Implement minimal fix                               │
│     └─> Add regression test                                 │
│                                                              │
│  3. Test Agent                                               │
│     └─> Verify fix resolves issue                           │
│     └─> Run regression suite                                │
│                                                              │
│  4. Quality Agent                                            │
│     └─> Fast-track quality check                            │
│     └─> Update reviews.md (mark resolved)                   │
│                                                              │
│  5. Release Agent                                            │
│     └─> Create hotfix commit                                │
│     └─> Tag if patch release needed                         │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

**Handoff Sequence:**
```
Quality → Code → Test → Quality → Release → [Git]
```

---

### 3. Refactoring Workflow

**Trigger:** Technical debt or architectural improvement

```
┌─────────────────────────────────────────────────────────────┐
│  Refactor: Structural Improvement                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Architect Agent                                          │
│     └─> Approve refactoring scope                           │
│     └─> Document expected benefits                          │
│     └─> Update dependency registry                          │
│                                                              │
│  2. Code Agent                                               │
│     └─> Implement refactoring                               │
│     └─> Maintain backward compatibility                     │
│     └─> Update module exports                               │
│                                                              │
│  3. Build Agent                                              │
│     └─> Update all affected paths                           │
│     └─> Verify both build scripts                           │
│     └─> Check file counts                                   │
│                                                              │
│  4. Test Agent                                               │
│     └─> Full regression test suite                          │
│     └─> Performance comparison                              │
│     └─> Validate global state                               │
│                                                              │
│  5. Quality Agent                                            │
│     └─> Comprehensive review                                │
│     └─> Check for new anti-patterns                         │
│     └─> Update quality metrics                              │
│                                                              │
│  6. Docs Agent                                               │
│     └─> Update architecture documentation                   │
│     └─> Document benefits in changelog                      │
│     └─> Update API docs                                     │
│                                                              │
│  7. Architect Agent                                          │
│     └─> Verify structural integrity                         │
│     └─> Approve final state                                 │
│                                                              │
│  8. Release Agent                                            │
│     └─> Create refactoring commit                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

**Handoff Sequence:**
```
Architect → Code → Build → Test → Quality → Docs → Architect → Release → [Git]
```

---

## Global State Change Protocol

### Declaration Format

When any change affects global state, the Code Agent **must** include this declaration:

```lua
-- @state-change
-- GLOBAL: Board
-- CHANGE: Added helper function get_biome()
-- BEFORE: Direct access Board[index]
-- AFTER: BoardModule.get_biome(index)
-- AFFECTED_MODULES:
--   - game/battle/ui/UI.update_board.lua (read)
--   - game/battle/phases/2_standby_phase.lua (read/write)
-- MIGRATION:
--   - Replace Board[index] with BoardModule.get_biome(index)
```

### Validation Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Global State Change Validation                              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Code Agent declares change                                  │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Architect Agent                                       │   │
│  │ - Verify declaration format                           │   │
│  │ - Check affected modules list                         │   │
│  │ - Validate migration path                             │   │
│  │ - Update global_state.yml                             │   │
│  └──────────────────────────────────────────────────────┘   │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Test Agent                                            │   │
│  │ - Validate global state consistency                   │   │
│  │ - Run state transition tests                          │   │
│  │ - Verify no unauthorized access                       │   │
│  └──────────────────────────────────────────────────────┘   │
│         │                                                    │
│         ▼                                                    │
│  ┌──────────────────────────────────────────────────────┐   │
│  │ Quality Agent                                         │   │
│  │ - Check for side effects                              │   │
│  │ - Validate layer boundaries                           │   │
│  └──────────────────────────────────────────────────────┘   │
│         │                                                    │
│         ▼                                                    │
│  APPROVED → Proceed to commit                                │
│  REJECTED → Return to Code Agent with feedback               │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Agent Communication Protocol

### Handoff Message Format

All agent handoffs must use this format:

```
HANDOFF: [Agent Name]
ACTION: [Required action]
[Context-specific fields]
PRIORITY: [critical | high | normal | low]
```

### Priority Levels

| Priority | Response Time | Examples |
|----------|---------------|----------|
| **critical** | Immediate | Build broken, tests failing, security issue |
| **high** | Same session | Missing files, path errors, quality gate failure |
| **normal** | Next development cycle | Documentation updates, new features |
| **low** | When convenient | Style suggestions, minor improvements |

### Notification Channels

```
┌─────────────────────────────────────────────────────────────┐
│  Agent Communication Matrix                                  │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Code Agent ──┬──> Build Agent    (new files, path changes) │
│               ├──> Test Agent     (new API, feature tests)  │
│               ├──> Quality Agent  (code review)             │
│               └──> Docs Agent     (API docs, changelog)     │
│                                                              │
│  Build Agent ─┬──> Test Agent     (build artifacts ready)   │
│               ├──> Quality Agent  (build warnings)          │
│               └──> Release Agent  (artifacts for release)   │
│                                                              │
│  Test Agent ──┬──> Code Agent     (test failures)           │
│               ├──> Quality Agent  (quality metrics)         │
│               └──> Release Agent  (release approval)        │
│                                                              │
│  Quality Agent┬──> Code Agent     (issues to fix)           │
│               ├──> Docs Agent     (reviews.md updates)      │
│               └──> Release Agent  (quality approval)        │
│                                                              │
│  Docs Agent ──┬──> Code Agent     (missing documentation)   │
│               └──> Release Agent  (release notes ready)     │
│                                                              │
│  Architect ───┬──> Code Agent     (architecture violations) │
│  Agent        ├──> Build Agent    (structural changes)      │
│               ├──> Docs Agent     (architecture docs)       │
│               └──> Release Agent  (architecture approval)   │
│                                                              │
│  Release ─────┴──> All Agents    (release notification)     │
│  Agent                                                     │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Current State

### Active Agents

All 7 agents are **ACTIVE** and operational:

- ✅ **Code Agent** - Ready for implementation tasks
- ✅ **Build Agent** - Build system maintained
- ✅ **Test Agent** - Test framework ready
- ✅ **Quality Agent** - Quality checks configured
- ✅ **Docs Agent** - Documentation synchronized
- ✅ **Architect Agent** - Global state registry active
- ✅ **Release Agent** - Release workflow ready

### Global State Registry

**Location:** `.development/global_state.yml`

**Tracked Globals:**
- `Board` - Flat board structure (12 biomes)
- `Player_turn` - Current player (1 or 2)
- `Hands` - Player hand data
- `Deck_p1`, `Deck_p2` - Player decks
- `BUILD`, `MODE`, `SCALE` - Configuration

### Dependency Registry

**Location:** `.development/dependencies.yml`

**Tracked Modules:**
- Core battle loop
- Phase modules
- Board module
- UI components
- Utility functions

### Quality Gates

**Required for all commits:**
1. ✅ Syntax validation (lua -p)
2. ✅ Build success (both Bash and PowerShell)
3. ✅ Unit tests passing
4. ✅ Global state validation
5. ✅ Quality checks (luacheck + anti-patterns)
6. ✅ Documentation updated

---

## Getting Started

### For New Development Sessions

1. **Check TODO files**
   ```bash
   cat development/TODO_macro.md
   cat development/TODO_micro.md
   ```

2. **Review current state**
   ```bash
   cat development/workflow/summary.md
   cat development/workflow/improved_development.md
   ```

3. **Start with Architect Agent approval**
   - Review scope of planned changes
   - Identify global state impact

4. **Follow the workflow**
   - Code → Build → Test → Quality → Docs → Release

### For Bug Fixes

1. **Quality Agent identifies issue**
2. **Code Agent implements fix**
3. **Test Agent validates**
4. **Release Agent commits**

### For Releases

1. **Release Agent coordinates all agents**
2. **Verify all quality gates**
3. **Generate release notes**
4. **Create git tag**
5. **Publish release**

---

## Metrics Dashboard

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Build Success Rate | - | 100% | ⏳ Tracking |
| Test Pass Rate | - | 100% | ⏳ Tracking |
| Quality Score | - | >90/100 | ⏳ Tracking |
| Documentation Sync | - | 100% | ⏳ Tracking |
| Global State Violations | 0 | 0 | ✅ OK |

*Metrics will be populated after first development cycle*

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-31 | Initial workflow definition based on implemented roles |
