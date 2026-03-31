# Commit Checklist

A checklist of steps to follow when committing changes to the echeckers project.

---

## Pre-Commit Steps

### 1. Update Documentation
- [ ] Update `development/TODO_macro.md` with completed tasks
- [ ] Update `development/TODO_micro.md` with detailed progress
- [ ] Append changes to `development/changelog.md` with proper Step title
- [ ] Update `README.md` if project structure or build process changed
- [ ] Create/update relevant documentation files (e.g., `project_architecture.md`)

### 2. Code Quality Checks
- [ ] Run build system and verify no errors: `./development/build_systems/build_system`
- [ ] Verify build outputs are correct (file count, line count)
- [ ] Check for any WARNING messages in build output
- [ ] Fix any missing file references in build configuration

### 3. Build Configuration Updates
- [ ] Update `development/build_systems/build_main.txt` if source files changed
- [ ] Update `development/build_systems/build_battle.txt` if battle files changed
- [ ] Update `development/build_systems/build_system` if path resolution changed
- [ ] Update `development/build_systems/build.ps1` for Windows compatibility

### 4. File Organization
- [ ] Ensure source files are in `game/` folder
- [ ] Ensure development files are in `development/` folder
- [ ] Verify no development files in source tree
- [ ] Check that build outputs go to `game/` folder

### 5. Git Hygiene
- [ ] Run `git status` to review all changes
- [ ] Verify file movements are detected as renames (not delete + add)
- [ ] Check for any unintended changes
- [ ] Stage all changes: `git add -A`
- [ ] Review staged changes: `git status`

---

## Commit Message Format

### Structure
```
Step X: [Short title describing the change]

[Optional blank line]

[Bulleted list of key changes]
- Change 1
- Change 2
- Change 3

[Optional blank line]

[Benefits/Impact section if applicable]
```

### Examples

**Example 1 - Architecture Change:**
```
Step 8: Source code and development separation

- Created game/ folder for all runtime source code
- Created development/ folder for build tools and documentation
- Updated build system to use game/ folder exclusively
- Created development/project_architecture.md

Architecture Benefits:
- Clean separation between deployable and development files
- Easier deployment - only game/ folder needed
- Better organization with clear boundaries

Co-authored-by: Qwen-Coder <qwen-coder@alibabacloud.com>
```

**Example 2 - Feature Implementation:**
```
Step 6.5: Flat board structure for simpler access and less redundancy

- Replaced nested tables with flat table structure
- Added helper functions for index mapping
- Removed redundant Board.layout table
- Updated UI rendering to use new structure

Co-authored-by: Qwen-Coder <qwen-coder@alibabacloud.com>
```

---

## Commit Execution

### Author Information
- Use `--author="Vit0rg <vgois032@gmail.com>"` for all commits
- Include `Co-authored-by` for AI-assisted work

### Command Template
```bash
git commit -m "Step X: [Title]

[Bulleted list of changes]

[Benefits/Impact]

Co-authored-by: Qwen-Coder <qwen-coder@alibabacloud.com>" --author="Vit0rg <vgois032@gmail.com>"
```

---

## Post-Commit Steps

### 1. Verify Commit
- [ ] Run `git status` - should show clean working tree
- [ ] Run `git log -n 1` - verify commit message and author
- [ ] Check branch status: `git status` (should show "ahead by 1 commit")

### 2. Update Tracking
- [ ] Mark completed items in `development/TODO_macro.md`
- [ ] Add new tasks if discovered during commit
- [ ] Update any related tracking documents

### 3. Prepare for Next Session
- [ ] Note any incomplete work for next session
- [ ] Document any known issues or TODOs
- [ ] Ensure build passes with committed changes

---

## Common Patterns

### When Moving Files
1. Update all path references in build configs
2. Update documentation (README, architecture docs)
3. Update changelog with file movements section
4. Verify git detects moves as renames

### When Adding Features
1. Add source files to appropriate `game/` subfolder
2. Update `build_*.txt` if new files need building
3. Update TODO_macro.md with completed feature
4. Document in changelog under new Step entry

### When Refactoring
1. Verify all renames are tracked by git
2. Update any affected documentation
3. Test build after refactoring
4. Document benefits in changelog

---

## Quick Reference

```bash
# Check status before commit
git status

# Stage all changes
git add -A

# Verify staged changes
git status

# View diff of staged changes
git diff --staged

# Commit with proper format
git commit -m "Step X: Title

- Change 1
- Change 2

Co-authored-by: Qwen-Coder <qwen-coder@alibabacloud.com>" --author="Vit0rg <vgois032@gmail.com>"

# Verify commit
git log -n 1 --format="%h %an <%ae> - %s"
git status
```

---

## Notes

- Always test build before committing
- Keep commit messages concise but informative
- One logical change per commit
- Use Step numbering consistently (Step 8, Step 8.1, etc.)
- Document benefits, not just changes
- Ensure development/ and game/ separation is maintained
