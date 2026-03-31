# Bash Best Practices

## Project Context

This document defines bash scripting standards for the echeckers project build system located in `development/build_systems/`.

---

## General Guidelines

### 1. Script Structure

```bash
#!/usr/bin/env bash
#
# Script Name: [name]
# Description: [purpose]
# Usage: [command syntax]
#

set -euo pipefail  # Exit on error, undefined vars, pipe failures

# Constants
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Functions first, then main execution
main() {
    # Main logic here
}

main "$@"
```

### 2. Variable Declarations

```bash
# Use readonly for constants
readonly MAX_RETRIES=3
readonly BUILD_OUTPUT="processed_script.lua"

# Use local for function-scoped variables
my_function() {
    local temp_var="value"
    local -a array_var=()
}

# Use uppercase for global/exported variables
export BUILD_MODE="release"
```

### 3. Function Definitions

```bash
# Use snake_case for function names
# Include docstring comments
# Validate parameters early

build_step() {
    local step_name="$1"
    local config_file="$2"
    
    # Validate parameters
    if [[ -z "$step_name" ]]; then
        echo "ERROR: step_name is required" >&2
        return 1
    fi
    
    # Function logic
    echo "Building ${step_name}..."
}
```

### 4. Error Handling

```bash
# Always check return codes for critical operations
if ! command -v lua >/dev/null 2>&1; then
    echo "ERROR: lua is required but not installed" >&2
    exit 1
fi

# Use trap for cleanup
cleanup() {
    rm -f "$TEMP_FILE"
}
trap cleanup EXIT

# Provide meaningful error messages
log_error() {
    echo "ERROR: [$1] $2" >&2
}
```

### 5. String Handling

```bash
# Use double quotes for variables
echo "Building ${project_name}"

# Use single quotes for literals
readonly MESSAGE='Build completed successfully'

# Parameter expansion for defaults
output_dir="${OUTPUT_DIR:-./output}"

# String comparison with [[ ]]
if [[ "$status" == "success" ]]; then
    echo "Build succeeded"
fi
```

### 6. Array Operations

```bash
# Declare arrays explicitly
declare -a build_steps=()
declare -A build_configs=()  # Associative array

# Append to arrays
build_steps+=("step1" "step2")

# Iterate safely
for step in "${build_steps[@]}"; do
    echo "Processing: $step"
done

# Check array length
if [[ ${#build_steps[@]} -gt 0 ]]; then
    echo "Has ${#build_steps[@]} steps"
fi
```

### 7. File Operations

```bash
# Always check file existence
if [[ -f "$config_file" ]]; then
    source "$config_file"
fi

# Use mktemp for temporary files
TEMP_FILE="$(mktemp)" || exit 1

# Atomic writes with temp file
write_atomic() {
    local target="$1"
    local content="$2"
    local temp
    temp="$(mktemp)"
    echo "$content" > "$temp"
    mv "$temp" "$target"
}
```

### 8. Build System Specific

```bash
# Resolve project root reliably
resolve_project_root() {
    local script_dir
    script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    cd "$script_dir/../.." || exit 1
    pwd
}

# Count lines in files
count_lines() {
    local -a files=("$@")
    local total=0
    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            local count
            count=$(wc -l < "$file")
            total=$((total + count))
        fi
    done
    echo "$total"
}

# Format build output
print_build_header() {
    local step="$1"
    echo ""
    echo "========================================"
    echo "  STEP: $step"
    echo "========================================"
    echo ""
}
```

### 9. Cross-Platform Compatibility

```bash
# Detect OS
case "$(uname -s)" in
    Linux*)     OS="linux";;
    Darwin*)    OS="macos";;
    CYGWIN*)    OS="cygwin";;
    MINGW*)     OS="mingw";;
    *)          OS="unknown";;
esac

# Use portable commands
# Prefer: printf over echo -e
# Prefer: find -exec over xargs
# Prefer: $(...) over backticks
```

### 10. Documentation

```bash
# Include usage information
usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Build the echeckers game.

Options:
    -h, --help      Show this help message
    -v, --verbose   Enable verbose output
    -c, --clean     Clean build artifacts first

Examples:
    $(basename "$0") --verbose
    $(basename "$0") -c

EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            usage
            exit 0
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            echo "Unknown option: $1" >&2
            usage
            exit 1
            ;;
    esac
done
```

---

## Anti-Patterns to Avoid

```bash
# ❌ Don't: Unquoted variables
echo $variable

# ✅ Do: Quote variables
echo "$variable"

# ❌ Don't: Use backticks
result=`command`

# ✅ Do: Use $()
result=$(command)

# ❌ Don't: Ignore errors
some_command
next_command

# ✅ Do: Check errors
if ! some_command; then
    echo "Failed" >&2
    exit 1
fi

# ❌ Don't: Hardcode paths
cd /home/user/project

# ✅ Do: Use relative paths
cd "$(dirname "${BASH_SOURCE[0]}")/.."

# ❌ Don't: Parse ls output
for file in $(ls *.txt); do

# ✅ Do: Use globbing
for file in *.txt; do
```

---

## Testing Guidelines

```bash
# Test critical functions
test_build_step() {
    local result
    result=$(build_step "test" "test_config.txt")
    [[ "$result" == *"Building test"* ]] || return 1
}

# Run tests if TEST_MODE is set
if [[ "${TEST_MODE:-}" == "true" ]]; then
    test_build_step && echo "PASS" || echo "FAIL"
fi
```

---

## Version Control

- Keep scripts under 500 lines when possible
- Split large scripts into modular functions
- Document all public functions
- Include examples in comments
- Test on both Linux and macOS when possible
