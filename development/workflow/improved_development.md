# Improved Development Workflow with Agent-Based CI/CD

## Overview

This document proposes an improved development workflow that leverages specialized agents for different aspects of the CI/CD pipeline while maintaining separation of concerns and accounting for global state side effects.

---

## Current Challenges

### 1. Manual Verification Burden
- Build testing requires manual execution
- Code review findings tracked in static documents
- No automated regression detection

### 2. Global State Coupling
- Changes to `Board` structure affect multiple modules
- Phase changes impact battle loop and turn management
- Build configuration changes require cross-platform testing

### 3. Documentation Drift
- TODO files not always synchronized with code
- Changelog updates can be forgotten
- Architecture documentation may lag behind implementation

### 4. Cross-Platform Gaps
- Bash and PowerShell scripts can diverge
- No automated testing on both platforms
- Path resolution issues discovered late

---

## Proposed Agent Roles

### Agent Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    Development Workflow                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐       │
│  │   Code       │  │   Build      │  │   Test       │       │
│  │   Agent      │  │   Agent      │  │   Agent      │       │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘       │
│         │                 │                 │                │
│         └────────────────┼─────────────────┘                │
│                          │                                  │
│                  ┌───────▼────────┐                         │
│                  │   Global State │                         │
│                  │   Registry     │                         │
│                  └───────┬────────┘                         │
│                          │                                  │
│  ┌──────────────┐  ┌─────┴────────┐  ┌──────────────┐       │
│  │   Docs       │  │   Release    │  │   Quality    │       │
│  │   Agent      │  │   Agent      │  │   Agent      │       │
│  └──────────────┘  └──────────────┘  └──────────────┘       │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Agent Definitions

### 1. Code Agent (`code-agent`)

**Responsibility:** Source code modifications in `game/` directory

**Capabilities:**
- Implement features in battle modules
- Refactor existing code
- Fix bugs identified by Quality Agent
- Update module exports and imports

**Constraints:**
- Cannot modify `development/build_systems/` directly
- Must declare global state changes in commit metadata
- Must run local syntax validation before handoff

**Global State Declaration:**
```lua
-- @global-changes
-- MODIFIED: Board (structure change: nested -> flat)
-- ADDED: BoardModule.biome_index()
-- AFFECTS: UI.update_board, Validation, Phases
```

**Handoff Triggers:**
- New files created → Build Agent
- Import paths changed → Build Agent
- Public API changed → Test Agent, Docs Agent

---

### 2. Build Agent (`build-agent`)

**Responsibility:** Build system maintenance and validation

**Capabilities:**
- Update `build_main.txt` and `build_battle.txt`
- Maintain Bash and PowerShell build scripts
- Verify file discovery and path resolution
- Generate build statistics (file count, line count)

**Constraints:**
- Cannot modify `game/` source files
- Must keep Bash and PowerShell in sync
- Must validate paths exist before committing

**Build Configuration Validation:**
```bash
# Pre-commit checklist
□ All files in build config exist
□ No circular dependencies
□ Path resolution works from project root
□ Both Bash and PowerShell produce same output
□ Build outputs go to game/ folder
```

**Handoff Triggers:**
- Build fails → Code Agent (missing dependencies)
- Path errors → Code Agent (moved files)
- New warnings → Quality Agent

---

### 3. Test Agent (`test-agent`)

**Responsibility:** Automated testing and validation

**Capabilities:**
- Run build and capture output
- Execute Lua syntax checks
- Validate global state consistency
- Run unit tests for core functions
- Check for review findings resolution

**Test Categories:**

| Category | Checks | Frequency |
|----------|--------|-----------|
| Syntax | Lua parser validation | Every commit |
| Build | File counts, warnings | Every commit |
| Unit | Core function tests | Every feature |
| Integration | Phase transitions | Every release |
| Regression | Known bug patterns | Every commit |

**Global State Validation:**
```lua
-- Test: Board structure consistency
function test_board_integrity()
    BoardModule.init()
    
    -- Verify flat structure
    assert(#Board.biomes == 12, "Board should have 12 biomes")
    
    -- Verify helper functions
    assert(BoardModule.biome_index(1, 1) == 7, "P1 slot 1 = index 7")
    assert(BoardModule.biome_index(2, 1) == 1, "P2 slot 1 = index 1")
    
    -- Verify no circular references
    local copy = Utils.table.copy(Board)
    assert(copy ~= nil, "Board copy should succeed")
end
```

