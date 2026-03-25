# Multi-step build system for echeckers
# Builds main game and battle module separately

$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
Set-Location $scriptDir

# Build configurations
$builds = @{
    "main"   = @{ Config = "build_main.txt"; Target = "processed_script.lua" }
    "battle" = @{ Config = "build_battle.txt"; Target = "battle\processed_battle.lua" }
}

$buildFailed = $false

function Build-Step {
    param(
        [string]$Name,
        [string]$ConfigFile,
        [string]$Target
    )
    
    Write-Output "========================================"
    Write-Output "BUILD STEP: $Name"
    Write-Output "Config: $ConfigFile -> Output: $Target"
    Write-Output "========================================"
    
    if (-not (Test-Path $ConfigFile -PathType Leaf)) {
        Write-Output "ERROR: Config file not found: $ConfigFile"
        return $false
    }
    
    $filesToProcess = @()
    $entries = Get-Content -Path $ConfigFile | Where-Object { $_ -and -not $_.StartsWith("#") }
    
    foreach ($entry in $entries) {
        $entry = $entry.Trim()
        
        if ([string]::IsNullOrWhiteSpace($entry)) {
            continue
        }
        
        $fullPath = Join-Path -Path $scriptDir -ChildPath $entry
        
        if (Test-Path $fullPath -PathType Container) {
            $files = Get-ChildItem -Path $fullPath -File -Filter "*.lua" -Recurse
            $filesToProcess += $files.FullName
        } elseif (Test-Path $fullPath -PathType Leaf) {
            $filesToProcess += $fullPath
        } else {
            Write-Output "WARNING: File not found: $fullPath"
        }
    }
    
    Write-Output ""
    Write-Output "Files to concatenate ($($filesToProcess.Count)):"
    foreach ($item in $filesToProcess) {
        Write-Output "  $item"
    }
    Write-Output ""
    
    # Build the output
    Set-Content -Path $Target -Value ""
    foreach ($file in $filesToProcess) {
        Add-Content -Path $Target -Value "-- $file"
        Add-Content -Path $Target -Value (Get-Content -Path $file -Raw)
        Add-Content -Path $Target -Value ""
    }
    
    $lineCount = (Get-Content $Target | Measure-Object -Line).Lines
    Write-Output "Output: $Target ($lineCount lines)"
    Write-Output ""
    
    return $true
}

# Run build steps
foreach ($name in $builds.Keys) {
    $config = $builds[$name].Config
    $target = $builds[$name].Target
    
    if (-not (Build-Step -Name $name -ConfigFile $config -Target $target)) {
        $buildFailed = $true
    }
}

Write-Output "========================================"
if ($buildFailed) {
    Write-Output "BUILD FAILED: One or more steps failed"
} else {
    Write-Output "BUILD COMPLETE: All steps succeeded"
}
Write-Output "========================================"

if ($buildFailed) {
    exit 1
}
