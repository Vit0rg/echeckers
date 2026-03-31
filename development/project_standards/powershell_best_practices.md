# PowerShell Best Practices

## Project Context

This document defines PowerShell scripting standards for the echeckers project build system located in `development/build_systems/`.

---

## General Guidelines

### 1. Script Structure

```powershell
<#
.SYNOPSIS
    Build the echeckers game

.DESCRIPTION
    Processes Lua source files into bundled output

.PARAMETER Verbose
    Enable verbose output

.PARAMETER Clean
    Clean build artifacts first

.EXAMPLE
    .\build.ps1 -Verbose
#>

[CmdletBinding()]
param(
    [switch]$Verbose,
    [switch]$Clean
)

#Requires -Version 5.1

# Constants
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

# Functions first, then main execution
function Main {
    # Main logic here
}

Main
```

### 2. Variable Declarations

```powershell
# Use PascalCase for variables
$BuildOutput = "processed_script.lua"
$MaxRetries = 3

# Use const-like pattern for true constants
$Script:READONLY_CONFIG = @{
    MaxLines = 1000
    Timeout = 30
}

# Use appropriate scopes
function Build-Step {
    param($Name)
    
    # Local variables (default)
    $localVar = "value"
    
    # Script-scoped if needed
    $script:counter++
}
```

### 3. Function Definitions

```powershell
# Use Verb-Noun naming convention
# Include comment-based help
# Validate parameters with attributes

function Build-Step {
    <#
    .SYNOPSIS
        Execute a single build step
    
    .PARAMETER StepName
        Name of the build step
    
    .PARAMETER ConfigFile
        Path to configuration file
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$StepName,
        
        [Parameter(Mandatory=$true)]
        [ValidateScript({ Test-Path $_ })]
        [string]$ConfigFile
    )
    
    begin {
        Write-Verbose "Starting build step: $StepName"
    }
    
    process {
        # Build logic here
        Write-Host "Building $StepName..."
    }
    
    end {
        Write-Verbose "Completed build step: $StepName"
    }
}
```

### 4. Error Handling

```powershell
# Use Try-Catch-Finally
try {
    $result = Invoke-Command -ScriptBlock { ... }
}
catch [System.Exception] {
    Write-Error "Build failed: $_"
    exit 1
}
finally {
    # Cleanup
    Remove-Item $tempFile -ErrorAction SilentlyContinue
}

# Use Write-Error for errors
function Test-Dependency {
    param($Name)
    
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        Write-Error "Required dependency not found: $Name"
        return $false
    }
    return $true
}

# Use throw for terminating errors
function Validate-Config {
    param($Config)
    
    if ($null -eq $Config) {
        throw "Configuration cannot be null"
    }
}
```

### 5. String Handling

```powershell
# Use double quotes for interpolation
$message = "Building $projectName version $version"

# Use single quotes for literals
$literal = 'No $variable expansion here'

# Use here-strings for multi-line
$helpText = @"
Usage: build.ps1 [options]

Options:
  -Verbose  Enable verbose output
  -Clean    Clean before building
"@

# Use -f for formatting
$formatted = "Files: {0}, Lines: {1}" -f $fileCount, $lineCount
```

### 6. Array and Collection Operations

```powershell
# Use generic lists for performance
$buildSteps = [System.Collections.Generic.List[string]]::new()
$buildSteps.Add("step1")
$buildSteps.Add("step2")

# Use foreach for iteration
foreach ($step in $buildSteps) {
    Write-Host "Processing: $step"
}

# Use pipeline for transformations
$luaFiles = Get-ChildItem -Path $sourceDir -Filter *.lua |
    Select-Object -ExpandProperty FullName

# Use hashtable for dictionaries
$buildConfigs = @{
    Main = "build_main.txt"
    Battle = "build_battle.txt"
}
```

### 7. File Operations

```powershell
# Use Test-Path before operations
if (Test-Path $configFile) {
    $config = Get-Content $configFile
}

# Use Join-Path for paths
$outputPath = Join-Path $ProjectRoot "game" "processed_script.lua"

# Use Temp path for temporary files
$tempFile = [System.IO.Path]::GetTempFileName()

# Atomic writes
function Write-Atomic {
    param($Path, $Content)
    $tempPath = [System.IO.Path]::GetTempFileName()
    Set-Content -Path $tempPath -Value $Content
    Move-Item -Path $tempPath -Destination $Path -Force
}
```