**Handoff Triggers:**
- Test failures → Code Agent
- Missing tests → Code Agent
- Performance regressions → Code Agent
- Documentation gaps → Docs Agent

---

### 4. Docs Agent (`docs-agent`)

**Responsibility:** Documentation maintenance and synchronization

**Capabilities:**
- Update `changelog.md` from commit messages
- Synchronize TODO files with code state
- Generate architecture diagrams
- Extract function signatures for API docs
- Update `reviews.md` with new findings

**Documentation Rules:**
1. Every code change must have changelog entry
2. TODO completion must be verified against code
3. Architecture changes must update `project_architecture.md`
4. New public functions need documentation

**Auto-Generation:**
```markdown
<!-- Auto-generated from commit 8d8d19f -->
## [Unreleased] - Step 8

### Changed
- **Project Structure** - Source code separated from development files
  - `game/` - Runtime source code
  - `development/` - Build tools and documentation

### Files Modified
- `development/build_systems/build_system` (path resolution)
- `development/build_systems/build.ps1` (path resolution)
- `development/build_systems/build_main.txt` (paths prefixed with game/)
```

**Handoff Triggers:**
- Missing documentation → Code Agent
- Outdated architecture → Architect Agent
- Incomplete changelog → Release Agent

---

### 5. Quality Agent (`quality-agent`)

**Responsibility:** Code quality and review automation

**Capabilities:**
- Run luacheck or similar linters
- Check for anti-patterns from `reviews.md`
- Validate naming conventions
- Detect circular reference risks
- Identify missing nil checks

**Quality Checks:**

| Priority | Check | Action |
|----------|-------|--------|
| 1 | Input system calls correct function | Block commit |
| 2 | Turn switching logic exists | Block commit |
| 3 | Git state is clean | Block commit |
| 4 | No circular references in table.copy | Block commit |
| 5 | String replacement doesn't double-escape | Block commit |
| 6 | Consistent return values | Warn |
| 7-14 | Medium priority issues | Track in reviews.md |
| 15-17 | Low priority issues | Suggest |

**Review Automation:**
```lua
-- Automated review checks
quality_checks = {
    {
        name = "input_system",
        pattern = "UI%.input%(%).*_TUI_display%(%)",
        replacement = "UI.input(...).*_TUI_input()",
        priority = 1
    },
    {
        name = "circular_reference",
        pattern = "function.*table%.copy.*seen",
        required = true,
        priority = 4
    },
    {
        name = "nil_check",
        pattern = "if not %w+ then return end",
        min_occurrences = 5,
        priority = 7
    }
}
```

**Handoff Triggers:**
- Critical issues found → Code Agent
- Review findings → Docs Agent (update reviews.md)
- Quality gate passed → Release Agent

---

### 6. Release Agent (`release-agent`)

**Responsibility:** Release preparation and deployment

**Capabilities:**
- Verify all quality gates passed
- Generate release notes from changelog
- Create git tags
- Prepare build artifacts
- Update version numbers

**Release Checklist:**
```
□ All tests passing (Test Agent)
□ Quality gates passed (Quality Agent)
□ Documentation complete (Docs Agent)
□ Build outputs generated (Build Agent)
□ Changelog updated for release
□ Version numbers incremented
□ Git tag created
```

**Release Notes Generation:**
```markdown
## Release v0.8.0 - Step 8

### Summary
Separated source code from development files for cleaner deployment.

### Changes
- Created game/ folder for all runtime source code
- Created development/ folder for build tools
- Updated build system path resolution

### Build Outputs
- game/processed_script.lua (350 lines)
- game/battle/processed_battle.lua (2500 lines)

### Contributors
- Vit0rg <vgois032@gmail.com>
- Qwen-Coder <qwen-coder@alibabacloud.com>
```

**Handoff Triggers:**
- Release blocked → respective agent
- Release complete → notify all agents

---

### 7. Architect Agent (`architect-agent`)

**Responsibility:** Architecture oversight and global state registry

**Capabilities:**
- Maintain global state registry
- Track module dependencies
- Validate architectural constraints
- Approve structural changes
- Update architecture documentation

**Global State Registry:**
```yaml
# .development/global_state.yml
globals:
  Board:
    type: table
    structure: flat_array
    size: 12
    accessed_by:
      - battle/ui/UI.update_board.lua
      - battle/phases/0_setup.lua
      - battle/phases/2_standby_phase.lua
      - battle/validation/2_standby_validation.lua
    modified_by:
      - battle/board/board.lua
      - battle/board/biomes.lua
  
  Player_turn:
    type: number
    values: [1, 2]
    accessed_by:
      - battle/battle.lua
      - battle/phases/*.lua
    modified_by:
      - battle/battle.lua  # TODO: implement turn switching

  Hands:
    type: table
    structure: player_indexed
    accessed_by:
      - battle/ui/UI.update_hand.lua
      - battle/functions/draw_card.lua
    modified_by:
      - battle/functions/draw_card.lua
      - battle/phases/2_standby_phase.lua
```

**Dependency Tracking:**
```yaml
# .development/dependencies.yml
modules:
  battle/battle.lua:
    depends_on:
      - settings/configuration.lua
      - battle/phases/0_setup.lua
      - battle/phases/1_draw_phase.lua
      - battle/phases/2_standby_phase.lua
      - battle/phases/3_battle_phase.lua
      - battle/phases/4_end_phase.lua
  
  battle/ui/UI.update_board.lua:
    depends_on:
      - battle/board/board.lua
      - battle/board/biomes.lua
      - ui/functions/tui_colors.lua
```

**Handoff Triggers:**
- Architecture violation → Code Agent
- Missing dependency declaration → Code Agent
- Structural change detected → Docs Agent

---

## Workflow Orchestration

### Standard Development Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Step N: Feature Implementation                              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Architect Agent                                          │
│     └─> Approve feature scope and global state impact       │
│                                                              │
│  2. Code Agent                                               │
│     └─> Implement feature in game/                          │
│     └─> Declare global state changes                        │
│                                                              │
│  3. Build Agent                                              │
│     └─> Update build configurations                         │
│     └─> Verify cross-platform compatibility                 │
│                                                              │
│  4. Test Agent                                               │
│     └─> Run syntax, build, and unit tests                   │
│     └─> Validate global state consistency                   │
│                                                              │
│  5. Quality Agent                                            │
│     └─> Run quality checks                                  │
│     └─> Update reviews.md                                   │
│                                                              │
│  6. Docs Agent                                               │
│     └─> Update changelog, TODOs, architecture               │
│                                                              │
│  7. Architect Agent                                          │
│     └─> Verify architectural compliance                     │
│                                                              │
│  8. Release Agent                                            │
│     └─> Prepare commit with all artifacts                   │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Hotfix Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Hotfix: Critical Bug Fix                                    │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Quality Agent                                            │
│     └─> Identify bug from reviews.md or test failure        │
│                                                              │
│  2. Code Agent                                               │
│     └─> Implement fix                                       │
│     └─> Minimal scope change                                │
│                                                              │
│  3. Test Agent                                               │
│     └─> Verify fix resolves issue                           │
│     └─> Check for regressions                               │
│                                                              │
│  4. Quality Agent                                            │
│     └─> Fast-track quality check                            │
│                                                              │
│  5. Release Agent                                            │
│     └─> Create hotfix commit                                │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Refactoring Flow

```
┌─────────────────────────────────────────────────────────────┐
│  Refactor: Structural Improvement                            │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  1. Architect Agent                                          │
│     └─> Approve refactoring scope                           │
│     └─> Document expected benefits                          │
│                                                              │
│  2. Code Agent                                               │
│     └─> Implement refactoring                               │
│     └─> Maintain backward compatibility during transition   │
│                                                              │
│  3. Build Agent                                              │
│     └─> Update all affected paths                           │
│     └─> Verify both build scripts                           │
│                                                              │
│  4. Test Agent                                               │
│     └─> Full regression test suite                          │
│     └─> Performance comparison                              │
│                                                              │
│  5. Quality Agent                                            │
│     └─> Comprehensive review                                │
│     └─> Check for new anti-patterns                         │
│                                                              │
│  6. Docs Agent                                               │
│     └─> Update architecture documentation                   │
│     └─> Document benefits in changelog                      │
│                                                              │
│  7. Architect Agent                                          │
│     └─> Verify structural integrity                         │
│                                                              │
│  8. Release Agent                                            │
│     └─> Create refactoring commit                           │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## CI/CD Pipeline Integration

### GitHub Actions Example

```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Lua
        uses: leafo/gh-actions-lua@v8
        with:
          luaVersion: "5.4"
      
      - name: Run Build Agent
        run: |
          ./development/build_systems/build_system
      
      - name: Upload Build Artifacts
        uses: actions/upload-artifact@v3
        with:
          name: build-output
          path: |
            game/processed_script.lua
            game/battle/processed_battle.lua

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Lua
        uses: leafo/gh-actions-lua@v8
      
      - name: Run Test Agent
        run: |
          lua development/tests/run_tests.lua
      
      - name: Validate Global State
        run: |
          lua development/tests/validate_globals.lua

  quality:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Quality Agent
        run: |
          luarocks install luacheck
          luacheck game/ --config development/.luacheck
      
      - name: Check Reviews.md
        run: |
          lua development/checks/review_checks.lua

  docs:
    needs: [build, test, quality]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Docs Agent
        run: |
          lua development/docs/sync_docs.lua
      
      - name: Verify Documentation
        run: |
          test -f development/changelog.md
          test -f development/project_architecture.md

  release:
    needs: [build, test, quality, docs]
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Release Agent
        run: |
          lua development/release/prepare_release.lua
      
      - name: Create Release
        uses: softprops/action-gh-release@v1
        with:
          files: |
            game/processed_script.lua
            game/battle/processed_battle.lua