### 8. Build System Specific

```powershell
# Resolve project root
function Get-ProjectRoot {
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    Split-Path -Parent (Split-Path -Parent $scriptDir)
}

# Count lines in files
function Get-TotalLineCount {
    param([string[]]$Files)
    
    $total = 0
    foreach ($file in $Files) {
        if (Test-Path $file) {
            $lines = (Get-Content $file).Count
            $total += $lines
        }
    }
    return $total
}

# Format build output
function Write-BuildHeader {
    param([string]$Step)
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "  STEP: $Step" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
}

# Process build configuration
function Get-BuildFiles {
    param([string]$ConfigPath)
    
    $files = @()
    Get-Content $ConfigPath | ForEach-Object {
        $line = $_.Trim()
        if ($line -and $line -notlike '#*') {
            $files += $line
        }
    }
    return $files
}
```

### 9. Cross-Platform Compatibility

```powershell
# Use PowerShell Core compatible features
# Avoid Windows-specific cmdlets when possible

# Check PowerShell version
if ($PSVersionTable.PSVersion.Major -lt 5) {
    Write-Error "PowerShell 5.1 or higher required"
    exit 1
}

# Use cross-platform paths
$separator = [System.IO.Path]::DirectorySeparatorChar
$path = "game${separator}battle${separator}processed_battle.lua"

# Better: Use Join-Path
$path = Join-Path "game" (Join-Path "battle" "processed_battle.lua")
```

### 10. Output and Logging

```powershell
# Use Write-Host for user-facing output
Write-Host "Build completed successfully" -ForegroundColor Green

# Use Write-Verbose for debug info
Write-Verbose "Processing file: $file"

# Use Write-Warning for warnings
Write-Warning "Missing optional file: $file"

# Use Write-Error for errors
Write-Error "Critical failure: $error"

# Use Write-Progress for long operations
Write-Progress -Activity "Building" -Status $step -PercentComplete $percent
```

---

## Anti-Patterns to Avoid

```powershell
# ❌ Don't: Use aliases in scripts
ls | % { $_.Name }

# ✅ Do: Use full cmdlet names
Get-ChildItem | ForEach-Object { $_.Name }

# ❌ Don't: Ignore errors
Get-Content $file
# (continues on error)

# ✅ Do: Handle errors
try {
    Get-Content $file -ErrorAction Stop
} catch {
    Write-Error "File not found: $file"
}

# ❌ Don't: Parse command output
$files = (dir).Name

# ✅ Do: Use object properties
$files = Get-ChildItem | Select-Object -ExpandProperty Name

# ❌ Don't: Hardcode paths
cd C:\Users\Name\project

# ✅ Do: Use relative paths
Set-Location (Split-Path -Parent $MyInvocation.MyCommand.Path)

# ❌ Don't: Use Write-Output unnecessarily
function Get-Value {
    Write-Output $value
}

# ✅ Do: Implicit output
function Get-Value {
    $value
}
```

---

## Module Pattern

```powershell
# For reusable build functions
$BuildModule = @{
    BuildStep = {
        param($Name, $Config)
        # Implementation
    }
    
    CountLines = {
        param($Files)
        # Implementation
    }
}

# Usage
& $BuildModule.BuildStep -Name "Main" -Config $mainConfig
```

---

## Testing Guidelines

```powershell
# Use Pester for testing
Describe "Build Functions" {
    It "Should count lines correctly" {
        $result = Get-TotalLineCount -Files @("test.lua")
        $result | Should -BeGreaterThan 0
    }
    
    It "Should handle missing files" {
        { Get-TotalLineCount -Files @("missing.lua") } | 
            Should -Not -Throw
    }
}

# Run tests
Invoke-Pester -Path ./tests
```

---

## Version Control

- Keep scripts under 500 lines when possible
- Use modules for reusable functions
- Include comment-based help for all public functions
- Test on Windows PowerShell and PowerShell Core
- Use consistent formatting (use PowerShell ScriptAnalyzer)