```

---

## Global State Change Protocol

### Declaration Format

When any agent modifies global state, it must declare changes:

```lua
-- @state-change
-- GLOBAL: Board
-- CHANGE: Structure modified (nested -> flat array)
-- BEFORE: Board.biomes[player][index]
-- AFTER:  Board[index] (flat, 1-12)
-- AFFECTED_MODULES:
--   - battle/ui/UI.update_board.lua (read)
--   - battle/phases/0_setup.lua (write)
--   - battle/phases/2_standby_phase.lua (read/write)
--   - battle/validation/2_standby_validation.lua (read)
-- MIGRATION:
--   - Update all Board.biomes[p][i] to Board[biome_index(p, i)]
--   - Remove Board.layout references
--   - Add helper functions for index mapping
```

### Validation Rules

1. **No Silent Changes**: All global modifications must be declared
2. **Impact Analysis**: Affected modules must be listed
3. **Migration Path**: Changes must include migration steps
4. **Backward Compatibility**: Breaking changes require major version bump
5. **Registry Update**: Global state registry must be updated

### Approval Workflow

```
Code Agent declares change
         ↓
Architect Agent reviews impact
         ↓
Test Agent validates migration
         ↓
Quality Agent checks for issues
         ↓
Release Agent commits with metadata
```

---

## Implementation Roadmap

### Phase 1: Foundation (Week 1-2)
- [ ] Create agent role definitions in `roles/` folder
- [ ] Set up global state registry format
- [ ] Implement basic Test Agent scripts
- [ ] Create Quality Agent check definitions

### Phase 2: Automation (Week 3-4)
- [ ] Implement Build Agent validation scripts
- [ ] Create Docs Agent auto-generation tools
- [ ] Set up CI/CD pipeline skeleton
- [ ] Define handoff protocols

### Phase 3: Integration (Week 5-6)
- [ ] Connect agents in workflow orchestration
- [ ] Implement Architect Agent registry
- [ ] Create Release Agent automation
- [ ] Test full development cycle

### Phase 4: Optimization (Week 7-8)
- [ ] Add performance monitoring
- [ ] Implement parallel agent execution
- [ ] Create agent communication protocol
- [ ] Document agent usage patterns

---

## Metrics and KPIs

| Metric | Target | Measurement |
|--------|--------|-------------|
| Build Success Rate | >99% | Build Agent logs |
| Test Coverage | >80% | Test Agent reports |
| Quality Gate Pass | 100% | Quality Agent checks |
| Documentation Sync | <1 commit lag | Docs Agent audit |
| Global State Violations | 0 | Architect Agent |
| Mean Time to Fix | <1 hour | Release Agent tracking |

---

## Conclusion

This agent-based workflow provides:

1. **Separation of Concerns**: Each agent has clear responsibilities
2. **Global State Awareness**: All changes tracked and validated
3. **Automated Quality**: Continuous validation at each step
4. **Documentation Sync**: Automatic updates prevent drift
5. **Cross-Platform Safety**: Build Agent ensures consistency
6. **Scalable Process**: Agents can run in parallel when independent

The key innovation is the **Global State Registry** maintained by the Architect Agent, which ensures that all agents are aware of the side effects of changes to shared state like `Board`, `Player_turn`, and `Hands`.
